return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  event = "BufReadPost", -- Load the plugin after a buffer is read
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      -- Use treesitter for most filetypes, fallback to indent
      -- Add special providers for specific filetypes if needed
      return { "treesitter", "indent" }
    end,
    -- This function customizes the text shown when a fold is closed
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" 󰁂 %d lines"):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0

      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end

      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end,
    open_fold_hl_timeout = 150,
    close_fold_kinds_for_ft = {
      default = { "imports", "comment" },
      json = { "array" },
      c = { "comment" },
    },
    preview = {
      win_config = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "Normal:Folded",
        winblend = 0,
      },
      mappings = {
        scrollU = "<C-u>",
        scrollD = "<C-d>",
        jumpTop = "[",
        jumpBot = "]",
      },
    },
  },
  init = function()
    -- Setting fold options
    vim.o.foldcolumn = "1" -- Show fold column
    vim.o.foldlevel = 99 -- Start with all folds open
    vim.o.foldlevelstart = 99 -- Start with all folds open
    vim.o.foldenable = true -- Enable folding

    -- Enhanced keymaps for folding
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except kinds" })
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with" })
    vim.keymap.set("n", "zK", function()
      require("ufo").peekFoldedLinesUnderCursor()
    end, { desc = "Peek fold" })

    -- Extra convenience keymaps
    vim.keymap.set("n", "<leader>zf", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        -- If ufo peek doesn't work, try LSP hover as fallback
        vim.lsp.buf.hover()
      end
    end, { desc = "Preview fold/hover" })

    -- Jump between the beginning and end of a fold
    vim.keymap.set("n", "zj", function()
      require("ufo").goNextClosedFold()
    end, { desc = "Go to next fold" })

    vim.keymap.set("n", "zk", function()
      require("ufo").goPreviousClosedFold()
    end, { desc = "Go to previous fold" })

    -- Create custom highlight for folds
    vim.api.nvim_set_hl(0, "Folded", { fg = "#89DDFF", bg = "#1E2132", italic = true })
    vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#89DDFF", bg = "NONE" })
  end,
}
