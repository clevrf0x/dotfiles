-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- Normal mode
-- vim.keymap.set('n', '<Left>',  '<cmd>echo "Use h to move left!"<CR>', { desc = "Disable arrow key (use h)" })
-- vim.keymap.set('n', '<Right>', '<cmd>echo "Use l to move right!"<CR>', { desc = "Disable arrow key (use l)" })
-- vim.keymap.set('n', '<Up>',    '<cmd>echo "Use k to move up!"<CR>', { desc = "Disable arrow key (use k)" })
-- vim.keymap.set('n', '<Down>',  '<cmd>echo "Use j to move down!"<CR>', { desc = "Disable arrow key (use j)" })
--
-- -- Visual mode (to prevent slipping back into bad habits)
-- vim.keymap.set('v', '<Left>',  '<cmd>echo "Use h to move left!"<CR>')
-- vim.keymap.set('v', '<Right>', '<cmd>echo "Use l to move right!"<CR>')
-- vim.keymap.set('v', '<Up>',    '<cmd>echo "Use k to move up!"<CR>')
-- vim.keymap.set('v', '<Down>',  '<cmd>echo "Use j to move down!"<CR>')
--
-- -- Insert Mode (Prevent arrow keys)
-- vim.keymap.set('i', '<Left>',  '<cmd>echo "Exit Insert mode (Esc) and use h!"<CR>')
-- vim.keymap.set('i', '<Right>', '<cmd>echo "Exit Insert mode (Esc) and use l!"<CR>')
-- vim.keymap.set('i', '<Up>',    '<cmd>echo "Exit Insert mode (Esc) and use k!"<CR>')
-- vim.keymap.set('i', '<Down>',  '<cmd>echo "Exit Insert mode (Esc) and use j!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Define a keymap to safely delete the current buffer without closing the window
vim.keymap.set('n', '<leader>bd', function()
  -- Store a reference to the current buffer number
  local current_buf = vim.api.nvim_get_current_buf()

  -- Switch to the previous buffer in the buffer list
  -- This ensures we don't end up with an empty window
  vim.cmd 'bprevious'

  -- Delete the original buffer we were on
  -- Using the stored reference ensures we delete the correct buffer
  vim.cmd('bdelete ' .. current_buf)
end, {
  silent = true, -- Don't show command in the command line
  desc = 'Delete current buffer without closing window', -- Documentation for which-key or similar plugins
})
