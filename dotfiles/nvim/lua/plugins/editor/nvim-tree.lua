return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        hijack_netrw = true, -- 确保接管 vi . 命令
        view = {
            side = "right", -- 设置文件树显示在右侧
            width = 30, -- 设置文件树的宽度
        },
        renderer = {
            highlight_opened_files = "name", -- 高亮显示打开的文件
        },
        git = {
            enable = true,
            ignore = false, -- 显示 .gitignore 忽略的文件
            timeout = 500,
        },
        filters = {
            dotfiles = false, -- 显示隐藏文件
            custom = {}, -- 确保没有自定义过滤
        },
        on_attach = function(bufnr)
            local api = require("nvim-tree.api")
            api.map.on_attach.default(bufnr)

            vim.keymap.set("n", "<leader>tp", api.fs.paste, {
                buffer = bufnr,
                desc = "粘贴文件/目录",
            })
        end,
    },
}
