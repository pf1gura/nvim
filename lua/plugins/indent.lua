-- Indentation guides via indent-blankline.
local M = {}

function M.setup()
  vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })

  require("ibl").setup({
    indent = { char = "▏" },
    scope = { enabled = true },
  })
end

return M
