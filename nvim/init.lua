vim.o.wildmode = 'list:longest,full'
vim.cmd.colorscheme('vim')
vim.g.mapleader = ','


-- vim-plug configuration.
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Why in hell do I need to setup dependencies manually?...
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')

vim.call('plug#end')
