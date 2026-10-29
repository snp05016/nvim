return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    local parsers = {
      "bash",
      "c",
      "cpp",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "vim",
    }

    treesitter.setup({})
    treesitter.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sh", "c", "cpp", "lua", "markdown", "python", "vim" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
