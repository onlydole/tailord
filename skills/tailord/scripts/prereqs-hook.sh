#!/usr/bin/env bash
# Hook-compatible wrapper around prereqs.sh for SessionStart.
# Detect-only — never installs. If vale is present, also syncs Google styles
# (lightweight, idempotent). If vale is missing, surfaces a systemMessage with
# install instructions so the user can install before /tailord runs lint.

set -euo pipefail

script_dir="$(cd "$(dirname "$0")" && pwd)"

# shellcheck source=prereqs.sh
source "$script_dir/prereqs.sh"

if check_vale_cli; then
  # Vale is installed. Sync Google styles and stamp version if needed.
  if ensure_prerequisites; then
    vale_version="$(vale --version 2>/dev/null || echo "unknown")"
    cat <<EOF
{"systemMessage":"tailord prerequisites verified. vale ${vale_version} ready. AuthenticVoice rules loaded."}
EOF
  else
    cat <<EOF
{"systemMessage":"tailord: vale is installed but Google style sync failed. Run scripts/setup.sh to repair."}
EOF
  fi
else
  # Vale is missing. Surface install hint without installing.
  cat <<'EOF'
{"systemMessage":"tailord: vale CLI not detected. The /tailord skill will prompt you to install before its first lint pass, or install ahead of time: brew install vale (macOS) / snap install vale (Linux). Or run scripts/setup.sh from the plugin directory for a full setup."}
EOF
fi
