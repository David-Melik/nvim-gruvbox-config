return {
	"mikavilpas/yazi.nvim",
	version = "*", -- use the latest stable version
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		-- 👇 in this section, choose your own keymappings!
		{
			"F",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		--{
		--	-- Open in the current working directory
		--	"<leader>cw",
		--	"<cmd>Yazi cwd<cr>",
		--	desc = "Open the file manager in nvim's working directory",
		--},
		--{
		--	"<c-up>",
		--	"<cmd>Yazi toggle<cr>",
		--	desc = "Resume the last yazi session",
		--},
	},
	---@type YaziConfig | {}
	opts = {
		-- if you want to open yazi instead of netrw, see below for more info
		open_for_directories = false,
		keymaps = {
			show_help = "<f1>",
		},
	},
	-- 👇 if you use `open_for_directories=true`, this is recommended
	init = function()
		-- mark netrw as loaded so it's not loaded at all.
		--
		-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
		vim.g.loaded_netrwPlugin = 1
	end,

	--  These are the default keybindings that are available when yazi is open:
	--
	--    <f1>: show the help menu
	--    <c-v>: open the selected file(s) in vertical splits
	--    <c-x>: open the selected file(s) in horizontal splits
	--    <c-t>: open the selected file(s) in new tabs
	--    <c-q>: send the selected file(s) to the quickfix list
	--    There are also integrations to other plugins, which you need to install separately:
	--        <c-s>: search in the current yazi directory using telescope's live_grep, if available. Optionally you can use fzf-lua.nvim, snacks.picker or provide your own implementation - see the instructions in the configuration section for more info.
	--            if multiple files/directories are selected in yazi, the search and replace will only be done in the selected files/directories
	--        <c-g>: search and replace in the current yazi directory using grug-far, if available
	--            if multiple files/directories are selected in yazi, the operation is limited to those only
	--        <c-y>: copy the relative path of the selected file(s) to the clipboard. Requires GNU realpath or grealpath on OSX
	--            also available for the snacks.nvim picker, see documentation/copy-relative-path-to-files.md for more information
	--        <tab>: make yazi jump to the open buffers in Neovim. See #232 for more information
	--
}
