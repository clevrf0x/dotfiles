-- custom_theme.lua
local theme = {}

theme.setup = function()
  -- Clear any existing highlights
  vim.cmd 'highlight clear'
  vim.cmd 'set termguicolors' -- Enable true colors

  -- Set background and foreground
  vim.cmd 'highlight Normal guibg=NONE guifg=#B5C7D2 ctermbg=NONE ctermfg=NONE'

  -- Transparency
  vim.cmd 'highlight NormalNC guibg=NONE'

  -- Define base colors
  local colors = {
    background = '#101621',
    foreground = '#B5C7D2',
    black = '#101621',
    red = '#A0515C',
    green = '#5F8282',
    yellow = '#6594A6',
    blue = '#6C95BF',
    magenta = '#7D9FB0',
    cyan = '#73B2C1',
    white = '#B5C7D2',
    bright_black = '#1D2733',
    bright_red = '#B15F68',
    bright_green = '#6B9696',
    bright_yellow = '#73A8BA',
    bright_blue = '#80B1D5',
    bright_magenta = '#8EB5C7',
    bright_cyan = '#85C7D6',
    bright_white = '#E1EAF2',
  }

  -- Highlights
  vim.cmd(string.format('highlight Comment guifg=%s gui=italic', colors.green))
  vim.cmd(string.format('highlight Identifier guifg=%s', colors.blue))
  vim.cmd(string.format('highlight Statement guifg=%s gui=bold', colors.red))
  vim.cmd(string.format('highlight PreProc guifg=%s', colors.yellow))
  vim.cmd(string.format('highlight Type guifg=%s', colors.magenta))
  vim.cmd(string.format('highlight Special guifg=%s', colors.cyan))
  vim.cmd(string.format('highlight Constant guifg=%s', colors.bright_magenta))
  vim.cmd(string.format('highlight LineNr guifg=%s', colors.bright_black))
  vim.cmd(string.format('highlight CursorLineNr guifg=%s gui=bold', colors.bright_blue))
  vim.cmd(string.format('highlight Visual guibg=%s', colors.bright_black))
  vim.cmd(string.format('highlight StatusLine guifg=%s guibg=%s', colors.foreground, colors.black))
  vim.cmd(string.format('highlight Pmenu guibg=%s guifg=%s', colors.bright_black, colors.foreground))
  vim.cmd(string.format('highlight TabLineFill guibg=%s', colors.background))
  vim.cmd(string.format('highlight VertSplit guifg=%s guibg=%s', colors.bright_black, colors.black))
end

return theme
