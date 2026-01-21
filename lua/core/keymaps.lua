--elescope keymaps go brrrrrrr 💥

local builtin = require('telescope.builtin')

-- Terminal
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })

-- Telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})     -- find files
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})      -- grep text
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})        -- buffer list
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})      -- help
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})       -- old files
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})    -- diagnostics

-- Line movement
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Spectre (search/replace)
vim.keymap.set("n", "<leader>q", function()
  require("spectre").open()
end, { desc = "spectre 🔍" })

vim.keymap.set("n", "<leader>sw", function()
  require("spectre").open_visual({ select_word = true })
end, { desc = "spectre word" })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Clear search highlighting
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { noremap = true, silent = true })

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Resize windows with arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Save with Ctrl+S
vim.keymap.set({'n', 'i', 'v'}, '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })

-- Select all
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, silent = true })

