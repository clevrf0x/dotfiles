return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    require("mason-null-ls").setup {
      ensure_installed = {
        "stylua",
        "jq",
        "eslint_d",
        "gomodifytags",
        "actionlint",
        "impl",
        "checkmake",
        "djlint",
        "hadolint",
        "markdownlint",
        "mypy",
        "isort",
        "black",
        "pylint",
        "staticcheck",
        "stylelint",
        "yamllint",
        "djhtml",
        "gofmt",
        "goimports",
        "golines",
        "prettierd",
        "yamlfmt",
      },
    }

    local null_ls = require "null-ls"
    null_ls.setup {
      sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.impl,

        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.biome,
        null_ls.builtins.formatting.djhtml,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.stylelint,
        null_ls.builtins.formatting.yamlfmt,

        null_ls.builtins.completion.tags,

        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.djlint,
        null_ls.builtins.diagnostics.hadolint,
        -- null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.diagnostics.staticcheck,
        -- null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.yamllint,
        require "none-ls.diagnostics.eslint_d",
      },
    }
  end,
}
