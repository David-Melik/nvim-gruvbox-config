return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- Make sure the colorscheme loads before other plugins

		config = function()
			-- Optional: Configure Gruvbox
			require("gruvbox").setup({
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
					Changed = { fg = "#fe8019" }, -- yellow/orange

					SignColumn = { bg = "#282828" },
					FoldColumn = { bg = "#282828" },
					DiagnosticSignWarn = { bg = "#282828", fg = "#fabd2f" },
					DiagnosticSignError = { bg = "#282828" },
					DiagnosticSignInfo = { bg = "#282828" },
					DiagnosticSignHint = { bg = "#282828" },

					-- RenderMarkdown headings
					RenderMarkdownH1 = { fg = "#82AAFF", bold = true },
					RenderMarkdownH1Bg = { bg = "#1A2B4A" },

					-- Heading 2 - orange/gold background
					RenderMarkdownH2 = { fg = "#FFCB6B", bold = true },
					RenderMarkdownH2Bg = { bg = "#3D2E14" },

					-- Heading 3 - green background
					RenderMarkdownH3 = { fg = "#C3E88D", bold = true },
					RenderMarkdownH3Bg = { bg = "#2D3C22" },

					-- Heading 4 - teal background
					RenderMarkdownH4 = { fg = "#89DDFF", bold = true },
					RenderMarkdownH4Bg = { bg = "#1E3837" },

					-- Heading 5 - purple background
					RenderMarkdownH5 = { fg = "#C792EA", bold = true },
					RenderMarkdownH5Bg = { bg = "#2C2240" },

					-- Heading 6 - lighter purple background
					RenderMarkdownH6 = { fg = "#C792EA", bold = true },
					RenderMarkdownH6Bg = { bg = "#2C2240" },
				},
				dim_inactive = false,
				transparent_mode = false,
			})

			vim.cmd("colorscheme gruvbox")
		end,
	},

	-- Plugins that allow us to have a cool bar a the bottom
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox-material",
				},
			})
		end,
	},
}
