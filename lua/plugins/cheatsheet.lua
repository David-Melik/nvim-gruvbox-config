return {
  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require("which-key").setup()

      -- Document existing key chains
      local wk = require "which-key"
      wk.add {

        { "<leader>c", name = "[C]ode" },
        { "<leader>d", name = "[D]ocument" },
        { "<leader>r", name = "[R]ename" },
        { "<leader>s", name = "[S]earch" },
        { "<leader>w", name = "[W]orkspace" },
        { "<leader>t", name = "[T]oggle" },
        { "<leader>g", name = "[G]it" },
      }
      --visual mode
      wk.add({
        { "<leader>h", name = "[H]unk" },
      }, { mode = "v" })
    end,
  },
}
