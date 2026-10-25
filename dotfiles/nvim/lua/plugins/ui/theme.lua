-- lua/plugins/theme.lua

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "storm",
    light_style = "day",
    transparent = true, -- 这行是关键：开启透明背景
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      sidebars = "dark",
      floats = "dark",
    },
  },
}
