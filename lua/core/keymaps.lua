--elescope keymaps go brrrrrrr 💥

local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})     -- find files
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})      -- grep text
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})        -- buffer list
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})      -- help
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})       -- old files
-- ctrl + up to move line up
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})    -- diagnostics
-- ctrl + down to move line down
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
-- open Spectre
vim.keymap.set("n", "<leader>q", function()
  require("spectre").open()
end, { desc = "spectre 🔍" })

-- search current word
vim.keymap.set("n", "<leader>sw", function()
  require("spectre").open_visual({ select_word = true })
end, { desc = "spectre word" })

