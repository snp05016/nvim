-- plugins/scrollbar.lua

return {
  'petertriho/nvim-scrollbar',
  config = function()
    require('scrollbar').setup{
      -- you can customize this bad boy if you want
      -- for now, keep it default and smooth as hell
    }
  end
}

