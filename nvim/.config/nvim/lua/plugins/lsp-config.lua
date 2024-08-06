-- List of Language Server Protocol (LSP) servers to be configured
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
  "yamlls",
}

-- Function to set up LSP servers
local function setup_lsp_servers(servers)
  local lspconfig = require "lspconfig"
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      capabilities = capabilities,
    }
  end
end

-- Function to set up keybindings on LSP attach
local function setup_keybindings_on_lsp_attach()
  -- Use LspAttach autocommand to map keys after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      -- Buffer local mappings.
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
      -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<space>fm", function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })
end

-- Function to set up completions
local function setup_completions()
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "luasnip" },
      -- { name = "orgmode" },
      -- { name = "neorg" },
    },

    mapping = cmp.mapping.preset.insert {
      ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
      ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Down
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
  }
end

-- Function to format file before saving
local function format_files_before_save()
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(event)
      -- Only format if it's not a JavaScript/TypeScript file
      if
          not vim.tbl_contains(
            { "javascript", "typescript", "javascriptreact", "typescriptreact" },
            vim.bo[event.buf].filetype
          )
      then
        vim.lsp.buf.format { async = false }
      end
    end,
  })
end

-- Main setup section
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = lsp_servers,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "hrsh7th/nvim-cmp",         -- Autocompletion plugin,
      "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp,
      "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
      "L3MON4D3/LuaSnip",         -- Snippets plugin
    },
    config = function()
      setup_lsp_servers(lsp_servers)
      setup_keybindings_on_lsp_attach()
      setup_completions()
      format_files_before_save()
    end,
  },
}
