local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- File Explorer
keymap("n", "<leader>e", ":Neotree toggle<CR>", opts)

-- Terminal ESC to normal mode
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move lines in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Paste over selection without yanking
keymap("x", "<leader>p", [["_dP]], opts)
keymap("v", "p", '"_dp', opts)

-- Delete without yanking
keymap({ "n", "v" }, "<leader>d", [["_d]], opts)
keymap("n", "x", '"_x', opts)

-- Escape from insert or visual mode
keymap("i", "jj", "<ESC>", opts)
keymap("i", "<C-c>", "<Esc>", opts)
keymap("n", "<C-c>", ":noh<CR>", { desc = "Clear search highlight" })

-- Indent in visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Scrolling and centering
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down & center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up & center" })
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Make file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Save and Quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":qa<CR>", opts)

-- Tabs
keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current file in new tab" })

-- Splits
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

