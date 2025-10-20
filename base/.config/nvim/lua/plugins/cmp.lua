-- Completion configuration
-- Disable completions in markdown files

return {
  {
    "saghen/blink.cmp",
    opts = {
      enabled = function()
        local disabled = false
        disabled = disabled or (vim.tbl_contains({ "markdown" }, vim.bo.filetype))
        return not disabled
      end,
    },
  },
}
