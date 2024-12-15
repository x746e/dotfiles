-- nvim-tree strongly recommends disable netrw; and it must be done early in
-- the init.lua 🤷.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Misc vim options.
vim.o.wildmode = 'list:longest,full'
vim.cmd.colorscheme('evening')
vim.g.mapleader = ','
vim.o.termguicolors = true

-- vim-plug configuration.
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Why in hell do I need to setup dependencies manually?...
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

Plug('nvim-tree/nvim-web-devicons')  -- optional
Plug('nvim-tree/nvim-tree.lua')

vim.call('plug#end')


-- Telescope configuration.
require('telescope').setup{
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = { height = { padding = 0 }, width = { padding = 0 } },
  }
}
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>l', telescope_builtin.buffers)

-- nvim-tree configuration.
local HEIGHT_RATIO = 1  -- You can change this
local WIDTH_RATIO = 1   -- You can change this too
require("nvim-tree").setup({
  sort = {
    sorter = "name",  --case_sensitive
  },
  view = {
    preserve_window_proportions = true,
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})
vim.keymap.set('n', '<leader>f', ':NvimTreeToggle<CR>')
