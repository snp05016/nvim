-- plugins/barbar.lua
return {
  'romgrk/barbar.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- for icons
    'lewis6991/gitsigns.nvim'      -- optional, for git stuff
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  config = function()
    require'barbar'.setup {
      animation = true,
      auto_hide = false,
      tabpages = true,
      clickable = true,
      icons = {
        buffer_index = true,
        buffer_number = false,
        button = '',
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
          [vim.diagnostic.severity.WARN] = {enabled = true, icon = ''},
          [vim.diagnostic.severity.INFO] = {enabled = true, icon = ''},
          [vim.diagnostic.severity.HINT] = {enabled = true, icon = ''},
        },
        gitsigns = {
          added = {enabled = true, icon = '+'},
          changed = {enabled = true, icon = '~'},
          deleted = {enabled = true, icon = '-'},
        },
        filetype = {
          custom_colors = false,
          enabled = true,
        },
      },
    }
  end
}

