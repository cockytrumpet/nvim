local highlights = {
  NeogitDiffDeleteHighlight = {
    fg = 'red',
    bg = '#3d1212',
  },
  NeogitDiffDelete = {
    fg = '#B13B5C',
    bg = '#3d1212',
  },
  NeogitDiffAddHighlight = {
    fg = 'green',
    bg = '#1e4620',
  },
  NeogitDiffAdd = {
    fg = '#3FB950',
    bg = '#1e4620',
  },
}

for group, colors in pairs(highlights) do
  vim.cmd('highlight ' .. group .. ' guifg=' .. colors.fg .. ' guibg=' .. colors.bg)
end
