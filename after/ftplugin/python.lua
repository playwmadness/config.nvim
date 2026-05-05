local set = vim.opt_local
set.lcs = "space:•,eol:$,tab:>-,leadmultispace:▌   ,multispace:....•"
set.fdl = 2

vim.cmd [[
  au BufWritePost *.py,*.pyi silent! !ruff format %
]]
