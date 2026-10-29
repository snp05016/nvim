-- ~/.config/nvim/lua/plugins/everforest.lua
return {
  "sainnhe/everforest", -- Or "neanias/everforest-nvim" if you prefer the pure Lua version
  lazy = true,          -- available via :colorscheme everforest
  priority = 1000,      -- Ensure it loads before other UI plugins
  config = function()
    -- Set your preferred Everforest background style: 'soft', 'medium', or 'hard'
    vim.g.everforest_background = "medium"

    -- Enable or disable italics (ensure your terminal font supports italics)
    vim.g.everforest_enable_italic = true -- Set to false or 0 to disable

    -- You can add other Everforest-specific settings here, for example:
    -- vim.g.everforest_cursor = "orange"
    vim.g.everforest_transparent_background = 1 -- keep the see-through look tokyonight had
    vim.g.everforest_better_performance = 1


    -- Apply the colorscheme
    -- If using 'neanias/everforest-nvim', the setup might look like this instead:
    -- require("everforest").setup({
    --   background = "medium",
    --   enable_italic = true,
    --   -- Add other options for neanias/everforest-nvim here
    -- })
    -- vim.cmd.colorscheme "everforest" -- or require("everforest").load()
  end,
}