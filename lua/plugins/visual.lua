return {
  -- Errors as rounded labels at the end of the line (replaces nvim's own virtual text/lines)
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          -- reuse the message + [code] + fix list built in lspconfig.lua
          format = function(d) return vim.diagnostic.config().float.format(d) end,
          multilines = { enabled = true },
          show_all_diags_on_cursorline = true,
          overflow = { mode = "wrap" },
          show_related = { enabled = false }, -- notes already show as their own hints
        },
      })
      vim.diagnostic.config({ virtual_text = false, virtual_lines = false })
    end,
  },

  -- Clickable breadcrumbs at the top of each window: file › class › function
  { "Bekaboo/dropbar.nvim", event = { "BufReadPost", "BufNewFile" } },
}
