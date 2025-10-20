-- UI customizations
-- Change THEME to switch colorschemes

local THEME = "tokyonight" -- Options: "tokyonight", "rose-pine"

return {
  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    enabled = THEME == "tokyonight",
    priority = 1000,
    opts = {
      style = "night", -- storm, moon, night, day
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = THEME == "rose-pine",
    priority = 1000,
    opts = {
      variant = "main", -- auto, main, moon, dawn
      dark_variant = "main",
      styles = {
        transparency = true,
      },
    },
  },

  -- Configure LazyVim colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = THEME,
    },
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "thin",
      },
    },
  },

  -- Disable unused colorschemes
  { "catppuccin/nvim", enabled = false },
}
