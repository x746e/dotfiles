## Explanations & Verification (The "No Lazy Guessing" Rule)

When asked *why* or *how* a technical issue occurred (e.g., "why did the test pass?", "how
did Mypy miss this?"), you must assess the cost of verifying your hypothesis:

- **The "Cheap Check" Mandate:** NEVER guess or use hedging language (e.g., "likely",
  "seems", "might") if the hypothesis can be proven or disproven with a few simple, fast tool
  calls (e.g., checking for a `py.typed` file, grepping a configuration, verifying a library
  version, or running a quick local script). You MUST perform these checks before responding.
  Do not be lazy.
- **The "Expensive Investigation" Boundary:** If verifying the hypothesis requires
  significant effort, complex environment setup, or deep debugging (e.g., debugging a kernel,
  tracing a complex distributed transaction), do NOT dive in autonomously. Instead:
  1. State your hypothesis clearly.
  2. Explicitly note that it is unverified because the required check is complex.
  3. Briefly propose the steps/task required to investigate it, and ask the user how they
     want to proceed.

## Temporary Files & Verification

- **Location:** Write temporary files, reproduction scripts, scratchpads, and verification
  tests (e.g., `repro.py`, `debug_test.py`) to the project's temporary directory:
  `$HOME/.gemini/tmp/<project-name-or-hash>/`. **FORBIDDEN:** NEVER write these temporary
  files to the repository root.

## Plan Management

- **Persistence:** NEVER delete implementation plan files (typically found in the
  `<temp-dir>/plans/`).
- **Archiving:** When a plan is completed, move it to a `<temp-dir>/done/` subdirectory
  within the `<temp-dir>/plans/` directory (e.g.,
  `mv <temp-dir>/plans/my-task.md <temp-dir>/plans/done/`).

## TODO.md Management

- **Marking as Completed:** When marking an entry already existing in `TODO.md` as completed,
  move it to the top of the "Completed Items" section at the bottom of the file.

## Shell Safety

- **Backticks in Double Quotes:** Do NOT use backticks (\`) inside double-quoted strings
  passed to `run_shell_command`. Shells interpret these as command substitutions. Use single
  quotes for the outer string, or escape the backticks ("\`").
- **Search:** Use `rg` instead of `grep` to respect `.gitignore` and `.git/`.

## Output Formatting

- **Tables vs Lists:** You may use tables for small datasets that fit comfortably within the
  terminal width without truncation.
- **Avoid Truncation:** If a table would require truncating content (e.g., using "..." inside
  cells) or wrapping lines awkwardly to fit, **do not use a table**. Instead, use a bulleted
  list or a structured Markdown format that allows the full text to be displayed clearly.

## Gemini Added Memories

- The user specifically reprimanded me for running `grep` over the Google3 root directory,
  reinforcing the mandatory rule to use `search_for_files_codesearch` or specific file reads
  instead of filesystem recursion.
- When writing files or executing shell commands, DO NOT use heredocs (e.g.,
  `cat << 'EOF' > file.py`). Instead, prioritize custom tools like `write_file` or `replace`
  when available.
- **Forgejo Issue Lifecycle Workflow** When asked to perform reconnaissance, planning, or
  execution for a Forgejo issue, you MUST keep the issue state in sync with your work by
  following these steps:
  - **Reconnaissance / Triage:** When analyzing or triaging an issue, always use `lfc` to
    post a summary of your findings as a comment and add the `triaged` label to the issue.
  - **Planning:** When proposing a plan for an issue, always use `lfc` to post the plan as a
    comment and add the `planned` label to the issue.
  - **Execution:** When implementing a fix and creating a commit, ensure your final commit
    message includes `Fixes #<ID>` on the last line so the issue is automatically closed when
    pushed.
  - **Finding Work (Issue Queues):** You can use `lfc issue list` and labels to determine
    what to do next based on the user's request:
    - **"What untriaged issues do we have?" or "What should we triage?":** Search for open
      issues that lack the `triaged` label.
    - **"Let's work on issue planning" or "What issues need planning?":** Search for open
      issues that have the `triaged` label but lack the `planned` label.
    - **"What should we do next?" or "What issues are ready for execution?":** Search for
      open issues that have the `planned` label.

## Tmux Snapshot Instructions

- **Snapshot Instruction:** When asked to "take a snapshot/screenshot" of a tmux pane
  \<PANE_ID>, run `tmux-capture <PANE_ID> <project-temp-dir>/<snapshot_name.ansi>`. Examples:
  - Prompt: "Take a snapshot of the :2 pane"; Run:
    `tmux-capture :2 <project-temp-dir>/snapshot_2.ansi`.
  - Prompt: "Take a look at the failure in :3.1"; Run:
    `tmux-capture :3.1 <project-temp-dir>/failure.ansi`.
  * Use `tmux-capture --html` to get the snapshot as html.
