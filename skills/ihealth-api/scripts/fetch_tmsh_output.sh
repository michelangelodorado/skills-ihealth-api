#!/usr/bin/env bash
set -euo pipefail

QKVIEW_ID="$1"
COMMAND_HASH="$2"
if [[ -z "$QKVIEW_ID" || -z "$COMMAND_HASH" ]]; then
  echo "Usage: $0 <qkview_id> <command_hash>"
  exit 1
fi

SCRIPT_DIR="$(dirname "$0")"
TOKEN_JSON="$($SCRIPT_DIR/get_token.sh)"
TOKEN="$(echo "$TOKEN_JSON" | jq -r '.access_token')"

API_URL="https://ihealth2-api.f5.com/qkview-analyzer/api/qkviews/$QKVIEW_ID/commands/$COMMAND_HASH"

raw_out=$(curl -sS --request GET \
  --url "$API_URL" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.f5.ihealth.api+json" \
  -H "User-Agent: OpenClaw")

status=$(echo "$raw_out" | jq -r '.status')
if [[ "$status" != "0" ]]; then
  echo "No output available or error (status=$status) for command hash $COMMAND_HASH"
  exit 2
fi

b64body=$(echo "$raw_out" | jq -r '.body')
if [[ "$b64body" == "null" ]]; then
  echo "Output is empty for command hash $COMMAND_HASH"
  exit 3
fi

echo "$b64body" | base64 --decode
