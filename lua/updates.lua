-- Update commands:
--   :PackUpdate  -- git-pull all vim.pack plugins
--   :TSUpdate    -- update tree-sitter parsers (provided by nvim-treesitter)
--   :UpdateAll   -- both of the above
local M = {}

function M.setup()
  vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
  end, { desc = "Update all vim.pack plugins" })

  vim.api.nvim_create_user_command("UpdateAll", function()
    vim.pack.update()
    vim.cmd.TSUpdate()
  end, { desc = "Update plugins and tree-sitter parsers" })
end

return M
