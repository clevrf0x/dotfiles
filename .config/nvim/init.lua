-- Set basic options
require 'globals'
require 'options'
require 'autocmds'
require 'keymaps'
require 'user_commands'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
require('lazy').setup({
  -- [[ Editor Plugins ]]
  require 'plugins.autopairs',
  require 'plugins.toggleterm',
  { 'tpope/vim-sleuth' },
  { 'wakatime/vim-wakatime', lazy = false },

  -- [[ UI Plugins ]]
  require 'plugins.tokyonight-theme',
  -- require 'plugins.custom-theme',
  require 'plugins.indent_line',
  require 'plugins.mini',
  require 'plugins.which-key',
  require 'plugins.todo',

  -- [[ Git Plugins ]]
  require 'plugins.lazygit',
  require 'plugins.gitsigns',

  -- [[ File Management Plugins ]]
  require 'plugins.oil',
  require 'plugins.telescope',
  -- require 'plugins.neo-tree',

  -- [[ LSP and Code Intelligence Plugins ]]
  require 'plugins.lazydev',
  require 'plugins.lsp',

  -- [[ Formatting and Linting Plugins ]]
  require 'plugins.conform',
  require 'plugins.lint',

  -- [[ Autocompletion and Snippets Plugins ]]
  require 'plugins.completions_and_snippets',

  -- [[ Syntax and Language Plugins ]]
  require 'plugins.tree-sitter',

  -- [[ Debugging Plugins ]]
  -- require 'plugins.debug',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
