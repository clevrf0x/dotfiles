-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Setup leader key as space
vim.g.mapleader = " "

-- Uses spaces as tabs and set tab width to 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Disable line wrap
vim.opt.wrap = false

-- Absolute and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable system clipboard for yanking
vim.opt.clipboard:append("unnamedplus")

-- Enable Auto intend
vim.opt.autoindent = true
