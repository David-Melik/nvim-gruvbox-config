-------------------------------------------------------------------------------
-- Autocommands
-----------------------------------------------------------------------------
local aug = vim.api.nvim_create_augroup --To create a autocommands group
aug("Misc", { clear = true }) --Avoid duplicate automcommand conflicte

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "Misc",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ on_visual = true })
	end,
})

-- highlight when staying on word
vim.api.nvim_create_autocmd("CursorHold", {
	group = "Misc",
	pattern = "help",
	callback = function()
		vim.cmd("call CocAction('highlight')")
	end,
})

-- disable stupid auto commenting on new lines
vim.api.nvim_create_autocmd("BufEnter", {
	group = "Misc",
	pattern = "*",
	callback = function()
		vim.cmd([[set fo-=c fo-=r fo-=o]])
	end,
})

-- return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = "Misc",
	pattern = "*",
	callback = function()
		vim.cmd([[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])
	end,
})

--Ensure filetyp detection for .cshtml files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.cshtml",
	callback = function()
		vim.bo.filetype = "razor"
	end,
})

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

-- Auto-adjust numberwidth based on line count
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "VimResized" }, {
	callback = function()
		local line_count = vim.fn.line("$")
		local width = #tostring(line_count) + 2 -- +1 for padding
		vim.opt.numberwidth = width
	end,
})
