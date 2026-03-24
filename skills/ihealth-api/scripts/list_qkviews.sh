#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TOKEN="$($SCRIPT_DIR/get_token.sh | jq -r '.access_token')"

if [[ -z "$TOKEN" || "$TOKEN" == "null" ]]; then
  echo "Failed to obtain access token" >&2
  exit 1
fi

curl -sS \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.f5.ihealth.api" \
  --user-agent "OpenClaw" \
  https://ihealth2-api.f5.com/qkview-analyzer/api/qkviews
