-- vim: ts=2:sts=2:sw=2
-- Two-space indentation appears to be the lua style used by neovim itself, and
-- by many of the plugins.  Not sure why isn't it the default.

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

-- TODO: Why in hell do I need to setup dependencies manually?...
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

Plug('nvim-tree/nvim-web-devicons')  -- optional
Plug('nvim-tree/nvim-tree.lua')

Plug('stevearc/aerial.nvim')

Plug('tpope/vim-unimpaired')

vim.call('plug#end')

-- TODO: Consider grouping all the plugin related bits into its own module.
-- Something like ~/.config/nvim/lib/nvim-tree.lua (by plugin) or
-- ~/.config/nvim/lib/file-browser.lua (by feature).
-- There, have a plugin installation directive (not sure if possible with
-- vim-plug), and configuration of the plugin.
--
-- Maybe have ~/.config/nvim/features/file-browser.lua, and
-- ~/.config/nvim/lib/treesitter.lua, for dependencies not neatly mapped to
-- just one feature.

-- Telescope configuration.
require('telescope').setup{
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = { height = { padding = 0 }, width = { padding = 0 } },
  }
}
local telescope_builtin = require('telescope.builtin')
if not vim.g.vscode then
	vim.keymap.set('n', '<leader>l', telescope_builtin.buffers)
else
	vim.keymap.set('n', '<leader>l', "<cmd>lua require('vscode').action('workbench.action.showEditorsInActiveGroup')<CR>")
end

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
if not vim.g.vscode then
	vim.keymap.set('n', '<leader>f', ':NvimTreeToggle<CR>')
else
	vim.keymap.set('n', '<leader>f', "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>")
end

-- aerial.nvim configuration.
require("aerial").setup({
	show_guides = true,
	layout = {
		min_width = 0.5,
	},
	float = {
		relative = "editor",
		max_height = 0.9,
		min_height = 0.9,
		max_width = 0.5,
		min_width = 0.5,
	},
	nav = {
		max_height = 0.9,
		min_height = 0.9,
		max_width = 0.5,
		min_width = 0.5,
	},
	keymaps = {
		["<CR>"] = "actions.jump",
		["<2-LeftMouse>"] = "actions.jump",
		["<C-v>"] = "actions.jump_vsplit",
		["<C-s>"] = "actions.jump_split",
		["h"] = "actions.left",
		["l"] = "actions.right",
		-- This is the only mapping I changed.  Do I need to have the above hardcoded as well?
		["q"] = "actions.close",
	},
})
if not vim.g.vscode then
	vim.keymap.set("n", "<leader>t", "<cmd>AerialToggle float<CR>")
else
	vim.keymap.set('n', '<leader>t', "<cmd>lua require('vscode').action('outline.focus')<CR>")
end
