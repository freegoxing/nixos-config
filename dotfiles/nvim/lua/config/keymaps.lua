-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 复制粘贴设置
vim.keymap.set("v", "<C-c>", '"+y', { desc = "复制选中内容到剪贴板" })
vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })

-- 文件树
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "打开/关闭文件树" })
-- 文件树内操作快捷键
-- 文件树内部快捷键（只对 NvimTree buffer 生效）
vim.api.nvim_create_autocmd("FileType", {
    pattern = "NvimTree",
    callback = function()
        local opts = { buffer = true }
        vim.keymap.set(
            "n",
            "a",
            "<cmd>lua require'nvim-tree.actions.files'.create()<CR>",
            { desc = "创建文件/目录", buffer = true }
        )
        vim.keymap.set(
            "n",
            "d",
            "<cmd>lua require'nvim-tree.actions.files'.remove()<CR>",
            { desc = "删除文件/目录", buffer = true }
        )
        vim.keymap.set(
            "n",
            "r",
            "<cmd>lua require'nvim-tree.actions.files'.rename()<CR>",
            { desc = "重命名文件/目录", buffer = true }
        )
        vim.keymap.set(
            "n",
            "x",
            "<cmd>lua require'nvim-tree.actions.files'.cut()<CR>",
            { desc = "剪切文件/目录", buffer = true }
        )
        vim.keymap.set(
            "n",
            "<leader>tp",
            "<cmd>lua require'nvim-tree.actions.files'.paste()<CR>",
            { desc = "粘贴文件/目录", buffer = true }
        )
        vim.keymap.set("n", "R", "<cmd>lua require'nvim-tree'.refresh()<CR>", {
            desc = "刷新文件树",
            buffer = true,
        })
        vim.keymap.set(
            "n",
            ".",
            "<cmd>lua require'nvim-tree'.toggle_dotfiles()<CR>",
            { desc = "显示/隐藏隐藏文件", buffer = true }
        )
        vim.keymap.set("n", "q", "<cmd>NvimTreeClose<CR>", { desc = "关闭文件树", buffer = true })
        vim.keymap.set(
            "n",
            "<CR>",
            "<cmd>lua require'nvim-tree.actions.node'.open.edit()<CR>",
            { desc = "打开文件/进入目录", buffer = true }
        )
    end,
})

-- LuaSnip snippet jump and expand
vim.keymap.set({ "i", "s" }, "<Tab>", function()
    local ls = require("luasnip")
    return ls.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
end, { expr = true, silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
    local ls = require("luasnip")
    return ls.jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>"
end, { expr = true, silent = true })

-- Quickfix 控制
vim.keymap.set("n", "<leader>co", ":copen<CR>", { desc = "打开 Quickfix" })
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { desc = "关闭 Quickfix" })
vim.keymap.set("n", "<leader>cw", ":cwindow<CR>", { desc = "切换 Quickfix" })

-- 快速跳转错误
vim.keymap.set("n", "<leader>cp", ":cprev<CR>", { desc = "上一个错误" })
vim.keymap.set("n", "<leader>cn", ":cnext<CR>", { desc = "下一个错误" })

-- vimtex
vim.keymap.set("n", "<leader>ll", function()
    vim.cmd("w")
    vim.cmd("VimtexCompile")
end, { desc = "LaTeX 编译" })
vim.keymap.set("n", "<leader>lw", function()
    vim.cmd("w")
    vim.cmd("VimtexView")
end, { desc = "LaTeX 保存文件" })
vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<CR>", { desc = "停止编译" })
vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "打开 PDF 预览" })
vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<CR>", { desc = "切换目录视图" })
vim.keymap.set("n", "<leader>ln", "<cmd>VimtexErrorsNext<CR>", { desc = "跳转到下一个编译错误" })
vim.keymap.set("n", "<leader>lp", "<cmd>VimtexErrorsPrev<CR>", { desc = "跳转到上一个编译错误" })
vim.keymap.set("n", "<leader>llg", "<cmd>VimtexLog<CR>", { desc = "打开编译日志" })
vim.keymap.set("n", "<leader>li", "<cmd>VimtexInfo<CR>", { desc = "打开VimTeX配置" })
vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<CR>", { desc = "清理辅助文件" })
vim.keymap.set("n", "<leader>lC", "<cmd>VimtexClean!<CR>", { desc = "完全清理（包括 PDF）" })
