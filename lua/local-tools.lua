-- Prefer project-local tool binaries on $PATH: node_modules/.bin and
-- .venv/bin / venv/bin from the project root. LSP servers and formatters
-- then use the versions the project pins instead of the global ones.
local M = {}

local added = {}

local function add_dir(dir)
  if not dir or added[dir] or vim.fn.isdirectory(dir) ~= 1 then
    return
  end
  added[dir] = true
  vim.env.PATH = dir .. ":" .. vim.env.PATH
end

local function update(bufnr)
  local js_root = vim.fs.root(bufnr, { "package.json" })
  if js_root then
    add_dir(vim.fs.joinpath(js_root, "node_modules", ".bin"))
  end

  local py_root = vim.fs.root(bufnr, { "pyproject.toml", "setup.py", ".git" })
  if py_root then
    add_dir(vim.fs.joinpath(py_root, ".venv", "bin"))
    add_dir(vim.fs.joinpath(py_root, "venv", "bin"))
  end
end

function M.setup()
  -- Registered before lsp.setup() in init.lua, so this runs before the
  -- FileType autocmd that starts LSP clients
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      update(args.buf)
    end,
  })
end

return M
