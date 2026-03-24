# iHealth API notes

## Auth

Generate Client ID and Client Secret from the iHealth settings page.

Token endpoint:
- `https://identity.account.f5.com/oauth2/ausp95ykc80HOU7SQ357/v1/token`

Request pattern:
- Basic auth uses `base64(client_id:client_secret)`
- Body: `grant_type=client_credentials&scope=ihealth`
- Response includes `access_token`, `token_type`, `expires_in`

## QKView collection

List endpoint:
- `GET https://ihealth2-api.f5.com/qkview-analyzer/api/qkviews`

Expected headers:
- `Authorization: Bearer <token>`
- `Accept: application/vnd.f5.ihealth.api`
- `User-Agent: OpenClaw`

Docs referenced:
- Authentication: `https://clouddocs.f5.com/api/ihealth/Authentication.html`
- QKView collection methods: `https://clouddocs.f5.com/api/ihealth/QKView_Collection_Methods.html`

## Notes

- Bearer tokens expire after about 30 minutes.
- A `403` usually means token/auth trouble.
- A `406` usually means the `Accept` header is wrong or missing.
- Never store the client secret in skill files.
