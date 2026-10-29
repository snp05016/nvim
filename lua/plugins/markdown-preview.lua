return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = ":call mkdp#util#install_sync()",
  ft = { "markdown" },
}
