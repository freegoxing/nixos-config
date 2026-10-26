-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Use the completion engine selected by the LazyVim nvim-cmp extra.
vim.g.lazyvim_cmp = "nvim-cmp"

-- 设置缩进为 4 个空格
vim.opt.tabstop = 4 -- 一个 tab 等于 4 个空格
vim.opt.shiftwidth = 4 -- >> << 时移动的宽度为 4
vim.opt.expandtab = true -- 将 tab 转换为空格
vim.opt.smartindent = true -- 自动缩进
