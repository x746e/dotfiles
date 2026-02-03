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
