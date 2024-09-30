require "nvchad.options"

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
vim.opt.relativenumber = false

-- Enable system clipboard for yanking
vim.opt.clipboard:append "unnamedplus"

-- Enable Auto intend
vim.opt.autoindent = true

-- Ignores case-sensitivity in searches, but if word contains
-- Upper case letters, turn back case-sensitivity
vim.opt.ignorecase = true
vim.opt.smartcase = true
