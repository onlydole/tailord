#!/usr/bin/env bash
# Shared prerequisite checks for the tailord skill.
# Sourced by lint.sh and setup.sh — not executed directly.
#
# Functions:
#   ensure_prerequisites  — orchestrator (call this one)
#   check_vale_cli / install_vale_cli
#   check_google_styles / sync_google_styles
#   check_version / stamp_version

SKILL_VALE_VERSION="2.1.0"

# Resolve paths relative to this script (scripts/ dir)
_prereqs_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_prereqs_vale_dir="$_prereqs_script_dir/../vale"
_prereqs_version_file="$_prereqs_vale_dir/.version"
_prereqs_config="$_prereqs_vale_dir/.vale.ini"

# ---------- vale CLI ----------

check_vale_cli() {
  command -v vale &>/dev/null
}

install_vale_cli() {
  echo "vale CLI not found. Installing..." >&2
  if [[ "$(uname -s)" == "Darwin" ]]; then
    if command -v brew &>/dev/null; then
      brew install vale >&2
    else
      echo "Error: Homebrew not found. Install vale manually: https://vale.sh/docs/install" >&2
      return 1
    fi
  else
    # Linux: try snap, fall back to binary download
    if command -v snap &>/dev/null; then
      sudo snap install vale >&2
    elif command -v curl &>/dev/null; then
      echo "Downloading vale binary..." >&2
      local tmp
      tmp="$(mktemp -d)"
      curl -sL "https://github.com/errata-ai/vale/releases/latest/download/vale_$(uname -s)_$(uname -m).tar.gz" \
        | tar xz -C "$tmp"
      install -m 755 "$tmp/vale" /usr/local/bin/vale
      rm -rf "$tmp"
    else
      echo "Error: No package manager found. Install vale manually: https://vale.sh/docs/install" >&2
      return 1
    fi
  fi
  echo "vale $(vale --version) installed." >&2
}

# ---------- Google styles ----------

check_google_styles() {
  [[ -d "$_prereqs_vale_dir/styles/Google" ]] && [[ -f "$_prereqs_vale_dir/styles/Google/Headings.yml" ]]
}

sync_google_styles() {
  echo "Syncing vale packages (Google style)..." >&2
  (cd "$_prereqs_vale_dir" && vale --no-global sync) >&2
  echo "Google style synced." >&2
}

# ---------- Version tracking ----------

check_version() {
  [[ -f "$_prereqs_version_file" ]] && [[ "$(cat "$_prereqs_version_file")" == "$SKILL_VALE_VERSION" ]]
}

stamp_version() {
  echo "$SKILL_VALE_VERSION" > "$_prereqs_version_file"
}

# ---------- Orchestrator ----------

ensure_prerequisites() {
  if ! check_vale_cli; then
    install_vale_cli || return 1
  fi

  local needs_sync=false

  if ! check_google_styles; then
    needs_sync=true
  fi

  if ! check_version; then
    needs_sync=true
  fi

  if [[ "$needs_sync" == "true" ]]; then
    sync_google_styles || return 1
    stamp_version
  fi
}
