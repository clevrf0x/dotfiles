return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
      },
    },
  },

  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.lang.json" },
}
