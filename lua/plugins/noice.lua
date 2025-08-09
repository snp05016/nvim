return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        progress = { enabled = true },
        signature = { enabled = true },
        hover = { enabled = true },
        message = { enabled = true },
      },
      messages = {
        enabled = true,
        view = "notify",
      },
      notify = {
        enabled = true,
      },
      cmdline = {
        enabled = true,
      },
      popupmenu = {
        enabled = true,
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    })

    vim.notify = require("notify")
  end,
}

