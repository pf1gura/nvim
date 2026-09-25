-- Telescope pickers: files, buffers, grep.
-- Binaries on $PATH: ripgrep (live_grep), fd (find_files), git.
local M = {}

-- <leader>p: git-tracked files inside a repo, all files otherwise
local function smart_files()
  local builtin = require("telescope.builtin")
  local inside_git = vim.fn.trim(
    vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
  ) == "true"
  if inside_git then
    builtin.git_files({ show_untracked = true })
  else
    builtin.find_files({ hidden = true })
  end
end

function M.setup()
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  })

  require("telescope").setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
        },
      },
    },
    -- Render every vim.ui.select prompt (code actions, etc.) as a telescope dropdown
    extensions = {
      ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
    },
  })
  require("telescope").load_extension("ui-select")

  vim.keymap.set("n", "<leader>p", smart_files, { desc = "Find files (git-aware)" })
  vim.keymap.set("n", "<leader>e", function()
    require("telescope.builtin").buffers()
  end, { desc = "Recent buffers" })
  vim.keymap.set("n", "<leader>F", function()
    require("telescope.builtin").live_grep()
  end, { desc = "Grep in files" })

  -- File outline (symbols in current buffer); needs an attached LSP server
  vim.keymap.set("n", "<leader>o", function()
    require("telescope.builtin").lsp_document_symbols()
  end, { desc = "Document symbols (outline)" })
end

return M
