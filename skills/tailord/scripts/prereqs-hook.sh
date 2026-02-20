#!/usr/bin/env bash
# Hook-compatible wrapper around prereqs.sh for SessionStart.
# Sources the shared prereqs library and runs ensure_prerequisites,
# then outputs a JSON systemMessage for the Claude Code hook system.

set -euo pipefail

script_dir="$(cd "$(dirname "$0")" && pwd)"

# Source shared prerequisites
# shellcheck source=prereqs.sh
source "$script_dir/prereqs.sh"

# Run all prerequisite checks (installs vale, syncs Google styles if needed)
if ensure_prerequisites; then
  vale_version="$(vale --version 2>/dev/null || echo "unknown")"
  cat <<EOF
{"systemMessage":"tailord prerequisites verified. vale ${vale_version} ready. AuthenticVoice rules loaded."}
EOF
else
  cat <<EOF
{"systemMessage":"tailord prerequisite check had issues. Vale may need manual installation. Run skills/tailord/scripts/setup.sh for full setup."}
EOF
fi
