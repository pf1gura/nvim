-- Statusline via lualine.
local M = {}

local function clear_lualine_bg()
  -- lualine creates its own highlight groups; strip their backgrounds so the
  -- statusline stays transparent like the rest of the editor
  for _, name in ipairs(vim.fn.getcompletion("lualine", "highlight")) do
    local hl = vim.api.nvim_get_hl(0, { name = name })
    if hl.bg then
      hl.bg = "NONE"
      hl.ctermbg = "NONE"
      vim.api.nvim_set_hl(0, name, hl)
    end
  end
end

function M.setup()
  vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

  require("lualine").setup({
    options = {
      theme = "auto",
      globalstatus = true, -- one statusline for the whole window
    },
  })

  -- lualine re-themes on colorscheme changes; keep re-clearing the bg
  vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_lualine_bg })
  clear_lualine_bg()
end

return M
