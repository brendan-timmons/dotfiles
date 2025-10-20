return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
    {
      "<leader>ps",
      function()
        require("telescope.builtin").grep_string({
          search = vim.fn.input("Grep > "),
        })
      end,
      desc = "Grep string",
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
      -- Add mappings for toggling hidden files
      mappings = {
        i = {
          ["<C-h>"] = function(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local opts = current_picker.finder.opts or {}
            -- Toggle hidden
            opts.hidden = not opts.hidden
            -- Refresh the picker with new options
            require("telescope.builtin").find_files(opts)
          end,
        },
        n = {
          ["H"] = function(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local opts = current_picker.finder.opts or {}
            opts.hidden = not opts.hidden
            require("telescope.builtin").find_files(opts)
          end,
        },
      },
    },
  },
}
