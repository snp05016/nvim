-- ~/.config/nvim/lua/plugins/tokyonight.lua
return {
  "folke/tokyonight.nvim",
  lazy = true, -- available via :colorscheme tokyonight
  config = function()
    require("tokyonight").setup({
      style = "night", -- "storm", "moon", "night", or "day"
      transparent = true, -- Enable transparent background
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      sidebars = { "qf", "help", "terminal", "NvimTree" }, -- Set sidebars to transparent
      on_colors = function(colors)
        -- Customize specific colors if needed
      end,
      on_highlights = function(highlights, colors)
        -- Customize specific highlight groups if needed
      end,
    })

  end,
}
