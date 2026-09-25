-- Tree-sitter highlighting via the rewritten nvim-treesitter (main branch).
-- Requires: Neovim 0.12+, tree-sitter-cli, a C compiler, curl, tar.
local M = {}

-- Parsers to keep installed. Add your languages here; the list maps to
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
M.parsers = {
  "lua", "vim", "vimdoc", "query",
  "markdown", "markdown_inline",
  "bash", "json", "yaml",
  "python", "typescript", "javascript",
  "rust", "tsx", "css", "html",
}

function M.setup()
  vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

  -- Install missing parsers asynchronously; no-op when already installed.
  require("nvim-treesitter").install(M.parsers)

  -- The rewrite does not enable highlighting by itself: start it for any
  -- buffer whose filetype has a parser available.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
      pcall(vim.treesitter.start, args.buf)
    end,
  })
end

return M
