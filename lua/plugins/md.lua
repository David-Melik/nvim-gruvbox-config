-- Function to check if a note is a Joplin note based on its name
local function joplin_note_check(note_name)
  -- Check if the note name is exactly 32 characters long (Joplin UUID)
  return #note_name == 32
end

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
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
      -- Set filetypes and appearance options
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_markdown_css = vim.fn.expand "~/.config/nvim/lua/assets/gruvbox-preview.css"
      vim.g.mkdp_theme = "dark"

      -- Determine if current file is a Joplin note
      local current_file = vim.fn.expand "%:t" -- Get filename, e.g., "abc123.md"
      local note_name = current_file:match "^(%w+)%..*$" -- Extract base name without extension

      if joplin_note_check(note_name or "") then
        print "It is a Joplin note"
        vim.g.mkdp_images_path = vim.fn.expand "$HOME/.config/joplin-desktop/"
      end
    end,
    ft = { "markdown" },
    config = function()
      -- Set keybinding to toggle markdown preview
      vim.keymap.set(
        "n",
        "<Leader>mp",
        "<cmd>MarkdownPreviewToggle<CR>",
        { desc = "Toggle Markdown Preview", silent = true }
      )
    end,
  },
}
