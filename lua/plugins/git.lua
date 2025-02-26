return {
  {
    "tpope/vim-fugitive", -- To help find :command for git
  },
  {
    "lewis6991/gitsigns.nvim", -- Give line when you modify files and preview hunk
    config = function()
      require("gitsigns").setup()

      -- Gitsigns keymaps
      --	vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview Git Hunk" })
      --	vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
      --	vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo Stage Hunk" })
      --	vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
      --	vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { desc = "Reset Buffer" })
      --	vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Blame Line" })
      --	vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle Line Blame" })

      -- Fugitive keymaps
      vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git Commit" })
      vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", { desc = "Git Add All" })
      vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git Log" })
      vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git Diff" })
      vim.keymap.set("n", "<leader>gP", ":Git push<CR>", { desc = "Git Push" })
      vim.keymap.set("n", "<leader>gf", ":Git fetch<CR>", { desc = "Git Fetch" }) -- Added Git Fetch
      vim.keymap.set("n", "<leader>gb", ":Git branch<CR>", { desc = "Git Branch" })
      vim.keymap.set("n", "<leader>gC", ":Git checkout<CR>", { desc = "Git Checkout" })
    end,
  },
}
