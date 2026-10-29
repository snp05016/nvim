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
          statusline = {'NvimTree', 'dashboard', 'snacks_dashboard'}, -- Disable lualine for these filetypes
          winbar = {'NvimTree'},
        },
        icons_enabled = true,
        always_divide_middle = true,
        globalstatus = true, -- Single statusline for all windows (Neovim 0.7+)
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {
          'branch', -- Git branch
          {
            'diff', -- counts come from gitsigns so they match the gutter markers
            source = function()
              local g = vim.b.gitsigns_status_dict
              if g then return { added = g.added, modified = g.changed, removed = g.removed } end
            end,
          },
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
          {
            -- Last <space>c build: ✓ / ✗ / …
            function()
              return ({ ok = "󰄬 build", failed = "󰅖 build", building = "󰔟 build" })[vim.g.build_status]
            end,
            cond = function() return vim.g.build_status ~= nil end,
            color = function()
              return { fg = ({ ok = "#a9b665", failed = "#ea6962", building = "#d8a657" })[vim.g.build_status] }
            end,
          },
          {
            -- Debugger state while a session is running
            function() return " " .. require("dap").status() end,
            cond = function() return package.loaded.dap ~= nil and require("dap").status() ~= "" end,
            color = { fg = "#e78a4e" },
          },
          'filetype',
          { 'lsp_status', icon = "" }, -- attached language servers (e.g. clangd)
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
