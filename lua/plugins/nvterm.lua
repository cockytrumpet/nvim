local function substitute(cmd)
  cmd = cmd:gsub('%%', vim.fn.expand '%')
  cmd = cmd:gsub('$fileBase', vim.fn.expand '%:r')
  cmd = cmd:gsub('$filePath', vim.fn.expand '%:p')
  cmd = cmd:gsub('$file', vim.fn.expand '%')
  cmd = cmd:gsub('$dir', vim.fn.expand '%:p:h')
  cmd = cmd:gsub('$moduleName', vim.fn.substitute(vim.fn.substitute(vim.fn.fnamemodify(vim.fn.expand '%:r', ':~:.'), '/', '.', 'g'), '\\', '.', 'g'))
  cmd = cmd:gsub('#', vim.fn.expand '#')
  cmd = cmd:gsub('$altFile', vim.fn.expand '#')

  return cmd
end

local function get_command()
  local fileExtension = vim.fn.expand '%:e'
  local selectedCmd = ''
  local supportedFiletypes = {
    html = {
      default = '%',
    },
    c = {
      default = 'gcc % -o $fileBase && $fileBase',
      debug = 'gcc -g % -o $fileBase && $fileBase',
      make = 'make clean && make && ./$fileBase',
    },
    cs = {
      default = 'dotnet run',
    },
    cpp = {
      default = 'g++ % -o  $fileBase && $fileBase',
      debug = 'g++ -g % -o  $fileBase',
      make = 'make clean && make && ./$fileBase',
    },
    py = {
      default = 'python %',
    },
    go = {
      default = 'go run %',
    },
    java = {
      default = 'java %',
    },
    js = {
      default = 'node %',
      debug = 'node --inspect %',
    },
    ts = {
      default = 'tsc % && node $fileBase',
    },
    rs = {
      default = 'cargo run',
    },
    php = {
      default = 'php %',
    },
    r = {
      default = 'Rscript %',
    },
    jl = {
      default = 'julia %',
    },
    rb = {
      default = 'ruby %',
    },
    pl = {
      default = 'perl %',
    },
    scala = {
      default = 'scala %',
    },
    ml = {
      default = 'ocaml %',
    },
  }

  if supportedFiletypes[fileExtension] then
    local choices = {}
    for choice, _ in pairs(supportedFiletypes[fileExtension]) do
      table.insert(choices, choice)
    end

    if #choices == 0 then
      vim.notify("It doesn't contain any command", vim.log.levels.WARN, { title = 'Code Runner' })
      return nil
    elseif #choices == 1 then
      selectedCmd = supportedFiletypes[fileExtension][choices[1]]
      return substitute(selectedCmd)
    else
      vim.ui.select(choices, { prompt = 'Choose: ' }, function(choice)
        selectedCmd = supportedFiletypes[fileExtension][choice]
        if selectedCmd then
          return substitute(selectedCmd)
        end
      end)
    end
  else
    vim.notify("The filetype isn't included in the list", vim.log.levels.WARN, { title = 'Code Runner' })
    return nil
  end
end

local M = {
  'NvChad/nvterm',
  init = function()
    local terminal = require 'nvterm.terminal'
    local ft_cmds = {
      python = 'python3 ' .. vim.fn.expand '%',
    }
    vim.keymap.set({ 'n', 't' }, '<leader>th', function()
      terminal.toggle 'horizontal'
    end, { desc = 'NVTerm: horizontal ' })
    vim.keymap.set({ 'n', 't' }, '<leader>tv', function()
      terminal.toggle 'vertical'
    end, { desc = 'NVTerm: vertical ' })
    vim.keymap.set({ 'n', 't' }, '<leader>ti', function()
      terminal.toggle 'float'
    end, { desc = 'NVTerm: float ' })
    vim.keymap.set('n', '<leader>tr', function()
      -- terminal.send(ft_cmds[vim.bo.filetype])
      local cmd = get_command()
      if cmd then
        terminal.send('clear &&' .. cmd)
      end
    end, { desc = 'NVTerm: run file' })
  end,
  config = function()
    require('nvterm').setup {
      terminals = {
        shell = vim.o.shell,
        list = {},
        type_opts = {
          float = {
            relative = 'editor',
            row = 0.3,
            col = 0.25,
            width = 0.5,
            height = 0.4,
            border = 'single',
          },
          horizontal = { location = 'rightbelow', split_ratio = 0.3 },
          vertical = { location = 'rightbelow', split_ratio = 0.5 },
        },
      },
      behavior = {
        autoclose_on_quit = {
          enabled = false,
          confirm = true,
        },
        close_on_exit = true,
        auto_insert = true,
      },
    }
  end,
}

return M
