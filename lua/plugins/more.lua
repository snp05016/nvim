-- Jumping, sticky context, CMake, git diffs, live rename, surround, TODOs, file editing, AI suggestions.

-- Undo history tree (built into nvim 0.12, no plugin needed)
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", "<Cmd>Undotree<CR>", { desc = "undo tree" })

return {
  -- s + 2 letters: jump anywhere on screen; S: select a treesitter node
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "flash jump" },
      { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "flash select node" },
    },
  },

  -- Current function/loop header stays pinned at the top while scrolling
  { "nvim-treesitter/nvim-treesitter-context", event = { "BufReadPost", "BufNewFile" }, opts = { max_lines = 3 } },

  -- CMake projects: <space>c / Ctrl+B / Alt+B build & run via CMake when a CMakeLists.txt exists
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "c", "cpp", "cmake" },
    opts = {},
  },

  -- Side-by-side git diffs and file history
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "git diff view" },
      { "<leader>gh", "<Cmd>DiffviewFileHistory %<CR>", desc = "git file history" },
      { "<leader>gq", "<Cmd>DiffviewClose<CR>", desc = "close diff view" },
    },
  },

  -- F2 rename with live preview of every change
  { "smjonas/inc-rename.nvim", cmd = "IncRename", opts = {} },

  -- ys{motion}{char} add, cs{old}{new} change, ds{char} delete surroundings
  { "kylechui/nvim-surround", event = { "BufReadPost", "BufNewFile" }, opts = {} },

  -- Highlight TODO/FIXME/HACK/NOTE; list them in the problems panel
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = { { "<leader>xt", "<Cmd>Trouble todo toggle<CR>", desc = "TODO list" } },
  },

  -- Edit a directory like a buffer: rename/move/delete files by editing lines, :w to apply
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = { view_options = { show_hidden = true } },
    keys = { { "-", "<Cmd>Oil<CR>", desc = "open parent folder (oil)" } },
  },

  -- Cursor leaves a short trail when it jumps
  { "sphamba/smear-cursor.nvim", event = "VeryLazy", opts = {} },

  -- AI inline suggestions (free tier; sign-in prompt on first use)
  -- Ctrl+L accept, Ctrl+J accept one word, Ctrl+] dismiss. Tab stays with the completion menu.
  {
    "supermaven-inc/supermaven-nvim",
    enabled = false, -- disabled; set to true to turn AI suggestions back on
    event = "InsertEnter",
    opts = {
      keymaps = { accept_suggestion = "<C-l>", accept_word = "<C-j>", clear_suggestion = "<C-]>" },
    },
  },
}
