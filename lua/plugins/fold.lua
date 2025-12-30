return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    -- Fold options
    vim.o.foldcolumn = "1"
    vim.o.fillchars = "foldopen:,foldclose:"

    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Keymaps
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)

    --To toggle the fold under the cursor, try za or zA. To toggle everything other than your current cursor, you could close everything recursively with zR and open the surroundings (recursively) with zO.

    -- UFO setup
    require("ufo").setup {
      provider_selector = function(bufnr, filetype, buftype)
        local disabled_filetypes = { "neo-tree", "NvimTree", "TelescopePrompt" }
        if vim.tbl_contains(disabled_filetypes, filetype) then
          return nil -- return nil instead of {} to avoid error
        end
        return { "treesitter", "indent" }
      end,
    }
  end,
}
