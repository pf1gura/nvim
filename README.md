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

## Keybindings

The leader key is **Space**. All bindings below use normal mode unless noted; uppercase keys are case-sensitive. Plugin defaults are not listed.

### Files and editor

| Keys | Action |
| --- | --- |
| `<Space>1` | Open the netrw file explorer |
| `<Space>p` | Find files (tracked and untracked files in Git repos; includes hidden files outside Git) |
| `<Space>e` | List open buffers |
| `<Space>F` | Search project contents |
| `<Space>l` | Toggle invisible characters in the current window |
| `<Space>L` | Format the current buffer (with LSP fallback) |
| `Ctrl-j` / `Ctrl-k` | Next / previous selection in Telescope (insert mode) |

### Git

| Keys | Action |
| --- | --- |
| `<Space>gs` | Show Git status in Telescope |
| `<Space>gd` | Toggle repository-wide diff review (Diffview) |
| `<Space>hp` | Preview the current hunk (when Gitsigns attaches) |

### Language servers and diagnostics

These bindings require an attached language server.

| Keys | Action |
| --- | --- |
| `gd` | Go to definition |
| `gr` | List references in Telescope |
| `K` | Show hover documentation |
| `<Space>o` | List symbols in the current document (outline) |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Show code actions |
| `[d` / `]d` | Jump to the previous / next diagnostic |
| `gl` | Show the diagnostic message in a floating window |

## Usage and checks

- `:ConformInfo`: inspect available formatters
- `:checkhealth`: check dependencies
- `:UpdateAll`: update plugins and Tree-sitter parsers

Allow parser installation to finish on first launch. Open a project file to check language-server attachment with `:checkhealth vim.lsp`.
