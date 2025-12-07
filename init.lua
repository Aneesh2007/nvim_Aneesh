-----------------------------------------------------------
-- Basic options
-----------------------------------------------------------
vim.opt.expandtab    = true
vim.opt.tabstop      = 2
vim.opt.softtabstop  = 2
vim.opt.shiftwidth   = 2

vim.opt.number       = true
vim.opt.relativenumber = true
vim.opt.cursorline   = true
vim.opt.termguicolors = true

-----------------------------------------------------------
-- Bootstrap lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Leader keys
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-----------------------------------------------------------
-- Setup lazy.nvim
-----------------------------------------------------------
require("lazy").setup({
  spec = {
    -------------------------------------------------------
    -- Catppuccin colorscheme
    -------------------------------------------------------
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        require("catppuccin").setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
        })
        vim.cmd.colorscheme("catppuccin")
      end,
    },

    -------------------------------------------------------
    -- Treesitter (fixes “no parser for lua” errors)
    -------------------------------------------------------
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "lua", "vim", "vimdoc", "bash", "python", "c", "cpp" },
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    },
        -------------------------------------------------------
    -- Telescope (Fuzzy Finder)
    -------------------------------------------------------
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("telescope").setup({})
      end,
    },
  },

  -- Which colorscheme to install by default
  install = { colorscheme = { "catppuccin" } },

  -- Automatically check for plugin updates
  checker = { enabled = true },
})
