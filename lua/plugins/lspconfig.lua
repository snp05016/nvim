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

    -- <space>cf: apply clangd's fix for the nearest fixable diagnostic (cursor line first)
    vim.keymap.set('n', '<space>cf', function()
      local row = vim.api.nvim_win_get_cursor(0)[1] - 1
      local best, best_dist
      for _, d in ipairs(vim.diagnostic.get(0)) do
        local actions = d.user_data and d.user_data.lsp and d.user_data.lsp.codeActions
        if actions and actions[1] and actions[1].edit then
          local dist = math.abs(d.lnum - row)
          if not best or dist < best_dist then best, best_dist = d, dist end
        end
      end
      local client = vim.lsp.get_clients({ bufnr = 0, name = "clangd" })[1]
      if not best or not client then return vim.notify("No fix available") end
      local action = best.user_data.lsp.codeActions[1]
      vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      vim.notify("Applied: " .. action.title .. " (line " .. best.lnum + 1 .. ")")
    end, opts)
    
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Buffer local mappings
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      -- Inline type/parameter-name hints; <space>ih toggles
      if client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
      vim.keymap.set('n', '<space>ih', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, bufopts)
      vim.keymap.set('n', '<space>fs', require('telescope.builtin').lsp_document_symbols, bufopts)
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
    -- codeActionsInline: clangd embeds its fix-its in each diagnostic so we can print them.
    local clangd_caps = vim.tbl_deep_extend('force', capabilities, {
      textDocument = { publishDiagnostics = { codeActionsInline = true } },
    })
    vim.lsp.config.clangd = vim.tbl_extend('force', default_config, {
      capabilities = clangd_caps,
      handlers = {
        -- Show clangd's "note:" lines as separate hints under the error, so they get the
        -- hint colour instead of inheriting the error's red.
        ["textDocument/publishDiagnostics"] = function(err, result, ctx)
          local notes = {}
          for _, d in ipairs(result and result.diagnostics or {}) do
            for _, ri in ipairs(d.relatedInformation or {}) do
              local file = vim.fs.basename(vim.uri_to_fname(ri.location.uri))
              table.insert(notes, {
                range = d.range,
                severity = vim.lsp.protocol.DiagnosticSeverity.Hint,
                source = d.source,
                message = ("note: %s (%s:%d)"):format(ri.message, file, ri.location.range.start.line + 1),
              })
            end
          end
          vim.list_extend(result.diagnostics, notes)
          return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
        end,
      },
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
    -- Message + error code + any fixes the server offers (apply with <space>ca)
    local function format_diag(d)
      local msg = d.message:gsub(" %(fix available%)", "")
      if d.code then msg = msg .. " [" .. d.code .. "]" end
      local lsp = d.user_data and d.user_data.lsp
      for _, action in ipairs(lsp and lsp.codeActions or {}) do
        msg = msg .. "\n  fix: " .. action.title
      end
      return msg
    end

    vim.diagnostic.config({
      -- short one-liner on other lines, full multi-line explanation under the cursor line
      virtual_text = { prefix = '●', source = "if_many", current_line = false },
      virtual_lines = { current_line = true, format = format_diag },
      update_in_insert = false,
      severity_sort = true,
      float = { source = true, border = "rounded", format = format_diag },
    })
    
    -- Auto-format C/C++ files on quit (not on save, so undo history stays clean).
    -- Skips buffers with unsaved changes so :q! still discards them.
    vim.api.nvim_create_autocmd("QuitPre", {
      pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.cc", "*.cxx" },
      callback = function()
        if vim.bo.modified then return end
        vim.lsp.buf.format({ async = false })
        if vim.bo.modified then vim.cmd("silent write") end
      end,
    })
  end,
}
