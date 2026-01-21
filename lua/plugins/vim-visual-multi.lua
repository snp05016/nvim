-- ~/.config/nvim/lua/plugins/vim-visual-multi.lua
return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false,
  init = function()
    -- Configure vim-visual-multi settings before the plugin loads
    -- Use Ctrl-Down and Ctrl-Up to add cursors vertically
    -- Use Ctrl-n to select next occurrence of word under cursor
    -- Use q to skip current and get next occurrence
    -- Use Q to remove current cursor/selection
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Add Cursor Down"] = "<C-Down>",
      ["Add Cursor Up"] = "<C-Up>",
    }
  end,
}
