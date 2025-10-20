-- Harpoon 2 - Quick file navigation
-- Preserving your exact keybindings
--
-- Harpoon 2 changes from v1:
-- - New API: harpoon:list() instead of mark/ui modules
-- - Better performance and stability
-- - Your keybindings work identically to before
-- - Visual behavior is the same

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- Your keybindings from old config
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon add file" })

    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon quick menu" })

    -- Navigate to files 1-4
    vim.keymap.set("n", "<C-h>", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon file 1" })

    vim.keymap.set("n", "<C-t>", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon file 2" })

    vim.keymap.set("n", "<C-n>", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon file 3" })

    vim.keymap.set("n", "<C-s>", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon file 4" })

    -- Optional: Navigate between files
    vim.keymap.set("n", "<C-S-P>", function()
      harpoon:list():prev()
    end, { desc = "Harpoon previous" })

    vim.keymap.set("n", "<C-S-N>", function()
      harpoon:list():next()
    end, { desc = "Harpoon next" })
  end,
}
