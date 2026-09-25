-- Auto-close bracket and quote pairs via mini.pairs.
local M = {}

function M.setup()
  vim.pack.add({ "https://github.com/echasnovski/mini.pairs" })

  require("mini.pairs").setup()
end

return M
