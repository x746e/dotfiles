## Plan Management

- **Persistence:** NEVER delete implementation plan files (typically found in
  the `<temp-dir>/plans/`).
- **Archiving:** When a plan is completed, move it to a `<temp-dir>/done/` subdirectory
  within the `<temp-dir>/plans/` directory
  (e.g., `mv <temp-dir>/plans/my-task.md <temp-dir>/plans/done/`).

## TODO.md Management

- **Marking as Completed:** When marking an entry in `TODO.md` as completed,
  move it to the top of the "Completed Items" section at the bottom of the file.

## Markdown Formatting

After editing markdown files you *MUST*:

- **Formatter:** Format markdown files with `mdformat --number --wrap 80`.

## Shell Safety

- **Backticks in Double Quotes:** Do NOT use backticks (\`) inside double-quoted
  strings passed to `run_shell_command`. Shells interpret these as command
  substitutions. Use single quotes for the outer string, or escape the backticks
  ("\`").
- **Search:** Use `rg` instead of `grep` to respect `.gitignore` and `.git/`.

## Output Formatting

- **Tables vs Lists:** You may use tables for small datasets that fit
  comfortably within the terminal width without truncation.
- **Avoid Truncation:** If a table would require truncating content (e.g., using
  "..." inside cells) or wrapping lines awkwardly to fit, **do not use a
  table**. Instead, use a bulleted list or a structured Markdown format that
  allows the full text to be displayed clearly.

## Gemini Added Memories
- The user specifically reprimanded me for running `grep` over the Google3 root directory, reinforcing the mandatory rule to use `search_for_files_codesearch` or specific file reads instead of filesystem recursion.

## Tmux Snapshot Instructions

- **Snapshot Instruction:** When asked to "take a snapshot/screenshot" of a tmux
  pane <PANE_ID>, run `tmux-capture <PANE_ID> <project-temp-dir>/<snapshot_name.ansi>`.
  Examples:
  - Prompt: "Take a snapshot of the :2 pane"; Run:
    `tmux-capture :2 <project-temp-dir>/snapshot_2.ansi`.
  - Prompt: "Take a look at the failure in :3.1"; Run:
    `tmux-capture :3.1 <project-temp-dir>/failure.ansi`.
  * Use `tmux-capture --html` to get the snapshot as html.
