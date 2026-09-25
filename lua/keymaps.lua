local M = {}

function M.setup()
  vim.keymap.set("n", "<leader>1", vim.cmd.Ex, { desc = "Open netrw explorer" })

  -- <leader>l: toggle invisible characters (listchars) for this window
  vim.keymap.set("n", "<leader>l", function()
    vim.wo.list = not vim.wo.list
  end, { desc = "Toggle invisible characters" })
end

return M
