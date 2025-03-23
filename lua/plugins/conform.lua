local M = { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    notify_on_error = false,
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      svelte = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      cpp = { 'clang-format' },
      c = { 'clang-format' },
      ocaml = { 'ocamlformat' },
      go = { 'gofmt' },
      rust = { 'rustfmt' },
      sql = { 'sql_formatter' },
      ['*'] = { 'injected' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    config = function(_, opts)
      require('conform').setup(opts)
      -- require('conform.formatters.yamlfix').env = {
      --   YAMLFIX_WHITELINES = 1,
      -- }
      require('conform').formatters.sql_formatter = {
        prepend_args = { '-c', vim.fn.expand '~/.config/sql_formatter.json' },
      }
      -- require('conform').formatters.markdownlint = {
      --   prepend_args = { '-c', vim.fn.expand '~/.config/markdownlint.json' },
      -- }
    end,
  },
}

return M
