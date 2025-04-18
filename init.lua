vim.g.python3_host_prog = vim.env.HOME .. '/.local/venv/nvim/bin/python'

require "plugins"

vim.cmd [[
" Important!!
if has('termguicolors')
  set termguicolors
endif
set background=dark

" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'

let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material
colorscheme kanagawa-dragon
colorscheme ash
]]

vim.treesitter.language.register('rust', 'rhai')

local function nore(where, lhs, rhs, silent)
  vim.keymap.set(where, lhs, rhs, { silent = silent })
end

nore("n", "<localleader>tt", ":tab split<CR>", true)
nore("n", "<Tab>", ":tabn<CR>", true)
nore("n", "<S-Tab>", ":tabn<CR>", true)
nore("n", "<Esc>", ":nohls<CR>", true)
nore("n", ";", ":", false)
nore("n", "<C-b>", ":ls<CR>", false)
nore("n", "<C-l>", ":set invlist<CR>:redr!<CR>", true)

nore("t", "<Esc>", "<C-\\><C-n>", false)
nore("t", "<S-Tab>", "<C-d>", false)

nore("i", "<S-Tab>", "<C-d>", false)

nore("i", "<C-r><C-r>", "<C-r>\"", true)


local set          = vim.opt
set.sw             = 2
set.ts             = 2
set.sts            = 2
set.et             = true
set.nu             = true
set.rnu            = true
set.cul            = true
set.culopt         = "both"
set.fdm            = "expr"
set.fdm            = "manual"
set.hls            = true
set.scs            = true
set.ic             = true
set.is             = true
set.spr            = true
set.sb             = true
set.wrap           = false
set.stal           = 2
set.wildmenu       = true
set.stl            = "[%{winnr()} / %n]: %y %f%( [%W%R%M]%)%=%l:%02c  [%P] "
set.lcs            = "space:•,eol:$,tab:>-,leadmultispace:| ,multispace:....•"
set.list           = false
set.fdl            = 999
set.fdc            = "auto:3"
set.ea             = true
set.cpt            = ".,w,b,u,t,k"
set.cot            = "menuone,longest,preview"
set.exrc           = true
set.mouse          = ""
set.foldlevelstart = 6

set.fdm            = 'expr'
vim.wo.foldexpr    = 'v:lua.vim.treesitter.foldexpr()'

vim.cmd "nohls"

-- if vim.api.nvim_buf_get_name(0) == "" then
--   vim.cmd "Neotree current reveal"
-- end

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end
