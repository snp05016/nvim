-- Start screen, lazygit, indent guides, word highlights, zen, scratch, sessions, rainbow brackets.
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true }, -- start screen when nvim opens with no file (s = restore session)
      indent = { enabled = true },    -- indent guides + current scope line
      words = { enabled = true },     -- highlight other uses of the symbol under the cursor
      lazygit = { enabled = true },
      zen = { enabled = true },
      scratch = { enabled = true },
    },
    keys = {
      { "<leader>gg", function() Snacks.lazygit() end, desc = "lazygit" },
      { "<leader>z", function() Snacks.zen() end, desc = "zen mode" },
      { "<leader>.", function() Snacks.scratch() end, desc = "scratch buffer" },
      { "]]", function() Snacks.words.jump(1, true) end, desc = "next reference" },
      { "[[", function() Snacks.words.jump(-1, true) end, desc = "prev reference" },
    },
  },

  -- Saves open files/splits per folder; the dashboard's "Restore Session" uses it
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>sr", function() require("persistence").load() end, desc = "restore session (this folder)" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "restore last session" },
    },
  },

  -- Matching brackets share a colour
  { "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPost", "BufNewFile" } },
}
