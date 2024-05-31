local get_path_string = function()
  local f = io.open('~/.pyenv/version', 'r')
  if f ~= nil then
    local version = f:read '*a'
    f:close()
    return string.format('~/.pyenv/versions/%s/lib/%s/site-packages/', version, string.sub(version, 1, 4))
  end
  return ''
end

local M = {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      svelte = { 'eslint_d' },
      python = { 'pylint' },
    }

    lint.linters.cspell = require('lint.util').wrap(lint.linters.cspell, function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
      return diagnostic
    end)

    lint.linters.pylint.args = {
      '-f',
      'json',
      '--init-hook',
      get_path_string(),
      '--recursive',
      'y',
      '--disable=invalid-namae,missing-docstring',
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint()
    end, { desc = 'lint current file' })
  end,
}

return M
