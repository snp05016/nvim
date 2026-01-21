-- ~/.config/nvim/lua/plugins/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    
    -- Global keymaps for LSP
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Buffer local mappings
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, bufopts)
    end
    
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = cmp_nvim_lsp.default_capabilities()
    
    -- Base config for all servers
    local default_config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    
    -- Configure language servers using new API
    
    -- Lua
    vim.lsp.config.lua_ls = vim.tbl_extend('force', default_config, {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
    
    -- Python
    vim.lsp.config.pyright = vim.tbl_extend('force', default_config, {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          }
        }
      }
    })
    
    -- C/C++
    vim.lsp.config.clangd = vim.tbl_extend('force', default_config, {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style={ColumnLimit: 60}",
      },
    })
    
    -- Rust
    vim.lsp.config.rust_analyzer = vim.tbl_extend('force', default_config, {
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            command = "clippy"
          },
        }
      }
    })
    
    -- TypeScript/JavaScript  
    vim.lsp.config.ts_ls = default_config
    
    -- Go
    vim.lsp.config.gopls = default_config
    
    -- Java
    vim.lsp.config.jdtls = default_config
    
    -- Bash
    vim.lsp.config.bashls = default_config
    
    -- JSON
    vim.lsp.config.jsonls = default_config
    
    -- YAML
    vim.lsp.config.yamlls = default_config
    
    -- Enable language servers
    vim.lsp.enable({'lua_ls', 'pyright', 'clangd', 'rust_analyzer', 'ts_ls', 'gopls', 'jdtls', 'bashls', 'jsonls', 'yamlls'})
    
    -- Configure diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    
    -- Configure diagnostic display
    vim.diagnostic.config({
      virtual_text = {
        prefix = '●',
      },
      update_in_insert = false,
      float = {
        source = "always",
      },
    })
    
    -- Auto-format C/C++ files on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.cc", "*.cxx" },
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
