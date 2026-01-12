-- Plugin that have in him multiple refactors plugin (like prettier and robocop ...) to only just one it will allow to refactor all type of luangage code
return {
  { -- Autoformat

    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        css = { "prettier" },
        html = { "prettier" },
        markdown = { "markdownlint" },
        python = { "black" },
        --npm install -g prettier @shopify/prettier-plugin-liquid
        --.prettierrc.json
        --          {
        --  "plugins": ["@shopify/prettier-plugin-liquid"]
        --}
        liquid = { "prettierd" },
        javascript = { "clang-format" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        csharp = { "clang-format" },
        razor = { "prettierd" },
        nix = { "nixfmt" },
      },
    },
  },
}
