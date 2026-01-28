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
