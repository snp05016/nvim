return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "cpp", "lua", "python", "vim", "bash" }, -- add ur langs here
      highlight = {
        enable = true, -- turn this shit on
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}

