-- ~/.config/nvim/lua/plugins/vim-visual-multi.lua
return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false,
  init = function()
    -- Ctrl+j: add cursor down
    -- Ctrl+k: add cursor up
    -- Ctrl+n: select word occurrences
    
    vim.g.VM_maps = {
      ["Add Cursor Down"] = "<C-j>",
      ["Add Cursor Up"] = "<C-k>",
    }
  end,
}
