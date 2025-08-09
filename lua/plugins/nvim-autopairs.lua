-- plugins/nvim-autopairs.lua
return {
  'windwp/nvim-autopairs', -- auto close brackets, quotes, parens etc
  config = function()
    require('nvim-autopairs').setup{
      check_ts = true,       -- enable treesitter integration, helps with smarter pairing
      fast_wrap = {},        -- enable fast wrap feature (wrap brackets quickly)
      disable_filetype = { "TelescopePrompt", "vim" }, -- disable in these filetypes
    }
  end
}

