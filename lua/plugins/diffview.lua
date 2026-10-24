-- Repository-wide review with full, editable working-tree files.
local M = {}

function M.setup()
  vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

  require("diffview").setup({
    use_icons = false,
    enhanced_diff_hl = true,
    hooks = {
      diff_buf_win_enter = function(_, winid)
        -- Show the whole file, including unchanged context, in each diff pane.
        vim.wo[winid].foldenable = false
      end,
    },
    keymaps = {
      view = {
        -- Preserve the existing buffer picker and LSP code-action mappings.
        ["<leader>e"] = false,
        ["<leader>ca"] = false,
      },
      file_panel = {
        ["<leader>e"] = false,
      },
      file_history_panel = {
        ["<leader>e"] = false,
      },
    },
  })

  vim.keymap.set("n", "<leader>gd", "<Cmd>DiffviewOpen<CR>", { desc = "Review Git changes" })
end

return M
