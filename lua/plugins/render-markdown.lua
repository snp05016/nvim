-- Renders headings, lists, code blocks, tables and checkboxes inside the markdown buffer.
-- :RenderMarkdown toggle switches back to raw text.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {},
}
