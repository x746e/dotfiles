# Agent Guidance for working with the dotfiles repository.

## Commit Messages

- **Follow the** "Commit Message Guidelines (Standard Git Style)"
- **Subject Format:** Start the subject line with a topic tag in square
  brackets, followed by the imperative subject.
  - *Pattern:* `[<topic>] <Subject>`
  - *Examples:*
    - `[zsh] Add backup function`
    - `[gemini] Update /ksp:commit`

## Rules for handling dotfiles/gemini

- **Global Context File:** The file `gemini/GEMINI.md` in this repository is the
  source for the global Gemini Context File. It is symlinked to
  `~/.gemini/GEMINI.md` on the system.

  - *DO NOT* edit global `gemini/GEMINI.md` when asked to edit `@GEMINI.md`.

- **When describing changes to Gemini CLI Commands:** When referring to
  `gemini-cli` commands defined in `gemini/commands/`, use their CLI invocation
  syntax.

  - **Mapping:** `gemini/commands/<category>/<name>.toml` maps to
    `/<category>:<name>`.
  - **Example:** `gemini/commands/ksp/commit.toml` is available as
    `/ksp:commit`.
