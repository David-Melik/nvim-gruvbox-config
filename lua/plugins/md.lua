return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      render_modes = true,
      heading = {
        border = true,
        border_virtual = true,
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }

      vim.g.mkdp_markdown_css = vim.fn.expand "~/.config/joplin-desktop/gruvbox-markdown.css"
      vim.g.mkdp_theme = "dark"
    end,
    ft = { "markdown" },
    config = function()
      -- Set keybinding for Markdown Preview Toggle
      vim.keymap.set(
        "n",
        "<Leader>mp",
        "<cmd>MarkdownPreviewToggle<CR>",
        { desc = "Toggle Markdown Preview", silent = true }
      )
    end,
  },
}
