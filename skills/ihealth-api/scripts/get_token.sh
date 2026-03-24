#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME="${IHEALTH_KEYCHAIN_SERVICE:-openclaw-ihealth}"
CLIENT_ID_ACCOUNT="${IHEALTH_CLIENT_ID_ACCOUNT:-client_id}"
CLIENT_SECRET_ACCOUNT="${IHEALTH_CLIENT_SECRET_ACCOUNT:-client_secret}"
TOKEN_URL="https://identity.account.f5.com/oauth2/ausp95ykc80HOU7SQ357/v1/token"

CLIENT_ID="$(security find-generic-password -a "$CLIENT_ID_ACCOUNT" -s "$SERVICE_NAME" -w)"
CLIENT_SECRET="$(security find-generic-password -a "$CLIENT_SECRET_ACCOUNT" -s "$SERVICE_NAME" -w)"
BASIC="$(printf '%s:%s' "$CLIENT_ID" "$CLIENT_SECRET" | base64 | tr -d '\n')"

curl -sS --request POST \
  --url "$TOKEN_URL" \
  -H "accept: application/json" \
  -H "authorization: Basic $BASIC" \
  -H "content-type: application/x-www-form-urlencoded" \
  --data 'grant_type=client_credentials&scope=ihealth'
