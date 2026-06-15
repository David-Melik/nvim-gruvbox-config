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

-- Auto-adjust numberwidth based on line count
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "VimResized" }, {
	callback = function()
		local line_count = vim.fn.line("$")
		local width = #tostring(line_count) + 2 -- +1 for padding
		vim.opt.numberwidth = width
	end,
})

-- Toogle diagnostic warning and error display
vim.g["diagnostics_active"] = true
function Toggle_diagnostics()
	if vim.g.diagnostics_active then
		vim.g.diagnostics_active = false
		vim.diagnostic.enable(false)
	else
		vim.g.diagnostics_active = true
		vim.diagnostic.enable(true)
	end
end

vim.keymap.set("n", "<C-n>", Toggle_diagnostics, { noremap = true, silent = true, desc = "Toggle vim diagnostics" })
