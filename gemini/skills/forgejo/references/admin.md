# Forgejo Admin Commands

If you have shell access to the host machine running the Forgejo Docker container, you can
use the built-in `forgejo admin` CLI to manage users and tokens directly.

*Note: The exact docker container name and user ID might vary depending on the deployment.*

## Creating a User and Token

To create a new user (with a random password) and immediately generate an access token for
them, run a command similar to this inside the container:

```bash
docker exec -u <USER_ID> <CONTAINER_NAME> forgejo admin user create \
  --username <USERNAME> \
  --email "<USERNAME>@localhost" \
  --random-password \
  --random-password-length 32 \
  --must-change-password=false \
  --access-token \
  --access-token-name <TOKEN_NAME> \
  --access-token-scopes all \
  --config /data/gitea/conf/app.ini
```

## Other Admin Commands

- **List users:**
  `docker exec -u <USER_ID> <CONTAINER_NAME> forgejo admin user list --config /data/gitea/conf/app.ini`
- **Change password:**
  `docker exec -u <USER_ID> <CONTAINER_NAME> forgejo admin user change-password --username <USERNAME> --password "<NEW_PASSWORD>" --config /data/gitea/conf/app.ini`

## User Avatars

Forgejo does not currently support updating user avatars via the `tea-cli` or the
`forgejo admin` command. To update a user's avatar (especially for robot accounts), use the
REST API with the `Sudo` header.

**Requirements:**

- A Personal Access Token for a site administrator.
- The image file must be base64 encoded when sent via JSON.

**Example (Update another user's avatar):**

```bash
# 1. Get the admin token (e.g., from ~/.config/bbwf/forgejo.json)
ADMIN_TOKEN=$(jq -r '.api_token' ~/.config/bbwf/forgejo.json)

# 2. Base64 encode the image
IMAGE_BASE64=$(base64 -w 0 /path/to/avatar.png)

# 3. Update via API using the Sudo header
curl -X POST "http://localhost:3000/api/v1/user/avatar" \
     -H "Authorization: token $ADMIN_TOKEN" \
     -H "Sudo: <target_username>" \
     -H "Content-Type: application/json" \
     -d "{\"image\": \"$IMAGE_BASE64\"}"
```

*Note: The `Sudo` header allows an administrator to perform actions as any other user on the
system.*
