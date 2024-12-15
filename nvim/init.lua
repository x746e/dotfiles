vim.o.wildmode = 'list:longest,full'
vim.cmd.colorscheme('vim')
vim.g.mapleader = ','


-- vim-plug configuration.
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Why in hell do I need to setup dependencies manually?...
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})


vim.call('plug#end')


-- Telescope config.
require('telescope').setup{
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = { height = { padding = 0 }, width = { padding = 0 } },
  }
}
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>l', telescope_builtin.buffers)
