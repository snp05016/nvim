-- ~/.config/nvim/lua/plugins/mason.lua
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })
    
    require("mason-lspconfig").setup({
      -- Automatically install these language servers
      ensure_installed = {
        "lua_ls",        -- Lua
        "pyright",       -- Python
        "clangd",        -- C/C++
        "ts_ls",         -- TypeScript/JavaScript
        "bashls",        -- Bash
      },
      automatic_installation = true,
    })
  end,
}
