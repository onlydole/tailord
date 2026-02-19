#!/usr/bin/env bash
# Lint a draft using vale with AuthenticVoice rules.
# Usage: scripts/lint.sh [--skip-prereqs] <file>
#
# Uses --no-global to prevent vale's config cascade from merging the
# system-wide config. The skill's vale/.vale.ini is the sole source of truth.
#
# Merges accept.txt + accept.local.txt into accept.merged.txt before running
# vale, so personal vocabulary terms are included in the lint pass.
#
# Exit codes:
#   0 — vale ran successfully (JSON output may contain findings)
#   1 — usage error or prerequisite failure
#   >1 — vale configuration or runtime error

set -euo pipefail

script_dir="$(cd "$(dirname "$0")" && pwd)"
config="$script_dir/../vale/.vale.ini"
vocab_dir="$script_dir/../vale/styles/config/vocabularies/AuthenticVoice"

# Parse flags
skip_prereqs=false
while [[ "${1:-}" == --* ]]; do
  case "$1" in
    --skip-prereqs) skip_prereqs=true; shift ;;
    *) echo "Unknown flag: $1" >&2; exit 1 ;;
  esac
done

if [ -z "${1:-}" ]; then
  echo "Usage: $0 [--skip-prereqs] <file>" >&2
  exit 1
fi

# Ensure prerequisites unless skipped (useful for repeated runs)
if [[ "$skip_prereqs" == "false" ]]; then
  # shellcheck source=prereqs.sh
  source "$script_dir/prereqs.sh"
  ensure_prerequisites
fi

# Merge accept.txt + accept.local.txt into accept.merged.txt
# Vale only reads a single accept.txt per vocabulary, so we merge before running.
if [[ -f "$vocab_dir/accept.local.txt" ]]; then
  # Filter out comments and blank lines from accept.local.txt, merge, sort, dedupe
  { cat "$vocab_dir/accept.txt"; grep -v '^#' "$vocab_dir/accept.local.txt" | grep -v '^$'; } \
    | sort -u > "$vocab_dir/accept.merged.txt"
  # Temporarily swap accept.txt with merged version
  cp "$vocab_dir/accept.txt" "$vocab_dir/accept.txt.bak"
  cp "$vocab_dir/accept.merged.txt" "$vocab_dir/accept.txt"
  trap 'mv "$vocab_dir/accept.txt.bak" "$vocab_dir/accept.txt"; rm -f "$vocab_dir/accept.merged.txt"' EXIT
fi

# Vale exits 1 when findings exist — this is expected, not a failure.
# Disable errexit for the vale call so findings produce JSON output
# without the script appearing to fail.
set +e
vale --no-global --config="$config" --output=JSON "$1"
vale_exit=$?
set -e

if [[ $vale_exit -gt 1 ]]; then
  exit $vale_exit
fi
