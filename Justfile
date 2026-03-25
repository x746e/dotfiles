# Justfile for dotfiles repository

wrap_length := "93"

# Run all verification steps
verify: test
    git ls-files -z '*.md' | xargs -0 mdformat --check --number --wrap {{wrap_length}}
    git ls-files -z '*.toml' | xargs -0 toml-mdformat --check --wrap {{wrap_length}}

fix:
    git ls-files -z '*.md' | xargs -0 mdformat --number --wrap {{wrap_length}}
    git ls-files -z '*.toml' | xargs -0 toml-mdformat --wrap {{wrap_length}}

# Auto-discover and run pytest on all Python tests and PEP 723 standalone scripts
test:
    @echo "==> Running pytest on tests and standalone scripts..."
    uvx --with ~/projects/pytest-pep723 pytest .

# Run the master install script
install:
    @echo "==> Running scripts/install.sh..."
    ./scripts/install.sh

# Hook for git pre-commit
pre-commit:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "==> Running verification on staged changes using commit-sandbox..."
    commit-sandbox just verify
