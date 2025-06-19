vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = false,
}
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "x", '"_x', { desc = "Delete char without yank" }) --to delete without yanking to windows clipboard
