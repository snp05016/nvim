vim.g.mapleader = " "
require("core.lazy")
vim.o.number = true   
vim.o.relativenumber = true  
vim.cmd("syntax on")
--require("lualine").setup()
vim.o.termguicolors = true
vim.opt.shortmess:append("sI")
vim.cmd.colorscheme("gruvbox-material")
require("core.keymaps")

-- Global copy to system clipboard with space+y
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy to system clipboard" })
vim.api.nvim_set_keymap('n', '!', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- move to prev tab
vim.keymap.set('n', '<S-h>', '<Cmd>BufferPrevious<CR>', { desc = 'prev buffer' })

-- move to next tab
vim.keymap.set('n', '<S-l>', '<Cmd>BufferNext<CR>', { desc = 'next buffer' })

-- reorder buffers
vim.keymap.set('n', '<A-,>', '<Cmd>BufferMovePrevious<CR>', { desc = 'move buffer left' })
vim.keymap.set('n', '<A-.>', '<Cmd>BufferMoveNext<CR>', { desc = 'move buffer right' })

-- pin/unpin buffer
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', { desc = 'pin buffer' })

-- close buffer
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', { desc = 'close buffer' })
-- override yy to yank to both default and system clipboard
-- make y yank to both unnamed and system clipboard
-- in visual mode, y will yank to both normal and clipboard
vim.keymap.set("v", "y", function()
  vim.cmd('normal! y')
  vim.cmd('normal! "+y')
end, { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<C-w>w', { noremap = true, silent = true })
-- lua version
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
-- ctrl + up to move line up
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
-- ctrl + down to move line down
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })

vim.o.cursorline = true
vim.o.winborder = "rounded" -- hover, signature help and other LSP popups
require("core.vscode_keys")
