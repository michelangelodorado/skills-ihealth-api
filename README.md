# ihealth-api OpenClaw skill

A reusable OpenClaw skill for working with the F5 iHealth API.

## Included

- `skills/ihealth-api/SKILL.md`
- `skills/ihealth-api/scripts/get_token.sh`
- `skills/ihealth-api/scripts/list_qkviews.sh`
- `skills/ihealth-api/references/api-notes.md`

## Security

Do not store live credentials in this repository.

Recommended setup on macOS Keychain:

```bash
security add-generic-password -a client_id -s openclaw-ihealth -w 'CLIENT_ID' -U
security add-generic-password -a client_secret -s openclaw-ihealth -w 'CLIENT_SECRET' -U
```

The included scripts read credentials from Keychain at runtime.

## Usage

List QKViews:

```bash
./skills/ihealth-api/scripts/list_qkviews.sh
```
