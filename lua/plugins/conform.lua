-- Formatting via conform.nvim: <leader>L formats the current buffer.
-- Binaries on $PATH: oxfmt, ruff, stylua (brew), rustfmt (cargo).
local M = {}

function M.setup()
  vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

  require("conform").setup({
    formatters_by_ft = {
      javascript = { "oxfmt" },
      javascriptreact = { "oxfmt" },
      typescript = { "oxfmt" },
      typescriptreact = { "oxfmt" },
      python = { "ruff_organize_imports", "ruff_format" },
      lua = { "stylua" },
      rust = { "rustfmt" },
    },
  })

  vim.keymap.set("n", "<leader>L", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, { desc = "Format buffer" })
end

return M
