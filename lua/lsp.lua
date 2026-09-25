-- LSP via Neovim's built-in vim.lsp + nvim-lspconfig server definitions.
-- Language servers live outside Neovim: brew install lua-language-server oxlint
-- rust-analyzer vscode-langservers-extracted; uv tool install ty.
local M = {}

-- Enabled servers. Names are nvim-lspconfig config names; the binary must
-- exist on $PATH (see install commands in the header).
M.servers = {
  "lua_ls", -- Lua (incl. your nvim config)
  "tsc", -- TypeScript / JavaScript types (native TS7 LSP; ts_ls needs typescript <7)
  "oxlint", -- TS/JS linting (oxlint --lsp)
  "ty", -- Python types (astral)
  "rust_analyzer", -- Rust
  "cssls", -- CSS
  "html", -- HTML
}

function M.setup()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

  -- Let blink.cmp advertise snippet capabilities to the servers
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
  end

  -- Diagnostics display: Neovim 0.12 defaults to no inline message text
  vim.diagnostic.config({
    virtual_text = { spacing = 4, prefix = "●" },
    signs = true,
    underline = true,
  })

  -- `vim` global is whitelisted via .luarc.json in this config directory
  vim.lsp.enable(M.servers)

  -- Buffer-local LSP keymaps, set when a server attaches
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local opts = { buffer = args.buf, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
      vim.keymap.set("n", "gr", function()
        require("telescope.builtin").lsp_references()
      end, vim.tbl_extend("force", opts, { desc = "List references (telescope)" }))
      vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
      vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
      vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, vim.tbl_extend("force", opts, { desc = "Show diagnostic message" }))
    end,
  })
end

return M
