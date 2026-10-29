-- IDE-style extras: key hints, git gutter, problems panel, debugger, build & run.

-- Compile the current C/C++ file next to itself with debug info. Returns exe path + command.
local function build_cmd()
  vim.cmd("silent write")
  local src, exe = vim.fn.expand("%:p"), vim.fn.expand("%:p:r")
  local cc = vim.bo.filetype == "c" and "clang -std=c17" or "clang++ -std=c++20"
  return exe, ("%s -g -Wall -Wextra %s -o %s"):format(cc, vim.fn.shellescape(src), vim.fn.shellescape(exe))
end

local function build_and_run()
  if vim.fs.root(0, "CMakeLists.txt") then
    return vim.cmd("CMakeRun") -- CMake project: build target via cmake-tools, then run it
  end
  local exe, cmd = build_cmd()
  vim.g.build_status = "building"
  -- Compile in the background; the statusline shows the result, the terminal only runs it
  vim.system({ "sh", "-c", cmd }, { text = true }, vim.schedule_wrap(function(res)
    vim.g.build_status = res.code == 0 and "ok" or "failed"
    if res.code == 0 then
      require("toggleterm").exec(vim.fn.shellescape(exe))
    else
      vim.notify(res.stderr, vim.log.levels.ERROR, { title = "build failed" })
    end
  end))
end

return {
  -- Popup listing what every key does after you press <space> (or g, ], etc.)
  -- registers popup off: it hijacks " in visual mode, which wraps the selection in quotes (vscode_keys.lua)
  { "folke/which-key.nvim", event = "VeryLazy", opts = { plugins = { registers = false } } },

  -- Git: changed-line markers, inline blame, hunk preview/reset
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(l, r, desc) vim.keymap.set("n", l, r, { buffer = bufnr, desc = desc }) end
        map("]h", function() gs.nav_hunk("next") end, "next git hunk")
        map("[h", function() gs.nav_hunk("prev") end, "prev git hunk")
        map("<leader>hp", gs.preview_hunk, "preview hunk")
        map("<leader>hr", gs.reset_hunk, "reset hunk")
        map("<leader>hs", gs.stage_hunk, "stage hunk")
        map("<leader>hb", function() gs.blame_line({ full = true }) end, "blame line")
      end,
    },
  },

  -- Problems panel (like VS Code's)
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "problems (all files)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "problems (this file)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "symbol outline" },
    },
  },

  -- Build & run current C/C++ file in the floating terminal
  {
    "akinsho/toggleterm.nvim",
    lazy = false, -- keys below would otherwise make it lazy and break <C-\\>
    keys = {
      { "<leader>c", build_and_run, ft = { "c", "cpp" }, desc = "build & run" },
      { "<C-b>", build_and_run, ft = { "c", "cpp" }, desc = "build & run" }, -- VS Code: ctrl+b build task
      { "<M-b>", build_and_run, ft = { "c", "cpp" }, desc = "build & run" }, -- VS Code: alt+b cmake build
    },
  },

  -- Debugger (codelldb). F5 builds the current file and starts debugging.
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      { "jay-babu/mason-nvim-dap.nvim", opts = { ensure_installed = { "codelldb" } } },
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "debug: start/continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "debug: step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "debug: step into" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "debug: step out" },
      { "<S-F5>", function() require("dap").terminate() end, desc = "debug: stop" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "toggle breakpoint" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "toggle breakpoint" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "debug: stop" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "debug: toggle UI" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized.dapui = dapui.open
      dap.listeners.before.event_terminated.dapui = dapui.close
      dap.listeners.before.event_exited.dapui = dapui.close

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = { command = vim.fn.stdpath("data") .. "/mason/bin/codelldb", args = { "--port", "${port}" } },
      }
      local config = {
        {
          name = "Build & debug current file",
          type = "codelldb",
          request = "launch",
          cwd = "${fileDirname}",
          program = function()
            local exe, cmd = build_cmd()
            local out = vim.fn.system(cmd)
            if vim.v.shell_error ~= 0 then
              vim.notify(out, vim.log.levels.ERROR, { title = "build failed" })
              return dap.ABORT
            end
            return exe
          end,
        },
      }
      dap.configurations.c, dap.configurations.cpp = config, config
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    end,
  },
}
