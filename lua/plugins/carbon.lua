local M = {
  'ellisonleao/carbon-now.nvim',
  lazy = true,
  cmd = 'CarbonNow',
  opts = {
    base_url = 'https://carbon.now.sh/',
    open_cmd = 'open',
    options = {
      bg = '#282133',
      drop_shadow_blur = '68px',
      drop_shadow = true,
      drop_shadow_offset_y = '0px',
      font_family = 'Fira Code',
      font_size = '18px',
      line_height = '133%',
      line_numbers = true,
      theme = 'one-dark',
      titlebar = vim.fn.expand '%:t',
      watermark = false,
      width = '680',
      window_theme = 'sharp',
    },
  },
}

return M
