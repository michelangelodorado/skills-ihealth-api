---
name: ihealth-api
description: Work with the F5 iHealth REST API for QKView operations and related diagnostics. Use when connecting to the iHealth API, generating bearer tokens from locally stored credentials, listing QKViews, fetching QKView details, or building small scripts/workflows around the F5 iHealth endpoints. Prefer this skill when the user references ihealth2.f5.com, qkview-analyzer, QKViews, or F5 iHealth API docs.
---

# iHealth API

Use this skill to handle routine F5 iHealth API work safely and consistently.

## Overview

The iHealth API uses short-lived bearer tokens obtained from an F5 Client ID and Client Secret. Do not store live credentials in the skill, chat history, or workspace files. Read them ephemerally from macOS Keychain at runtime.

Default assumptions:
- OS is macOS.
- Secrets live in macOS Keychain under service `openclaw-ihealth`.
- Account names are `client_id` and `client_secret`.
- Tokens are valid for about 30 minutes.

## Supported Operations

- Add QKView (upload)
- Delete QKView
- Toggle QKView’s visibility in the GUI
- Retrieve previously uploaded QKView
- List QKViews
- Get API version / parameters
- Open a support case
- Get End of Life data for F5 products
- Retrieve iHealth diagnostic data
- Retrieve files
- Retrieve tmsh command output subset
- Retrieve QKView metadata
- Log search

## Workflow

1. Confirm the task.
   - Supported: get token, list/add/delete/toggle QKViews, inspect/upload, search logs, fetch diagnostics/metadata/files, open cases, get EOL, get API version.
2. Read credentials from Keychain at runtime.
3. Exchange credentials for a bearer token.
4. Call the required iHealth endpoint or use the provided script stub.
5. Do not print secrets unless the user explicitly asks and understands the risk.
6. If a credential was pasted into chat, tell the user to rotate it.

## Keychain storage convention

Prefer this exact convention:

```bash
security add-generic-password -a client_id -s openclaw-ihealth -w 'CLIENT_ID' -U
security add-generic-password -a client_secret -s openclaw-ihealth -w 'CLIENT_SECRET' -U
```

Read them with:

```bash
security find-generic-password -a client_id -s openclaw-ihealth -w
security find-generic-password -a client_secret -s openclaw-ihealth -w
```

## Token flow

Use `scripts/get_token.sh`.

Token endpoint:

- `https://identity.account.f5.com/oauth2/ausp95ykc80HOU7SQ357/v1/token`

Grant request:
- `grant_type=client_credentials`
- `scope=ihealth`

## Common endpoints

### List QKViews

Use `scripts/list_qkviews.sh`.

Endpoint:
- `GET https://ihealth2-api.f5.com/qkview-analyzer/api/qkviews`

Headers:
- `Authorization: Bearer <token>`
- `Accept: application/vnd.f5.ihealth.api`
- `User-Agent: OpenClaw`

## Troubleshooting

- `403 Forbidden`: token invalid, expired, or wrong scope.
- `406 Not Acceptable`: missing or wrong `Accept` header.
- Empty/odd output: inspect raw response first before adding `jq`.
- Keychain lookup failure: verify service/account names exactly.

## Safety rules

- Never write client secrets into SKILL.md, references, or memory files.
- Never recommend pasting long-lived secrets into chat.
- Treat bearer tokens as sensitive too.
- If the user exposed a secret in chat, recommend rotation.

## References

Read `references/api-notes.md` if you need the documented auth or collection method details.
