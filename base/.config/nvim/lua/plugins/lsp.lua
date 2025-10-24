-- LSP Configuration
-- LazyVim has great LSP defaults, we're just ensuring your servers are installed

return {
  -- Mason: LSP installer
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Your language servers from old config
        "lua-language-server",
        "rust-analyzer",
        "gopls",
        "terraform-ls",
        "svelte-language-server",
        "eslint-lsp",
        "python-lsp-server",
        -- Additional useful tools
        "stylua", -- Lua formatter
        "shfmt", -- Shell formatter
      },
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Lua LSP (with vim globals)
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "Lua 5.1" },
              diagnostics = {
                globals = { "vim", "it", "describe", "before_each", "after_each" },
              },
              workspace = {
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },

        -- Terraform LSP (with custom file types)
        terraformls = {
          filetypes = { "terraform", "tf", "hcl" },
          root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
          end,
        },

        -- Rust (rust-analyzer is included by LazyVim's rust extra)
        rust_analyzer = {},

        -- Go
        gopls = {},

        -- Python
        pylsp = {},

        -- Svelte
        svelte = {},

        -- ESLint
        eslint = {},
      },
    },
  },

  -- Additional LSP extras you might want:
  -- Uncomment to enable LazyVim's language extras
  -- { import = "lazyvim.plugins.extras.lang.rust" },
  -- { import = "lazyvim.plugins.extras.lang.go" },
  -- { import = "lazyvim.plugins.extras.lang.python" },
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
}
