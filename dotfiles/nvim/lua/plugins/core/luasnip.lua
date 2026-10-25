return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local ls = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load({
            exclude = { "latex" },
        })
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
        })

        -- 可选：配置一些行为
        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true, -- 自动触发关键
        })
    end,
}
