return {
  {
    "b0o/incline.nvim", --shows plugins names on the topright
    enabled = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local devicons = require("nvim-web-devicons")

      require("incline").setup({
        hide = {
          only_win = false,
        },
        render = function(props)
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ":t")
          if filename == "" then
            filename = "[No Name]"
          end

          local ext = vim.fn.fnamemodify(bufname, ":e")
          local icon, _ = devicons.get_icon(filename, ext, { default = true })
          local modified = vim.bo[props.buf].modified
          local filetype = vim.bo[props.buf].filetype or "none"

          return {
            { " ", icon or "", " ", group = "Function" }, -- Icon with colorscheme group
            { filename, group = modified and "DiagnosticWarn" or "Normal" },
            modified and { " [+]", group = "DiagnosticWarn" } or "",
            { " · ", filetype:upper(), group = "Type" },
            " ",
          }
        end,
      })
    end,
  },
}
