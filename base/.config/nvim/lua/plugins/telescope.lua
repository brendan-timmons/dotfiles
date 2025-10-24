return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>pf",
      function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
      end,
      desc = "Find files",
    },
    {
      "<leader>fh",
      function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick("find_files", { no_ignore = false, default_text = line, hidden = true })()
      end,
      desc = "Find hidden files",
    },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      },
      file_ignore_patterns = { "node_modules", ".git/" },
    },
  },
}
