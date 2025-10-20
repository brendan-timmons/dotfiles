-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Leader key is already set to space by LazyVim

-- File explorer (LazyVim uses <leader>e for neo-tree, but keeping your old binding)
keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Tmux split integration (your custom workflow)
keymap.set("n", "<leader>sp", function()
  local current_directory = vim.fn.expand("%:p:h")
  current_directory = vim.fn.shellescape(current_directory)
  vim.fn.system("tmux split-window -v -b -c " .. current_directory)
end, { desc = "Tmux split above" })

-- Window navigation (if you prefer Ctrl over LazyVim's defaults)
-- keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
-- keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
-- keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
-- keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Clear search with <esc>
keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Better indenting (stay in visual mode)
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
