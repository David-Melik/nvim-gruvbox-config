return {
  {
    -- The one and only true colorscheme: GRUVBOOOOOOX
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require "plugins.gruvbox"
    end,
  },
  -- Make Packer manage itself
  { "nvim-lua/plenary.nvim" },

  -- Easy way to interface with tree-sitter, an incremental parsing system.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter").config()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("plugins.treesitter-context").config()
    end,
  },

  ---------------------------------------------------------------------------
  -- Visuals
  ---------------------------------------------------------------------------

  -- Fancy Icons
  { "nvim-tree/nvim-web-devicons", lazy = false },
  { "lervag/vimtex", ft = { "tex" } },
  -- Indentation tracking
  { "lukas-reineke/indent-blankline.nvim" },

  -- A tab bar
--  {
--    "romgrk/barbar.nvim",
--    dependencies = { "nvim-tree/nvim-web-devicons" },
--    config = function()
--      require "plugins.barbar"
--    end,
--  },

  -- -- A statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "plugins.lualine"
    end,
  },

  -- Sway i3 config highlighting
  { "mboughaba/i3config.vim", ft = { "i3config" } },

  -- Cool startup Screen
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()

    local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
[[                                                                                                                                                          ]],
[[                                         @@@@@@@@@@                                                                                                       ]],
[[                                 @@@@@@@@@@@@@@@@@@@@@@@@@@                                                                                               ]],
[[                             @@@@@@%*++++++++++++++++++*@@@@@@                                                                                            ]],
[[                           @@@@#+++++++++++++++++++++++++++*@@@@@                                                                                         ]],
[[                        @@@@*+++++++++++++++++++**++++++++++++#@@@@                                                                                       ]],
[[                      @@@@++++++++++++++++++++++@@*@@@@+++++++++*@@@                                                                                      ]],
[[                     @@@*++++++++++++++++++*@@+++%@@++++++++++++++#@@                                                                                   ]],
[[                    @@@+++++++++++++++*@@@@@@@@@@@*++++++++++++++++*@@@                   ████ ██████           █████      ██                     ]],
[[                   @@@++++++++++++++++++++++++++++++++++++++++++++++#@@                  ███████████             █████                             ]],
[[                  @@@++++++++++++++++++++++++++++++++++++++++**++*+++@@@                 █████████ ███████████████████ ███   ███████████   ]],
[[                  @@#++++++%@+++#++++++++++++++++++++++++++++*@##@@++@@@                █████████  ███    █████████████ █████ ██████████████   ]],
[[                 @@@+++++++@%+*@%++++++++++++++++++++++++++++++@@*++++@@@              █████████ ██████████ █████████ █████ █████ ████ █████   ]],
[[                 @@%++++++++@@@+++++++++++++++++++++++++++++++++++++++@@@            ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
[[                 @@+++++++++++++++++++++++++++++++++++++++++++++++++++@@@           ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
[[                @@@+++++++++++++++++++++++++++++++++++++++++++++++++++@@@                                                                                 ]],
[[                @@@+++++++++++++++++++++++++++++++++++++++++++++++++++@@@                                                                                 ]],
[[                @@@+++++++++++++++++++++++++++++++++++++++++++++++++++@@@                                                                                 ]],
[[                 @@*+++++++++++++++++++++++++++++++++++++++++++++++++%@@                                                                                  ]],
[[                 @@@+++++++++++++++++++++++++++++++++++++++++++++++++@@@                                                                                  ]],
[[                  @@@+++++++++++++++++++++++++++++++++++++++++++++++@@@                                                                                   ]],
[[                    @@%++++++++++++++++++++++++++++++++++++++++++++@@@                                                                                    ]],
[[                     @@@@++++++++++++++++++++++++++++++++++++++++%@@@                                                                                     ]],
[[                       @@@@@*+++++++++++++++++++++++++++++++++*@@@@@                                                                                      ]],
[[                           @@@@@*+++++++++++++++++++++++++#@@@@@@                                                                                         ]],
[[                               @@@@@@#*+++++++++++++#@@@@@@@@@                                                                                            ]],
[[                              @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                                                                           ]],
[[                             @@@@@                         @@@@@                                                                                          ]],
[[                                                                                                                                                          ]],
[[                                                                                                                                                          ]],
[[                                                                                                                                                          ]],
	}

		_Gopts = {
			position = "center",
			hl = "Type",
			-- wrap = "overflow";
		}

		-- Set menu
		dashboard.section.buttons.val = {
			-- dashboard.button("SPC j", "󰈚   Restore Session", ":SessionRestore<cr>"),
			dashboard.button("e", "   New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "   Find file", "::Telescope find_files<CR>"),
			dashboard.button("g", "󰱼   Find word", ":Telescope live_grep<CR>"),
			dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("c", "   Config", ":cd /home/davidlinux/.config/nvim <CR> ::Neotree filesystem reveal left<CR>"),
			dashboard.button("l", "󰒲   Lazy", ":Lazy<CR>"),
			dashboard.button("u", "󰚰  Update plugins", "<cmd>lua require('lazy').sync()<CR>"),
			dashboard.button("q", "󰈆   Quit NVIM", ":qa<CR>"),
		}


		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)

		require("alpha").setup(dashboard.opts)

		-- vim.api.nvim_create_autocmd("User", {
		-- 	pattern = "LazyVimStarted",
		-- 	callback = function()
		-- 		local stats = require("lazy").stats()
		-- 		local count = (math.floor(stats.startuptime * 100) / 100)
		-- 		dashboard.section.footer.val = {
		-- 			"󱐌 " .. stats.count .. " plugins loaded in " .. count .. " ms",
		-- 			" ",
		-- 			"      Mohammed Babiker Babai",
		-- 		}
		-- 		pcall(vim.cmd.AlphaRedraw)
		-- 	end,
		-- })
	end,
    },

  -- CMAKE syntax support
  { "pboettch/vim-cmake-syntax" },
--which keys
{ -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
     -- require('which-key').register {
     --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
     --   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
     --   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
     --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
     --   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
     --   ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
     --   ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
     -- }
      -- visual mode
      require('which-key').register({
        ['<leader>h'] = { 'Get [H]unk' },
      }, { mode = 'v' })
    end,
  },
  ---------------------------------------------------------------------------
  -- Functionality
  ---------------------------------------------------------------------------

  -- Complete LSP package and more
  {
    "neoclide/coc.nvim",
    branch = "release",
    init = function()
      require("plugins.coc").setup()
    end,
    config = function()
      require("plugins.coc").config()
    end,
  },

  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope").setup()
    end,
    -- module = "telescope",
  },

  -- Documentation
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter",
    config = [[require('plugins.neogen')]],
    -- keys = { '<localleader>d', '<localleader>df', '<localleader>dc' },
  },

  -- move visual selection
  { "Jorengarenar/vim-MvVis" },

  -- support for .enditorconfig
  { "editorconfig/editorconfig-vim" },

  -----------------------------------------------------------------------------
  -- Stuff from the allmighty tpope
  -----------------------------------------------------------------------------
  -- Add,Delete and Change parentheses
  { "tpope/vim-surround" },
  -- Comment and uncomment lines/visual blocks
  { "tpope/vim-commentary" },
  -- Easily run Git commands from inside Vim
  { "tpope/vim-fugitive" },
  { "tpope/vim-dispatch" },
  { "tpope/vim-repeat" },

  -- A cool file explorer
  {
    "kyazdani42/nvim-tree.lua",
    keys = { "<F5>" },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icon
    },
    config = function()
      require("plugins.nvim-tree").setup()
    end,
  },
  { "neovim/nvim-lspconfig" },
  -- Show location in source tree in statuse {
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("nvim-navic").setup()
    end,
  },

  -- Some usefull snippets for a whole bunch of languages
  { "honza/vim-snippets" },

  -- Ansible Plugin
  {
    "pearofducks/ansible-vim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "neoclide/coc.nvim" },
    ft = { "yaml.ansible", "ansible" },
    config = function()
      require("plugins.ansible").setup()
    end,
  },

  -- An undo history visualizer
  {
    "mbbill/undotree",
    config = function()
      require("plugins.undotree").config()
    end,
  },

  -- Nice and fast vertical and horizontal movement
  {
    "ggandor/lightspeed.nvim",
    config = function()
      require("plugins.lightspeed").config()
    end,
  },

  -- Fancy colors
  { "Joakker/vim-antlr4", ft = { "anltr", "antlr4" }, lazy = true },

  -- support for typst
  { "kaarmu/typst.vim", ft = { "typst" }, lazy = true },
  { "folke/zen-mode.nvim", cmd = { "ZenMode" }, opts = { plugins = { tmux = { enabled = true } } } },

  {
    "glts/vim-radical",
    dependencies = "glts/vim-magnum",
  },

  {
    "glts/vim-magnum",
    lazy = true,
  },
}
