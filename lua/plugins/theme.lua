return {
  {
    -- The one and only true colorscheme: GRUVBOOOOOOX
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      --Config for gruvbox theme
      local colors = require("gruvbox").palette
      require("gruvbox").setup {
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
          emphasis = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        overrides = {
          SignColumn = { bg = colors.dark0_hard },
          DiffAdd = { bg = colors.dark0_hard, fg = colors.bright_green, reverse = false },
          DiffChange = { bg = colors.dark0_hard, fg = colors.bright_yellow, reverse = false },
          DiffRemoved = { bg = colors.dark0_hard, fg = colors.bright_red, reverse = true },
          Pmenu = { bg = colors.dark0_hard, fg = "white" },
          Comment = { italic = true }, -- popup menu colors
          Search = { bg = colors.neutral_purple, fg = colors.light1 }, -- search string highlight color
          NonText = { fg = colors.dark1 }, -- mask ~ on empty lines
          CursorLineNr = { bold = true }, -- make relativenumber bol
          SpellBad = { bold = true, undercurl = true }, -- misspelled words
        },
      }
      vim.cmd "colorscheme gruvbox"
    end,
  },
  -- Plugins that allow us to have a cool bar a the bottom
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          theme = "gruvbox-material",
        },
      }
    end,
  },
}
