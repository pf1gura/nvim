-- Transparent background: clear bg on all window/UI highlight groups so the
-- terminal's own background (and its translucency, if any) shows through.
local transparent_groups = {
  "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle",
  "SignColumn", "LineNr", "CursorLineNr", "CursorLine", "CursorColumn",
  "WinSeparator", "StatusLine", "StatusLineNC", "TabLine", "TabLineFill",
  "TabLineSel", "EndOfBuffer", "MsgArea", "Pmenu", "PmenuSbar", "PmenuThumb",
}

local function clear_background()
  for _, group in ipairs(transparent_groups) do
    -- nvim_set_hl replaces the whole definition, so preserve the other
    -- attributes (fg, bold, ...) and only change the background
    local hl = vim.api.nvim_get_hl(0, { name = group })
    hl.bg = "NONE"
    hl.ctermbg = "NONE"
    vim.api.nvim_set_hl(0, group, hl)
  end
end

local function setup()
  -- Re-apply whenever a colorscheme is set, so themes can't paint it back
  vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_background })
  clear_background()
end

return {
  setup = setup,
}
