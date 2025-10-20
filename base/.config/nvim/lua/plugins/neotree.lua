-- Neo-tree configuration
-- Disable auto-opening when opening a directory

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        hijack_netrw_behavior = "disabled",
        filtered_items = {
          visible = true,
        },
      },
    },
  },
}
