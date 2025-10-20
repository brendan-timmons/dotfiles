-- Customize LazyVim dashboard - remove branding, add your own style
-- LazyVim uses snacks.nvim for the dashboard
-- Also disable auto-opening neo-tree when opening a directory

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- Clean minimal header showing day of week
          header = [[


              ]] .. os.date("%A") .. [[


          ]],
          -- Alternative: Completely blank (most minimal)
          -- header = "",

          -- Alternative: Simple greeting
          -- header = [[
          --
          --
          --    Welcome back
          --
          --
          -- ]],

          -- Custom keys without Lazy Extras and Lazy options
          -- You can still access them via :Lazy and :LazyExtras commands
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects')" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },

  -- Disable neo-tree auto-opening when opening a directory
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        -- Don't hijack netrw when opening a directory
        hijack_netrw_behavior = "disabled",
        filtered_items = {
          visible = true,
        },
      },
    },
  },
}
