-- Completion menu via blink.cmp (stable v1; v2 is in development upstream).
local M = {}

function M.setup()
  vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
  })

  require("blink.cmp").setup({
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    sources = { default = { "lsp", "path", "buffer" } },
    completion = {
      documentation = { auto_show = true },
      trigger_show = true,
    },
  })
end

return M
