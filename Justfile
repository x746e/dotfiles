# Justfile for dotfiles repository

# Run all verification steps
verify: test

# Auto-discover and run pytest on all Python tests and PEP 723 standalone scripts
test:
    @echo "==> Running pytest on tests and standalone scripts..."
    uvx --with ~/projects/pytest-pep723 pytest .

# Run the master install script
install:
    @echo "==> Running scripts/install.sh..."
    ./scripts/install.sh
