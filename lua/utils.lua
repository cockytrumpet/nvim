local M = {}

local telescope_custom_colors = function()
  -- stylua: ignore
  local builtins = { "zellner", "torte", "slate", "shine", "ron", "quiet", "peachpuff",
  "pablo", "murphy", "lunaperche", "koehler", "industry", "evening", "elflord",
  "desert", "delek", "default", "darkblue", "blue", "vim", "zaibatsu", "wildcharm",
  "catppuccin-latte", "tokyonight-day", "minicyan", "minischeme", "morning", "randomhue",
  "retrobox", "sorbet", "bamboo-light", "dayfox", "dawnfox", "rose-pine", "rose-pine-dawn",
  "habamax", "onelight"  }

  local target = vim.fn.getcompletion

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.getcompletion = function()
    ---@diagnostic disable-next-line: redundant-parameter
    return vim.tbl_filter(function(color)
      return not vim.tbl_contains(builtins, color)
    end, target('', 'color'))
  end

  vim.cmd 'Telescope colorscheme enable_preview=true'
  vim.fn.getcompletion = target
end

---@param force? boolean defaults to false.
---@param ignore_list? table of buffer types to ignore.
local close_current_buffer = function(force, ignore_list)
  -- Command used to kill the buffer.
  local kill_command = 'bd'

  -- Default list of items to ignore.
  if not ignore_list then
    ignore_list = {
      'nvimtree',
      'nofile',
      'startify',
      'terminal',
    }
  end

  -- Required data.
  local bo = vim.bo
  local api = vim.api
  local fmt = string.format
  local fnamemodify = vim.fn.fnamemodify
  local bufnr = api.nvim_get_current_buf()
  local bufname = api.nvim_buf_get_name(bufnr)
  -- local buf_type = api.nvim_buf_get_option(0, 'buftype')
  local buf_type = api.nvim_get_option_value('buftype', { buf = bufnr })

  -- Check if the current buffer should be ignored.
  for _, type in ipairs(ignore_list) do
    if type == buf_type then
      -- Do not delete.
      return
    end
  end

  -- Warn user if a modified buffer is about to be deleted.
  if not force then
    local warning
    if bo[bufnr].modified then
      warning = fmt([[(%s) has unsaved changes.]], fnamemodify(bufname, ':t'))
    elseif buf_type == 'terminal' then
      warning = fmt([[Terminal %s will be killed.]], bufname)
    end
    if warning then
      vim.ui.input({
        prompt = string.format([[%s. Close it? y/n: ]], warning),
      }, function(choice)
        if choice:match 'ye?s?' then
          force = true
        end
      end)
      if not force then
        return
      end
    end
  end

  -- Get list of windows IDs with the buffer to close.
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  -- No windows to close.
  if #windows == 0 then
    return
  end

  -- Create force command.
  if force then
    kill_command = kill_command .. '!'
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and (#buffers - 1) or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(fmt('%s %d', kill_command, bufnr))
  end

  -- If there was only one buffer (which had to be the current one), vim will
  -- create a new buffer (and keep a window open) on :bd.
end

local file_exists = function(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local substitute = function(cmd)
  cmd = cmd:gsub('%%', vim.fn.expand '%')
  cmd = cmd:gsub('$fileBase', vim.fn.expand '%:r')
  cmd = cmd:gsub('$filePath', vim.fn.expand '%:p')
  cmd = cmd:gsub('$file', vim.fn.expand '%')
  cmd = cmd:gsub('$dir', vim.fn.expand '%:p:h')
  ---@diagnostic disable-next-line: param-type-mismatch
  cmd = cmd:gsub('$moduleName', vim.fn.substitute(vim.fn.substitute(vim.fn.fnamemodify(vim.fn.expand '%:r', ':~:.'), '/', '.', 'g'), '\\', '.', 'g'))
  cmd = cmd:gsub('#', vim.fn.expand '#')
  cmd = cmd:gsub('$altFile', vim.fn.expand '#')

  return cmd
end

local run_code = function()
  local fileExtension = vim.fn.expand '%:e'
  local selectedCmd = ''
  local options = 'bot 10 new | term '
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
      -- default = "rustc % && $fileBase",
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
    elseif #choices == 1 then
      selectedCmd = supportedFiletypes[fileExtension][choices[1]]
      vim.cmd(options .. substitute(selectedCmd))
    else
      vim.ui.select(choices, { prompt = 'Choose: ' }, function(choice)
        selectedCmd = supportedFiletypes[fileExtension][choice]
        if selectedCmd then
          vim.cmd(options .. substitute(selectedCmd))
        end
      end)
    end
  else
    vim.notify("The filetype isn't included in the list", vim.log.levels.WARN, { title = 'Code Runner' })
  end
end

local P = function(v)
  print(vim.inspect(v))
  return v
end

local RELOAD = function(module)
  package.loaded[module] = nil
  return require(module)
end

M.close_current_buffer = close_current_buffer
M.file_exists = file_exists
M.run_code = run_code
M.substitute = substitute
M.telescope_custom_colors = telescope_custom_colors
M.P = P
M.RELOAD = RELOAD

return M
