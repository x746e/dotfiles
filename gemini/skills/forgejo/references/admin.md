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
