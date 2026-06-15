--Ensure filetype detection for .cshtml files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.cshtml",
	callback = function()
		vim.bo.filetype = "razor"
	end,
})

-- =========
-- Markdown
-- =========
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.md",
	callback = function()
		vim.keymap.set("n", "<Leader>mf", "i<details><summary></summary>\n\n\n</details><Esc>\n", {
			buffer = true,
			desc = "Insert Markdown Foldable Content (Details Tag)",
		})
		vim.keymap.set("n", "<Leader>mb", "i</br><Esc>", {
			buffer = true,
			desc = "Jump to line",
		})
		vim.keymap.set("n", "<Leader>mu", "i<ins>   </ins><Esc>", {
			buffer = true,
			desc = "Underline text",
		})
		vim.keymap.set("n", "<Leader>mh", "i<mark>   </mark><Esc>", {
			buffer = true,
			desc = "Highlight text",
		})
	end,
})

--for the cursor is in the center for markdown
vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
	pattern = "*.md",
	callback = function()
		vim.opt.scrolloff = 999 -- Keeps cursor in center
		print("Markdown cursor in the center autocmd triggered!") -- Debug message
	end,
})
