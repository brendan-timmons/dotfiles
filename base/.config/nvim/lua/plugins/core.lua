-- Core plugins: Treesitter configuration

return {
  -- Treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Your languages from old config
        "bash",
        "c",
        "go",
        "javascript",
        "json",
        "lua",
        "python",
        "query",
        "rust",
        "terraform",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        -- Additional useful parsers
        "html",
        "css",
        "markdown",
        "markdown_inline",
      },
      highlight = { enable = true },
      indent = { enable = true },
      -- Auto-install parsers when entering buffer
      auto_install = true,
    },
  },
}
