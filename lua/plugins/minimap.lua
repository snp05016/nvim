return {
  "wfxr/minimap.vim",
  build = "cargo install --locked code-minimap",  -- rust binary build
  config = function()
    vim.g.minimap_auto_start = 1             -- minimap auto start always on
    vim.g.minimap_auto_start_win_enter = 1   -- reopen minimap on window enter
    vim.g.minimap_width = 10                  -- minimap width in chars
    vim.g.minimap_highlight_range = 1         -- highlight visible range
    vim.g.minimap_git_colors = 1               -- git diff colors enabled
  end,
}

