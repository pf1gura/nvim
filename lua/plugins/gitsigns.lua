-- Git signs and a single shortcut to preview the current hunk.
local M = {}

function M.setup()
  vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

  require("gitsigns").setup({
    on_attach = function(bufnr)
      vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk,
        { buffer = bufnr, desc = "Preview Git hunk" })
    end,
  })
end

return M
