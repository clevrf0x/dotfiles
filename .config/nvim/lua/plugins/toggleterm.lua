return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      -- Size can be a number or function
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
        return 20
      end,
      -- Open in floating window by default
      direction = 'float',
      -- Floating window settings
      float_opts = {
        border = 'curved',
        -- winblend = 3,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
      -- Hide the terminal number
      hide_numbers = false,
      -- Shade terminals
      shade_terminals = true,
      shading_factor = 2,
      -- Close terminal on process exit
      close_on_exit = true,
      -- Shell to use for terminal
      shell = vim.o.shell,
      -- Auto-insert mode when opening terminal
      start_in_insert = false,
      -- Terminal persists until explicitly closed
      persist_size = true,
      persist_mode = true,
      -- Terminal window mappings
      on_open = function(term)
        vim.cmd 'startinsert!'
        -- ESC will exit insert mode in terminal
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
        -- Easier navigation out of terminal
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-h>', '<C-\\><C-n><C-W>h', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-j>', '<C-\\><C-n><C-W>j', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-k>', '<C-\\><C-n><C-W>k', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-l>', '<C-\\><C-n><C-W>l', { noremap = true, silent = true })
      end,
    }

    -- Set up keybindings
    vim.api.nvim_set_keymap('n', '<C-t>', '<Cmd>ToggleTerm<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>tt', '<Cmd>ToggleTerm<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('t', '<C-t>', '<Cmd>ToggleTerm<CR>', { noremap = true, silent = true })

    -- Multiple terminals if needed
    vim.api.nvim_set_keymap('n', '<leader>t1', '<Cmd>1ToggleTerm<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>t2', '<Cmd>2ToggleTerm<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>t3', '<Cmd>3ToggleTerm<CR>', { noremap = true, silent = true })

    -- Toggle specific terminal directions if needed
    vim.api.nvim_set_keymap('n', '<leader>tf', '<Cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>th', '<Cmd>ToggleTerm size=15 direction=horizontal<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>tv', '<Cmd>ToggleTerm size=80 direction=vertical<CR>', { noremap = true, silent = true })

    -- Terminal in current buffer
    -- vim.api.nvim_set_keymap('n', '<leader>tt', '<Cmd>terminal<CR>', { noremap = true, silent = true })

    -- Terminal send command function available with :TermExec
    -- Example usage: vim.cmd([[TermExec cmd="ls -la"]])
  end,
}
