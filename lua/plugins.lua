local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('lazy').setup({
  { 'rebelot/kanagawa.nvim',            priority = 1000 },
  { 'sainnhe/gruvbox-material',         priority = 1000 },
  { 'slugbyte/lackluster.nvim',         priority = 1000 },
  { 'xero/miasma.nvim',                 priority = 1000 },
  { 'aktersnurra/no-clown-fiesta.nvim', priority = 1000 },
  { 'drewxs/ash.nvim',                  priority = 1000 },
  { 'rmehri01/onenord.nvim',            priority = 1000 },

  'rstacruz/vim-closer',
  {
    'neovim/nvim-lspconfig',
    priority = 500,
    config = function()
      require 'nvim-lspconfig'
    end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.cmd 'nnore <silent> <localleader>v :Neotree toggle current reveal<CR>'
      -- vim.cmd 'nnore <silent> <localleader>v :Neotree toggle float reveal<CR>'
      vim.cmd 'nnore <silent> <localleader>r :Neotree toggle right reveal<CR>'
      vim.cmd 'nnore <silent> <localleader>g :tabe<CR>:Neotree git_status toggle current<CR>'
      require('neo-tree').setup({
        filesystem = {
          window = {
            mappings = {
              ['l'] = 'open',
            }
          }
        },
        git_status = {
          window = {
            mappings = {
              ['l'] = 'show_diff',
              ['A'] = 'git_add',
            }
          }
        },
        commands = {
          git_add = function(state)
            local node = state.tree:get_node()
            local abs_path = node.path
            vim.cmd("!git add " .. node.path)
          end,
          show_diff = function(state)
            local node = state.tree:get_node()
            local abs_path = node.path
            local rel_path = vim.fn.fnamemodify(abs_path, ":~:.")
            local filename = node.name
            local is_file = node.type == "file"
            if not is_file then
              vim.notify("Diff only for files", vim.log.levels.ERROR)
              return
            end
            local cc = require("neo-tree.sources.common.commands")
            cc.open(state, function() end)

            ft, _ = vim.filetype.match({ filename = filename })

            win = vim.api.nvim_get_current_win()

            vim.cmd([[
              difft
              vnew
              setl buftype=nofile bufhidden=hide noswapfile
              difft
            ]])
            vim.cmd("%!git show @^:" .. rel_path)
            vim.cmd("setf " .. ft)

            vim.api.nvim_set_current_win(win)
          end,
        }
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = { ':TSUpdateSync' },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'c', 'lua', 'vim',
          'vimdoc', 'query',
          'markdown', 'markdown_inline',
          'rust', 'ron', 'toml',
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
      }
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sharkdp/fd',
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      vim.cmd [[
      nnore <silent> <localleader>ff :lua require'telescope.builtin'.find_files{}<CR>
      nnore <silent> <localleader>fb :lua require'telescope.builtin'.buffers{}<CR>
      nnore <silent> <localleader>fh :lua require'telescope.builtin'.help_tags{}<CR>
      nnore <silent> <localleader>fg :lua require'telescope.builtin'.live_grep{}<CR>
      nnore <silent> <localleader>fd :lua require'telescope.builtin'.diagnostics{bufnr=0}<CR>
      nnore <silent> <localleader>fD :lua require'telescope.builtin'.diagnostics{}<CR>
      nnore <silent> <localleader>fs :lua require'telescope.builtin'.lsp_document_symbols{}<CR>
      nnore <silent> <localleader>fm :lua require'telescope.builtin'.man_pages{sections={"ALL"}}<CR>
      ]]
    end
  },
  {
    'playwmadness/pyformat.nvim',
    build = { ':UpdateRemotePlugins' },
    -- ft = { 'python' },
    config = function()
      vim.cmd 'au BufWritePre *.py,*.pyi silent! PyFormatSync'
    end
  },
  {
    'playwmadness/c-formatter-42.nvim',
    build = { ':UpdateRemotePlugins' },
    -- ft = { 'c' },
    config = function()
      vim.cmd 'au BufWritePre *.c Norimnette'
    end
  },

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',

  {
    'hrsh7th/nvim-cmp',
    config = function()
      require 'nvim-cmp'
    end
  },

  {
    'bbjornstad/pretty-fold.nvim',
    config = function()
      require 'pretty-fold'.setup {
        sections = {
          left = {
            'content',
          },
          right = {
            ' ', 'number_of_folded_lines', ': ', 'percentage', ' ',
            function(config) return config.fill_char:rep(3) end
          }
        },
        fill_char = '۰',

        remove_fold_markers = true,

        -- Keep the indentation of the content of the fold string.
        keep_indentation = true,

        -- Possible values:
        -- "delete" : Delete all comment signs from the fold string.
        -- "spaces" : Replace all comment signs with equal number of spaces.
        -- false    : Do nothing with comment signs.
        process_comment_signs = 'spaces',

        -- Comment signs additional to the value of `&commentstring` option.
        comment_signs = {},

        -- List of patterns that will be removed from content foldtext section.
        stop_words = {
          '@brief%s*', -- (for C++) Remove '@brief' and all spaces after.
        },

        add_close_pattern = true, -- true, 'last_line' or false

        matchup_patterns = {
          { '{',  '}' },
          { '%(', ')' }, -- % to escape lua pattern char
          { '%[', ']' }, -- % to escape lua pattern char
        },

        ft_ignore = { 'neorg' },
      }
    end
  },

  {
    'serenevoid/kiwi.nvim',
    opts = {
      {
        name = "wiki",
        path = os.getenv("HOME") .. "/wiki",
      },
    },
    keys = {
      { "<localleader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
      { "T",               ":lua require(\"kiwi\").todo.toggle()<cr>",     desc = "Toggle Markdown Task" }
    },
    lazy = true
  },

  'norcalli/nvim-colorizer.lua',

  {
    "Djancyp/custom-theme.nvim",
    config = function()
      require("custom-theme").setup()
    end,
  },

  {
    -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    -- config = function()
    --   require("lsp_lines").setup()
    --   vim.diagnostic.config({
    --     virtual_text = true,
    --     virtual_lines = { only_current_line = true },
    --   })
    -- end,
  },
})
