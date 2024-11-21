-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(event)
    -- Only format if it's not a JavaScript/TypeScript file
    if
        not vim.tbl_contains(
          { "javascript", "typescript", "javascriptreact", "typescriptreact" },
          vim.bo[event.buf].filetype
        )
    then
      vim.lsp.buf.format({ async = false })
    end
  end,
})
