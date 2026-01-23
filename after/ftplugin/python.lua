local set = vim.opt_local
set.lcs = "space:•,eol:$,tab:>-,leadmultispace:|   ,multispace:....•"
set.fdl = 1

vim.cmd [[
  au BufWritePre *.py,*.pyi silent! !uvx ruff format %
]]
