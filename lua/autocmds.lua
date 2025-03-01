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
    vim.highlight.on_yank { on_visual = true }
  end,
})

-- highlight when staying on word
vim.api.nvim_create_autocmd("CursorHold", {
  group = "Misc",
  pattern = "help",
  callback = function()
    vim.cmd "call CocAction('highlight')"
  end,
})

-- disable stupid auto commenting on new lines
vim.api.nvim_create_autocmd("BufEnter", {
  group = "Misc",
  pattern = "*",
  callback = function()
    vim.cmd [[set fo-=c fo-=r fo-=o]]
  end,
})

-- return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "Misc",
  pattern = "*",
  callback = function()
    vim.cmd [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
  end,
})

--Ensure filetyp detection for .cshtml files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.cshtml",
  callback = function()
    vim.bo.filetype = "razor"
  end,
})
