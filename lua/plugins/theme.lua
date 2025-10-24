return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Make sure the colorscheme loads before other plugins
    config = function()
      -- Optional: Configure Gruvbox
      require("gruvbox").setup {
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {
          SignColumn = { bg = "#282828" },
          FoldColumn = { bg = "#282828" },
        },
        dim_inactive = false,
        transparent_mode = false,
      }

      vim.cmd "colorscheme gruvbox"

      -- 🟢 Force all sign/fold columns to match background color
      local bg = "#282828" -- your Gruvbox Normal background

      -- Remove or match backgrounds for all relevant columns
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = bg, fg = "#fabd2f" })
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = bg })
      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = bg })
      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = bg })

      -- For markdown work with gruvbox
      vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#82AAFF", bold = true })
      vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#1A2B4A" })

      -- Heading 2 - orange/gold background
      vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#FFCB6B", bold = true })
      vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#3D2E14" })

      -- Heading 3 - green background
      vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#C3E88D", bold = true })
      vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#2D3C22" })

      -- Heading 4 - teal background
      vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#89DDFF", bold = true })
      vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#1E3837" })

      -- Heading 5 - purple background
      vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#C792EA", bold = true })
      vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#2C2240" })

      -- Heading 6 - lighter purple background
      vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#C792EA", bold = true })
      vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#2C2240" })
    end,
  },
  {
    -- Recall plugin markdown to solve a color heading bug
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      heading = {
        enabled = true,
        -- Rest of your heading configuration...
      },
    },
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
