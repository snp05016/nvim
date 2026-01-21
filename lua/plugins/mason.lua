-- ~/.config/nvim/lua/plugins/mason.lua
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
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
        "rust_analyzer", -- Rust
        "ts_ls",         -- TypeScript/JavaScript
        "gopls",         -- Go
        "jdtls",         -- Java
        "bashls",        -- Bash
        "jsonls",        -- JSON
        "yamlls",        -- YAML
      },
      automatic_installation = true,
    })
  end,
}
