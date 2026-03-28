return {
  '3rd/image.nvim',
  opts = {
    backend = 'kitty',  -- change to 'iterm2' if using iTerm2, or 'ueberzug' for other terminals
    integrations = {},
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.bmp' },
  },
}
