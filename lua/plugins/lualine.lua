return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- Recommended for icons
    -- 'lewis6991/gitsigns.nvim', -- Optional, for enhanced 'diff' component
  },
  lazy = false,
  config = function()
    require('lualine').setup({
      options = {
        -- If you re-add catppuccin or another theme plugin, specify it here.
        -- theme = 'catppuccin',
        theme = 'auto', -- Tries to match your current colorscheme
        component_separators = { left = '', right = ''}, -- Nerd Font symbols
        section_separators = { left = '', right = ''},   -- Nerd Font symbols
        disabled_filetypes = {
          statusline = {'NvimTree', 'dashboard'}, -- Disable lualine for these filetypes
          winbar = {'NvimTree'},
        },
        icons_enabled = true,
        always_divide_middle = true,
        globalstatus = true, -- Single statusline for all windows (Neovim 0.7+)
      }, tabline = {lualine_a = {'buffers'}},
      sections = {
        lualine_a = {'mode'},
        lualine_b = {
          'branch', -- Git branch
          'diff',   -- Git diff status (add, modified, removed lines)
                    -- For full functionality, plugins like 'gitsigns.nvim' are helpful.
          {
            'diagnostics',
            sources = {"nvim_lsp", "nvim_diagnostic"}, -- Sources for diagnostics
            symbols = {error = " ", warn = " ", info = " ", hint = " "}, -- Nerd Font icons
            colored = true,
            update_in_insert = false, -- Update diagnostics in insert mode
            diagnostics_color = { -- Customize colors if your theme doesn't handle them
                 error = { fg = '#E06C75' }, -- Example: Red for errors
                 warn  = { fg = '#E5C07B' }, -- Example: Yellow for warnings
                 info  = { fg = '#61AFEF' }, -- Example: Blue for info
                 hint  = { fg = '#C678DD' }, -- Example: Purple for hints
            },
          }
        },
        lualine_c = {
          {
            'filename',
            file_status = true,    -- Show file status (modified, readonly)
            newfile_status = true, -- Show status for new files
            path = 1,              -- 0: filename only, 1: relative path, 3: filename [parent_dir]
            shorting_target = 40,  -- Shorten path if longer than this
            symbols = {
                modified = '[+]',
                readonly = '[-]',
                unnamed = '[No Name]',
                newfile = '[New]',
            }
          }
        },
        lualine_x = {
          {
            'searchcount',         -- Show search count "x/y"
            show = true,
            timeout = 500,
          },
          'encoding',
          'fileformat',
          'filetype',              -- Filetype icon and name (requires nvim-web-devicons)
          {
            'lsp_progress',        -- Show LSP progress messages (e.g., "LSP: Indexing...")
            display_components = {'lsp_client_name', 'progress'},
            timer = { progress_enddelay = 500, spinner = true },
            colors = { -- Custom colors for LSP progress if needed
              -- LSPServerName = { fg = '#A0A0A0' },
              -- LSPProgress = { fg = '#A0A0A0' },
            }
          }
        },
        lualine_y = {'progress'},    -- Percentage through the file (e.g., "75%")
        lualine_z = {
          'location',              -- Line and column number
          {
            -- Simple clock
            function()
              return os.date('%H:%M')
            end,
            icon = " ", -- Nerd Font clock icon
            padding = { left = 3, right = 0 }
          }
        }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'filename', file_status = true, path = 1}},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {}, -- You can configure lualine for tabline as well
      winbar = {},
      inactive_winbar = {},
      extensions = {
        'nvim-tree',    -- Integration with nvim-tree
        'toggleterm',   -- Integration with toggleterm
        'lazy',         -- Shows lazy.nvim status for updates
        'quickfix',
        'trouble',      -- If you use trouble.nvim for diagnostics
      }
    })
  end
}
