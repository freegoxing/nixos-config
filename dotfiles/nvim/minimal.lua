-- ~/.config/nvim/minimal.lua
-- 极简 LazyVim 配置 + UI (tokyonight + lualine + Treesitter + VimTeX)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- UI 主题
        {
            "folke/tokyonight.nvim",
            priority = 1000,
            config = function()
                vim.cmd.colorscheme("tokyonight")
            end,
        },
        -- 状态栏
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require("lualine").setup({
                    options = { theme = "tokyonight" },
                })
            end,
        },
        -- -- Treesitter 语法高亮
        {
            "nvim-treesitter/nvim-treesitter",
            opts = {
                ensure_installed = {
                    "bash",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "tsx",
                    "typescript",
                    "vim",
                    "yaml",
                },
            },
        },

        -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
        -- would overwrite `ensure_installed` with the new value.
        -- If you'd rather extend the default config, use the code below instead:
        {
            "nvim-treesitter/nvim-treesitter",
            opts = function(_, opts)
                -- add tsx and treesitter
                vim.list_extend(opts.ensure_installed, {
                    "tsx",
                    "typescript",
                })
            end,
        },
        -- VimTeX for LaTeX 支持
        {
            "lervag/vimtex",
            -- ft = { "tex" }, -- 仅在打开 tex 文件时加载
            config = function()
                vim.g.vimtex_view_method = 'zathura'
                vim.g.vimtex_compiler_method = 'latexmk'
                vim.g.vimtex_quickfix_mode = 0
                vim.g.vimtex_fold_enabled = true
            end,
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp", -- LSP 补全
                "L3MON4D3/LuaSnip",     -- Snippets 引擎
                "saadparwaiz1/cmp_luasnip", -- Snippets 补全源
            },
            opts = function(_, opts)
                local cmp = require("cmp")
                opts.sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP 来源
                    { name = "luasnip" }, -- Snippets 来源
                }, opts.sources or {})

                opts.snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                }

                return opts
            end,
        }
    },
})
