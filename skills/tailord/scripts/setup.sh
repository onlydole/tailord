#!/usr/bin/env bash
# Setup for the tailord writing skill.
# Installs prerequisites, creates system symlinks, copies templates, and prints next steps.

set -euo pipefail

script_dir="$(cd "$(dirname "$0")" && pwd)"
skill_dir="$script_dir/.."
skill_vale_dir="$skill_dir/vale"
refs_dir="$skill_dir/references"
vocab_dir="$skill_vale_dir/styles/config/vocabularies/AuthenticVoice"

case "$(uname -s)" in
  Darwin)
    system_vale_dir="$HOME/Library/Application Support/vale"
    ;;
  Linux)
    system_vale_dir="${XDG_CONFIG_HOME:-$HOME/.config}/vale"
    ;;
  *)
    echo "Warning: Unsupported OS. Symlinks skipped." >&2
    exit 0
    ;;
esac

echo "Tailord skill setup"
echo "==================="
echo

# Source shared prerequisites and run all checks
# shellcheck source=prereqs.sh
source "$script_dir/prereqs.sh"
ensure_prerequisites

echo "vale $(vale --version) found."
echo "Google style synced."
echo

# Create system symlinks (idempotent, backs up before replacing)
setup_symlink() {
  local target="$1"
  local link="$2"
  local name="$3"

  if [[ -L "$link" ]]; then
    local current
    current="$(readlink "$link")"
    if [[ "$current" == "$target" ]]; then
      echo "  $name: symlink already correct"
      return 0
    fi
    echo "  $name: updating symlink (was -> $current)"
    rm "$link"
  elif [[ -e "$link" ]]; then
    local backup="${link}.bak.$(date +%Y%m%d%H%M%S)"
    echo "  $name: backing up to ${backup##*/}"
    mv "$link" "$backup"
  fi
  ln -s "$target" "$link"
  echo "  $name: symlinked -> $target"
}

echo "Setting up system symlinks..."
mkdir -p "$system_vale_dir"
setup_symlink "$skill_vale_dir/.vale.ini" "$system_vale_dir/.vale.ini" ".vale.ini"
setup_symlink "$skill_vale_dir/styles" "$system_vale_dir/styles" "styles/"
echo

# Copy templates if personal files don't exist yet
copy_template() {
  local template="$1"
  local target="$2"
  local name="$3"

  if [[ -f "$target" ]]; then
    echo "  $name: already exists (skipping)"
  else
    cp "$template" "$target"
    echo "  $name: created from template"
  fi
}

echo "Setting up personal files..."
copy_template "$refs_dir/voice.template.md" "$refs_dir/voice.md" "voice.md"
copy_template "$refs_dir/reference-personal.template.md" "$refs_dir/reference-personal.md" "reference-personal.md"

if [[ ! -f "$vocab_dir/accept.local.txt" ]] && [[ -f "$vocab_dir/accept.local.txt.example" ]]; then
  cp "$vocab_dir/accept.local.txt.example" "$vocab_dir/accept.local.txt"
  echo "  accept.local.txt: created from example"
else
  echo "  accept.local.txt: already exists (skipping)"
fi
echo

# Print status
echo "Done. Prerequisites auto-installed, system config symlinked."
echo
echo "Next steps"
echo "----------"
echo "1. Edit references/voice.md with your identity, audience, and platform."
echo "   The HTML comment at the top explains what to customize."
echo "2. Edit references/reference-personal.md with your voice patterns and editorial learnings."
echo "3. Add personal names/terms to vale/styles/config/vocabularies/AuthenticVoice/accept.local.txt"
echo "   to suppress false spelling errors."
echo "4. Run scripts/lint.sh <your-draft.md> to lint against AuthenticVoice rules."
echo
