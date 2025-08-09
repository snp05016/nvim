-- ~/.config/nvim/lua/core/lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
-- The first argument "plugins" tells lazy.nvim to look for plugin specs
-- in a directory named "lua/plugins/"
require("lazy").setup("plugins", {
  -- You can configure lazy.nvim itself here, e.g.:
  checker = {
    enabled = true, -- Check for plugin updates automatically
    notify = true,  -- Notify when updates are available
  },
  change_detection = {
    enabled = true,
    notify = true, -- Notify when a plugin has changes (e.g., from git)
  },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  -- You can add a UI for lazy.nvim, for example:
  -- ui = {
  --   border = "rounded", -- or "single", "double", "shadow"
  --   title = " LazyNvim Plugins ",
  --   -- Other UI options...
  -- },
  -- Install plugins in debug mode (verbose logging)
  -- debug = true,
})