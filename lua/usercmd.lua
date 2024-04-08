vim.api.nvim_create_user_command('Update', function()
  local commands = {
    'MasonUpdate',
    'MasonToolsUpdate',
  }
  for _, command in pairs(commands) do
    vim.cmd(command)
  end
  require('lazy').sync()
  -- require('nvterm.terminal').send('bubc;pipupall;bob update --all', 'vertical')
  require('nvterm.terminal').send('brew update;brew upgrade --fetch-HEAD;pipupall', 'vertical')
end, {})

vim.api.nvim_create_user_command('GetTable', function(ctx)
  local cmd = 'lua=' .. ctx.args
  local lines = vim.split(vim.api.nvim_exec(cmd, true), '\n', { plain = true })
  vim.cmd 'vnew'
  vim.api.nvim_set_option_value('filetype', 'lua', { buf = 0 })
  vim.api.nvim_set_option_value('buflisted', false, { buf = 0 })
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
end, { nargs = '+', complete = 'command' })

------------------ pytest TestOnSave ------------------

local attach_to_buffer = function(bufnr, command)
  local group = vim.api.nvim_create_augroup('TestOnSave', { clear = true })
  local ns = vim.api.nvim_create_namespace 'TestOnSave'

  local state = {
    bufnr = bufnr,
    tests = {},
    summary = {},
  }

  local add_test = function(entry)
    local message = ''
    if entry.call.longrepr then
      message = entry.call.longrepr
    end

    state.tests[entry.nodeid] = {
      outcome = entry.outcome,
      nodeid = entry.nodeid,
      test = entry.keywords[1],
      file = entry.keywords[2],
      line_number = entry.lineno,
      message = message,
    }
  end

  vim.api.nvim_create_user_command('TestLineDiag', function()
    local line = vim.fn.line '.' - 1
    for _, test in pairs(state.tests) do
      if test.line_number == line then
        vim.notify(test.message, vim.log.levels.ERROR, {
          title = test.nodeid,
          on_open = function(win)
            local buf = vim.api.nvim_win_get_buf(win)
            vim.api.nvim_set_option_value('filetype', 'python', { buf = buf })
          end,
        })
      end
    end
  end, {})

  vim.api.nvim_create_autocmd('BufWritePost', {
    group = group,
    pattern = '*.py',
    callback = function()
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stderr = function(_, data)
          if not data then
            return
          end

          local decoded = vim.fn.json_decode(data)
          if not decoded then
            return
          else
            state.summary = decoded.summary
          end

          local tests = decoded.tests
          if not tests then
            return
          end

          vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

          for _, line in pairs(tests) do
            add_test(line)
            if state.tests[line.nodeid].outcome == 'passed' then
              local text = { '✓', 'DiagnosticOK' }
              vim.api.nvim_buf_set_extmark(bufnr, ns, state.tests[line.nodeid].line_number, 0, {
                virt_text = { text },
              })
            end
          end
        end,
        on_exit = function()
          local failed = {}
          for _, test in pairs(state.tests) do
            if test.outcome == 'failed' then
              table.insert(failed, {
                bufnr = bufnr,
                lnum = test.line_number,
                col = 0,
                severity = vim.lsp.protocol.DiagnosticSeverity.Error,
                source = 'pytest',
                message = 'Test failed',
                user_data = {},
              })
            end
          end
          vim.diagnostic.set(ns, bufnr, failed, {})
          if state.summary.total == state.summary.passed then
            vim.notify('All tests passed', vim.log.levels.INFO, {
              title = state.summary.total .. ' tests completed',
            })
          else
            vim.notify('Passed: ' .. state.summary.passed .. '\nFailed: ' .. state.summary.failed, vim.log.levels.WARN, {
              title = state.summary.total .. ' tests completed',
            })
          end
        end,
      })
    end,
  })
end

vim.api.nvim_create_user_command('TestOnSave', function()
  local command = {
    'pytest',
    '--json-report',
    '--json-report-file=/dev/stderr',
    '-q',
    '--no-header',
    '--no-summary',
  }
  attach_to_buffer(vim.api.nvim_get_current_buf(), command)
end, {})
