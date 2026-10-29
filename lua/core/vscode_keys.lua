-- VS Code-style shortcuts. <D-…> = Cmd; Ghostty passes Cmd keys to nvim via the kitty keyboard
-- protocol (nvim directly in Ghostty, not inside tmux). Ghostty's own Cmd binds that clash are
-- unbound in ~/Library/Application Support/com.mitchellh.ghostty/config.ghostty.
local map = vim.keymap.set
local tb = function(name) return function() require("telescope.builtin")[name]() end end
-- Cmd+Shift+letter can arrive as <D-S-x> or <D-X>; bind both
local function cmd_shift(mode, key, rhs, o)
  map(mode, "<D-S-" .. key .. ">", rhs, o)
  map(mode, "<D-" .. key:upper() .. ">", rhs, o)
end

-- Comment: Cmd+/
map("n", "<D-/>", "gcc", { remap = true, desc = "toggle comment" })
map("x", "<D-/>", "gcgv", { remap = true, desc = "toggle comment" })
map("i", "<D-/>", "<C-o>gcc", { remap = true, desc = "toggle comment" })

-- Save / undo / redo / select all
map({ "n", "i", "x" }, "<D-s>", "<Cmd>write<CR><Esc>", { desc = "save" })
map({ "n", "i" }, "<D-z>", "<Cmd>undo<CR>", { desc = "undo" })
cmd_shift({ "n", "i" }, "z", "<Cmd>redo<CR>", { desc = "redo" })
map({ "n", "i" }, "<D-a>", "<Esc>ggVG", { desc = "select all" })
map("x", "<D-x>", '"+d', { desc = "cut" })
map("n", "<D-x>", '"+dd', { desc = "cut line" })

-- Lines: Alt+Up/Down move (core/keymaps.lua), Shift+Alt+Up/Down copy, Cmd+Shift+K delete,
-- Cmd+] / Cmd+[ indent; Ctrl+Alt+` copy down (your VS Code binding)
map("n", "<M-S-Down>", "<Cmd>t.<CR>", { desc = "copy line down" })
map("n", "<M-S-Up>", "<Cmd>t-1<CR>", { desc = "copy line up" })
map("n", "<C-M-`>", "<Cmd>t.<CR>", { desc = "copy line down" })
map("x", "<M-S-Down>", ":t'><CR>gv", { silent = true, desc = "copy lines down" })
cmd_shift({ "n", "i" }, "k", "<Cmd>delete<CR>", { desc = "delete line" })
map("n", "<D-]>", ">>", { desc = "indent" })
map("n", "<D-[>", "<<", { desc = "outdent" })
map("x", "<D-]>", ">gv", { desc = "indent" })
map("x", "<D-[>", "<gv", { desc = "outdent" })
map("i", "<D-]>", "<C-t>", { desc = "indent" })
map("i", "<D-[>", "<C-d>", { desc = "outdent" })

-- Multi-cursor (vim-visual-multi): Cmd+D next match, Cmd+Shift+L all matches,
-- Cmd+Alt+Shift+Up/Down add cursor
map({ "n", "x" }, "<D-d>", "<Plug>(VM-Find-Under)", { desc = "select next occurrence" })
cmd_shift({ "n", "x" }, "l", "<Plug>(VM-Select-All)", { desc = "select all occurrences" })
map("n", "<D-M-S-Up>", "<Plug>(VM-Add-Cursor-Up)", { desc = "add cursor above" })
map("n", "<D-M-S-Down>", "<Plug>(VM-Add-Cursor-Down)", { desc = "add cursor below" })
map("i", "<D-M-S-Up>", "<Esc><Plug>(VM-Add-Cursor-Up)", { remap = true, desc = "add cursor above" })
map("i", "<D-M-S-Down>", "<Esc><Plug>(VM-Add-Cursor-Down)", { remap = true, desc = "add cursor below" })
map("i", "<D-d>", "<Esc><Plug>(VM-Find-Under)", { remap = true, desc = "select next occurrence" })

-- Navigation / search
map("n", "<D-p>", tb("find_files"), { desc = "quick open" })
cmd_shift("n", "p", tb("commands"), { desc = "command palette" })
cmd_shift("n", "f", tb("live_grep"), { desc = "search in files" })
cmd_shift("n", "o", tb("lsp_document_symbols"), { desc = "go to symbol" })
map("n", "<D-f>", tb("current_buffer_fuzzy_find"), { desc = "find in file" })
map("n", "<D-b>", "<Cmd>NvimTreeToggle<CR>", { desc = "toggle sidebar" })
map("n", "<C-g>", ":", { desc = "go to line (type number)" })

-- Code: F12 definition, Shift+F12 references, F2 rename, Cmd+. quick fix, Shift+Alt+F format
map("n", "<F12>", vim.lsp.buf.definition, { desc = "go to definition" })
map("n", "<S-F12>", vim.lsp.buf.references, { desc = "references" })
map("n", "<F2>", function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true, desc = "rename (live preview)" })
map({ "n", "x" }, "<D-.>", vim.lsp.buf.code_action, { desc = "quick fix" })
map("n", "<M-S-f>", function() vim.lsp.buf.format({ async = true }) end, { desc = "format" })

-- Terminal: Cmd+J / Ctrl+` toggle
map({ "n", "t" }, "<D-j>", "<Cmd>ToggleTerm<CR>", { desc = "toggle terminal" })
map({ "n", "t" }, "<C-`>", "<Cmd>ToggleTerm<CR>", { desc = "toggle terminal" })

-- Auto-surround: with text selected, typing an opening char wraps the selection (no inner spaces)
for open, close in pairs({ ['"'] = '"', ["'"] = "'", ["`"] = "`", ["("] = ")", ["["] = "]", ["{"] = "}", ["<"] = ">" }) do
  map("x", open, "<Plug>(nvim-surround-visual)" .. close, { remap = true, desc = "wrap selection in " .. open .. close })
end
