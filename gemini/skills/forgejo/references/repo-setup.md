# Local Repository Setup

When creating a new repository or pushing an existing local repository to the local Forgejo
server for the first time, you MUST configure local credentials to avoid interactive password
prompts. (SSH is not supported for automated agent operations).

**Initial Push / Setup Steps:**

1. Do not use the SSH URL provided by `tea-cli repos create`. Use the HTTP URL:
   `http://localhost:3000/<owner>/<repo_name>.git`
2. Extract the `user` and `token` for the `local` login from the `tea` config
   (`cat ~/.config/tea/config.yml || cat ~/.tea/tea.yml`).
3. Set the remote: `git remote set-url origin http://localhost:3000/<owner>/<repo_name>.git`
   (or `git remote add origin ...`)
4. Configure local credentials:
   ```bash
   git config --local credential.helper "store --file .git/.git-credentials"
   echo "http://<user>:<token>@localhost:3000" > .git/.git-credentials
   ```
5. `git push -u origin main`

Once this setup is complete, you do not need to worry about authentication or transport.
Standard `git push` and `git pull` commands will work automatically.
