--[[
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html
--]]

-- [[ Options ]]
-- See `:help vim.opt`
require 'core.opts'

-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`
require 'core.keymaps'

-- [[ Autocmds ]]
require 'core.autocmd'

-- [[ Lazy ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require('lazy').setup({
  { import = 'custom.plugins' },
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
