-- plugins/toggleterm.lua

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup{
      size = 15,
      open_mapping = [[<C-\>]],
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      direction = 'float', -- you can use 'horizontal', 'vertical', 'tab' too
      float_opts = {
        border = 'curved',
        winblend = 3,
      },
      start_in_insert = true,
      persist_size = true,
      close_on_exit = true,
      shell = vim.o.shell,
    }

    -- this makes esc close terminal
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts) -- just exits terminal mode
      -- uncomment below to make esc also close the terminal entirely
      -- vim.keymap.set('t', '<Esc>', [[<C-\><C-n>:ToggleTerm<CR>]], opts)
    end

    -- apply keymap when terminal opens
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end
}

