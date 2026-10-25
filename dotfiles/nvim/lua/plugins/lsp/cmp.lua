return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP 补全
    "L3MON4D3/LuaSnip", -- Snippets 引擎
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
