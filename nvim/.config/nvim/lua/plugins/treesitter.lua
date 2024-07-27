return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local configs = require "nvim-treesitter.configs"

    configs.setup {
      ensure_installed = { "lua", "vim", "vimdoc" },
      sync_install = false,
      auto_install = true, -- Automatically install parsers for new languages
      highlight = {
        enable = true,
        -- to disable slow treesitter highlight for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = true },
    }
  end,
}
