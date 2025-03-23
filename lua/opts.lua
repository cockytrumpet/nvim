-- [[ Setting options ]]
vim.g.lua_snippets_path = os.getenv 'HOME' .. '/.config/nvim/lua/snippets'
-- vim.g.vscode_snippets_path = os.getenv 'HOME' .. '~/.config/nvim/lua/snippets'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.backup = false -- creates a backup file
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = false
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.fileencoding = 'utf-8' -- the encoding written to a file
vim.opt.fillchars = { eob = ' ', fold = ' ', foldopen = '', foldsep = ' ', foldclose = '', lastline = ' ' } -- make EndOfBuffer invisible
vim.opt.foldcolumn = '1'
vim.opt.foldenable = true
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'manual'
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.inccommand = 'split'
vim.opt.inccommand = 'split'
vim.opt.iskeyword:append '-'
vim.opt.laststatus = 3
vim.g.lazyvim_blink_main = true
vim.opt.lazyredraw = false -- Won't be redrawn while executing macros register and other commands.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.numberwidth = 4 -- set number column width to 4 {default 4}
vim.opt.pumblend = 5 -- transparency of pop-up menu
vim.opt.pumheight = 8 -- pop up menu height
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.scrolloff = 8
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.shortmess:append 'IAc' -- Disable asking when editing file with swapfile.
vim.opt.showmode = false
vim.opt.sidescrolloff = 8 -- minimal number of screen columns
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false -- creates a swapfile
vim.opt.tabstop = 4
vim.opt.termguicolors = true -- Enables 24-bit RGB color in the TUI
vim.opt.textwidth = 80
vim.opt.timeoutlen = 500
vim.opt.undodir = os.getenv 'HOME' .. '/.undodir' -- set an undo directory
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.whichwrap:append '<,>,[,],h,l'
vim.opt.winhighlight = 'WinSeparator:FloatBorder'
vim.opt.wrap = false -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.smoothscroll = true

if vim.loop.os_uname().sysname == 'Darwin' then
  vim.cmd 'set rtp+=/opt/homebrew/opt/fzf'
  vim.g.python3_host_prog = '/Users/adam/.pyenv/versions/neovim/bin/python'
else
  vim.cmd 'set rtp+=/usr/bin/fzf'
end

if vim.fn.executable 'rg' then
  vim.opt.grepprg = 'rg --vimgrep'
  vim.opt.grepformat = '%f:%l:%c:%m'
end
