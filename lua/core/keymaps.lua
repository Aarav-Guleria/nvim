local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- File Explorer
keymap("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle File Explorer" })

-- Terminal ESC to normal mode
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize smaller" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize bigger" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize smaller" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize bigger" })

-- Move lines in visual mode --using mini for this
-- keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
-- keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Paste over selection without yanking
keymap("x", "<leader>p", [["_dP]], { desc = "Paste over selection" })

-- Delete without yanking
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- Escape and Clear
keymap("i", "jj", "<ESC>", opts)
keymap("n", "<leader><esc>", ":noh<CR>", { desc = "Clear search highlight" })

-- Indent in visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Scrolling and centering
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<Cgg-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Make file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Save and Quit
keymap("n", "<leader>w", ":w<CR>", { desc = "Write file" })
keymap("n", "<leader>q", ":qa<CR>", { desc = "Quit all" })

-- Buffers (Replaces old Tab mappings for a more buffer-centric workflow)
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
keymap("n", "<leader>bN", ":enew<CR>", { desc = "New buffer" })

-- Splits
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
