#!/usr/bin/env bash
set -euo pipefail

QKVIEW_ID="$1"
if [[ -z "$QKVIEW_ID" ]]; then
  echo "Usage: $0 <qkview_id>"
  exit 1
fi

SCRIPT_DIR="$(dirname "$0")"
TOKEN_JSON="$($SCRIPT_DIR/get_token.sh)"
TOKEN="$(echo "$TOKEN_JSON" | jq -r '.access_token')"

API_URL="https://ihealth2-api.f5.com/qkview-analyzer/api/qkviews/$QKVIEW_ID/commands"

curl -sS --request GET \
  --url "$API_URL" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.f5.ihealth.api+json" \
  -H "User-Agent: OpenClaw" | jq -r '.command[] | "ID: \(.id) | Command: \(.name) | Status: \(.status)"'
