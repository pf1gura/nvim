# neovim config

Requires **Neovim 0.12+**. Plugins and Tree-sitter parsers install automatically on first launch; external tools must be installed separately.

## Install external tools

Assumes **Homebrew**, **uv**, **rustup**, and **Vite+ (`vp`)** are installed and on `PATH`.

```bash
# Editor, file search, parser CLI, and Lua tooling
brew install neovim git ripgrep fd tree-sitter-cli lua-language-server stylua

# JavaScript/TypeScript linting, formatting, types, and HTML/CSS servers
vp add -g oxlint oxfmt typescript vscode-langservers-extracted

# Python type checking, formatting, and import sorting
uv tool install ty
uv tool install ruff

# Rust tooling
rustup toolchain install stable
rustup component add rust-analyzer rustfmt rust-src --toolchain stable
```

- **TypeScript 7+** is required for the configured `tsc` language server; the native preview package is not needed.
- **Tree-sitter CLI 0.26.1+**, a **C compiler**, **curl**, and **tar** are required to build parsers. On Ubuntu, install missing build tools with `sudo apt install build-essential curl tar`; on macOS, run `xcode-select --install`.
- Ensure uv's tool directory (usually `~/.local/bin`), `~/.cargo/bin`, and globally installed `vp` commands are on `PATH`. Run `uv tool update-shell` only if uv-installed commands are not found.
- A **Nerd Font** in your terminal is optional, but recommended for completion icons.
- Project-local tools in `node_modules/.bin`, `.venv/bin`, and `venv/bin` are also supported.

## Usage and checks

The leader key is **Space**.

- `<Space>p`: find files
- `<Space>F`: search project contents
- `<Space>L`: format the current buffer
- `:ConformInfo`: inspect available formatters
- `:checkhealth`: check dependencies
- `:UpdateAll`: update plugins and Tree-sitter parsers

Allow parser installation to finish on first launch. Open a project file to check language-server attachment with `:checkhealth vim.lsp`.
