-- UI customizations: Rose Pine theme and transparent background

return {
  -- Rose Pine colorscheme (matching your terminal theme!)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main",
      styles = {
        transparency = true, -- Enable transparent background
      },
    },
  },

  -- Configure LazyVim to use Rose Pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },

  -- Make background transparent (your custom ColorMyPencils function)
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = true,
        },
      })

      vim.cmd("colorscheme rose-pine")

      -- Apply transparent background
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },

  -- Configure bufferline to match Rose Pine
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "thin",
      },
    },
  },

  -- Optional: Disable LazyVim's default colorscheme plugins
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },
}
