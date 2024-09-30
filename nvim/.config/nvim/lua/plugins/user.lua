return {
  -- Waka time
  { "wakatime/vim-wakatime", lazy = false },

  -- Oil File Picker
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },

  -- Tree sitter config
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
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
      })
    end,
  },

  -- Change trouble config
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  -- Mason (for managing external editor tooling)
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason-LSPconfig (for installing LSP servers)
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      local lsp_servers = {
        "lua_ls",
        "bashls",
        "ts_ls",
        "rust_analyzer",
        "clangd",
        "eslint",
        "gopls",
        "html",
        "htmx",
        "jinja_lsp",
        "marksman",
        "pyright",
        "svelte",
        "taplo",
        "tailwindcss",
      }

      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
      })
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "hrsh7th/nvim-cmp",         -- Autocompletion plugin
      "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
      "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
      "L3MON4D3/LuaSnip",         -- Snippets plugin
    },
    config = function()
      local lsp_servers = {
        "lua_ls",
        "bashls",
        "tsserver",
        "rust_analyzer",
        "clangd",
        "eslint",
        "gopls",
        "html",
        "htmx",
        "jinja_lsp",
        "marksman",
        "pyright",
        "svelte",
        "taplo",
        "tailwindcss",
      }

      local function setup_lsp_servers(servers)
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        for _, lsp in ipairs(servers) do
          lspconfig[lsp].setup({
            capabilities = capabilities,
          })
        end
      end

      local function setup_keybindings_on_lsp_attach()
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspConfig", {}),
          callback = function(ev)
            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set("n", "<space>wl", function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<space>fm", function()
              vim.lsp.buf.format({ async = true })
            end, opts)
          end,
        })
      end

      local function setup_completions()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "luasnip" },
          },

          mapping = cmp.mapping.preset.insert({
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
          }),
        })
      end

      setup_lsp_servers(lsp_servers)
      setup_keybindings_on_lsp_attach()
      setup_completions()
    end,
  },

  -- TODO: Setup conform and nvim-lint
}
