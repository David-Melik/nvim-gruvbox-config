return {
	{
		"tpope/vim-fugitive", -- To help find :command for git
	},
	{
		"lewis6991/gitsigns.nvim", --Give line when you modify the files and preview hunk and quick preview toggle_current_line_blame
		config = function()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
			vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", {})
			vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", {})

			--vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
		end,
	},
}
