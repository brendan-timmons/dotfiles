-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Line numbers
opt.relativenumber = true -- Relative line numbers (LazyVim default, keeping explicit)
opt.number = true -- Show absolute line number on cursor line (LazyVim default)

-- Tabs / Indentation (matching your old config)
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false -- Disable line wrap

-- Search
opt.hlsearch = false -- Don't highlight search results
opt.incsearch = true -- Incremental search

-- Appearance
opt.termguicolors = true -- True color support (LazyVim default)
opt.colorcolumn = "80" -- Show column at 80 chars

-- Performance
opt.updatetime = 50 -- Faster completion (LazyVim default is 200)

-- Clipboard - keep separate from system (intentional choice)
-- opt.clipboard:append({ "unnamedplus" }) -- Disabled: prefer separate clipboards

-- Disable auto-comment on new line (optional, but often desired)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
