# Forgejo CLI Setup

The `tea-cli` tool requires a configured login profile to interact with the Forgejo server.

If the agent encounters an authentication error or if the `tea-cli logins` command returns an empty list (meaning the 'local' login does not exist), you MUST configure the login before proceeding.

## Setup Instructions

Once you have a Personal Access Token for the desired user, bootstrap the `tea-cli` configuration by running:

```bash
tea-cli login add --name local --url <FORGEJO_URL> --token <YOUR_TOKEN>
```
*(e.g., `--url http://localhost:3000`)*

Once this command succeeds, the `--login local` flag will work for all subsequent `tea-cli` commands.

If you do not have a token, you may need to ask the user to provide one. Alternatively, if you have shell access to the Forgejo host system, you can generate one using the Forgejo admin CLI (see `references/admin.md`).