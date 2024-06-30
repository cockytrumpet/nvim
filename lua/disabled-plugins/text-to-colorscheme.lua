local M = {
  'svermeulen/text-to-colorscheme.nvim',
  event = 'VeryLazy',
  enabled = false,
  config = function()
    vim.api.nvim_set_keymap('n', '<f9>', ':T2CAddContrast -0.1<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<f10>', ':T2CAddContrast 0.1<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<f11>', ':T2CAddSaturation -0.1<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<f12>', ':T2CAddSaturation 0.1<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<f8>', ':T2CShuffleAccents<cr>', { noremap = true, silent = true })

    vim.o.background = 'dark'
    require('text-to-colorscheme').setup {
      ai = {
        openai_api_key = os.getenv 'OPENAI_API_KEY',
      },
      hex_palettes = {
        {
          name = 'jungle',
          background_mode = 'dark',
          background = '#1c2a1f',
          foreground = '#c1d3b7',
          accents = {
            '#6dbd5a',
            '#a3d16d',
            '#d1c75a',
            '#d1a35a',
            '#d15a5a',
            '#5ad1b3',
            '#5a8ad1',
          },
        },
        {
          name = 'cyberpunk city at night',
          background_mode = 'dark',
          background = { 240, 5, 11 }, -- #1b1b1d
          foreground = { 240, 0, 66 }, -- #a8a8a8
          accents = {
            { 329, 44, 85 }, -- #d97aab
            { 184, 70, 85 }, -- #41d0d9
            { 22, 70, 85 }, -- #d97a41
            { 157, 70, 73 }, -- #38ba88
            { 341, 53, 85 }, -- #d9668b
            { 272, 70, 85 }, -- #9341d9
            { 194, 70, 85 }, -- #41b6d9
          },
        },
        {
          name = 'ice mountain',
          background_mode = 'dark',
          background = { 214, 48, 22 }, -- #1d2837
          foreground = { 228, 7, 93 }, -- #dee1ee
          accents = {
            { 201, 62, 99 }, -- #60c5fc
            { 205, 36, 100 }, -- #a3d9ff
            { 219, 7, 86 }, -- #cbd1da
            { 191, 35, 88 }, -- #91d1e0
            { 207, 45, 82 }, -- #73a6d0
            { 216, 22, 96 }, -- #bed4f5
            { 214, 34, 79 }, -- #85a3ca
          },
        },
        {
          name = 'koi pond in spring',
          background_mode = 'dark',
          background = { 186, 49, 20 }, -- #1a3134
          foreground = { 158, 11, 84 }, -- #bed6cd
          accents = {
            { 27, 63, 100 }, -- #ffa75e
            { 126, 27, 76 }, -- #8dc192
            { 205, 57, 100 }, -- #6ec2ff
            { 52, 76, 100 }, -- #ffe53d
            { 356, 60, 100 }, -- #ff6670
            { 213, 45, 100 }, -- #8cc0ff
            { 29, 74, 100 }, -- #ff9e42
          },
        },
        {
          name = 'zen meditation',
          background_mode = 'dark',
          background = { 228, 20, 18 }, -- #24262d
          foreground = { 0, 10, 96 }, -- #f4dcdc
          accents = {
            { 80, 23, 71 }, -- #a6b48b
            { 43, 37, 99 }, -- #fde3a0
            { 42, 28, 86 }, -- #dcc99e
            { 209, 22, 84 }, -- #a7bfd6
            { 329, 22, 84 }, -- #d6a7bf
            { 89, 22, 71 }, -- #a1b48c
            { 163, 37, 84 }, -- #87d6bf
          },
        },
        {
          name = 'ocean sunset',
          background_mode = 'dark',
          background = { 214, 48, 23 }, -- #1e2a3a
          foreground = { 45, 13, 95 }, -- #f1e9d2
          accents = {
            { 31, 75, 98 }, -- #f9a03f
            { 7, 62, 95 }, -- #f26d5b
            { 340, 41, 96 }, -- #f48fb1
            { 88, 27, 75 }, -- #a7bf8c
            { 174, 37, 68 }, -- #6dada7
            { 187, 66, 88 }, -- #4dd0e1
            { 207, 42, 98 }, -- #90caf9
          },
        },
        {
          name = 'snowy mountain peak',
          background_mode = 'dark',
          background = { 212, 49, 21 }, -- #1b2735
          foreground = { 219, 7, 95 }, -- #e1e7f1
          accents = {
            { 180, 47, 81 }, -- #6dcece
            { 14, 46, 96 }, -- #f49e83
            { 40, 41, 100 }, -- #ffdc97
            { 311, 21, 81 }, -- #cfa4c7
            { 193, 35, 96 }, -- #9fe1f4
            { 210, 33, 88 }, -- #96bbe0
            { 354, 49, 87 }, -- #de717b
          },
        },
        {
          name = 'mocha',
          background_mode = 'dark',
          background = { 40, 14, 15 }, -- #252320
          foreground = { 42, 13, 100 }, -- #fef4dd
          accents = {
            { 31, 46, 88 }, -- #e0ae79
            { 211, 15, 88 }, -- #becee0
            { 40, 52, 100 }, -- #ffd37a
            { 120, 20, 58 }, -- #769376
            { 27, 67, 93 }, -- #ec954e
            { 16, 40, 75 }, -- #be8672
            { 26, 30, 100 }, -- #ffd4b3
          },
        },
        {
          name = 'desert landscape at dusk',
          background_mode = 'dark',
          background = { 19, 28, 13 }, -- #221c19
          foreground = { 39, 16, 100 }, -- #fff1d6
          accents = {
            { 27, 50, 100 }, -- #ffb980
            { 12, 55, 100 }, -- #ff8f73
            { 43, 45, 100 }, -- #ffde8c
            { 173, 63, 57 }, -- #359186
            { 197, 44, 61 }, -- #58899d
            { 105, 19, 65 }, -- #8ea686
            { 346, 60, 100 }, -- #ff668a
          },
        },
        {
          name = 'spring orchard in full blossom',
          background_mode = 'dark',
          background = { 221, 28, 14 }, -- #1a1e25
          foreground = { 0, 0, 100 }, -- #ffffff
          accents = {
            { 348, 32, 100 }, -- #ffadbe
            { 47, 53, 100 }, -- #ffe278
            { 89, 51, 96 }, -- #b8f578
            { 29, 74, 100 }, -- #ff9e42
            { 195, 65, 100 }, -- #59d6ff
            { 300, 25, 100 }, -- #ffbfff
            { 169, 42, 84 }, -- #7cd6c6
          },
        },
        {
          name = 'moonlit beach',
          background_mode = 'dark',
          background = { 212, 42, 21 }, -- #1f2935
          foreground = { 210, 0, 99 }, -- #fcfcfc
          accents = {
            { 186, 42, 81 }, -- #77c5ce
            { 40, 42, 100 }, -- #ffdb94
            { 300, 15, 86 }, -- #dab9da
            { 210, 40, 89 }, -- #88b6e3
            { 114, 16, 72 }, -- #9eb89b
            { 21, 55, 100 }, -- #ffa473
            { 16, 30, 74 }, -- #bb9283
          },
        },
        {
          name = 'volcanic eruption',
          background_mode = 'dark',
          background = { 320, 10, 12 }, -- #1f1c1e
          foreground = { 30, 6, 94 }, -- #f0e9e2
          accents = {
            { 3, 65, 95 }, -- #f25c54
            { 32, 70, 97 }, -- #f7a74a
            { 50, 86, 98 }, -- #f9d423
            { 205, 36, 100 }, -- #a3d9ff
            { 276, 38, 92 }, -- #c792ea
            { 197, 46, 100 }, -- #89ddff
            { 350, 67, 100 }, -- #ff5370
          },
        },
        {
          name = 'dark stormy sea',
          background_mode = 'dark',
          background = { 212, 52, 22 }, -- #1b2838
          foreground = { 216, 7, 87 }, -- #ced4dd
          accents = {
            { 207, 57, 86 }, -- #5ea2da
            { 205, 36, 100 }, -- #a3d9ff
            { 198, 52, 94 }, -- #74cbf1
            { 27, 60, 100 }, -- #ffab66
            { 12, 65, 97 }, -- #f67656
            { 173, 73, 55 }, -- #268c80
            { 197, 54, 66 }, -- #4d8ea8
          },
        },
        {
          name = 'Japanese tea garden',
          background_mode = 'dark',
          background = { 156, 11, 14 }, -- #212523
          foreground = { 41, 12, 98 }, -- #fbf1dd
          accents = {
            { 83, 37, 74 }, -- #a3be78
            { 32, 60, 100 }, -- #ffb866
            { 12, 20, 94 }, -- #efc8bf
            { 182, 23, 72 }, -- #8db6b8
            { 36, 38, 100 }, -- #fed79d
            { 144, 16, 85 }, -- #b6d9c4
            { 13, 18, 100 }, -- #ffdbd1
          },
        },
        {
          name = 'winter sunrise',
          background_mode = 'dark',
          background = { 221, 28, 16 }, -- #1d2129
          foreground = { 249, 3, 100 }, -- #f8f7ff
          accents = {
            { 348, 32, 100 }, -- #ffadbe
            { 33, 32, 100 }, -- #ffdaad
            { 155, 32, 100 }, -- #adffdd
            { 207, 32, 100 }, -- #addaff
            { 275, 32, 100 }, -- #ddadff
            { 317, 32, 100 }, -- #ffade8
            { 99, 32, 100 }, -- #caffad
          },
        },
        {
          name = 'monkey banana',
          background_mode = 'dark',
          background = { 29, 58, 18 }, -- #2e2013
          foreground = { 51, 15, 90 }, -- #e6e0c3
          accents = {
            { 44, 71, 90 }, -- #e6bb43
            { 37, 64, 61 }, -- #9c7539
            { 35, 81, 90 }, -- #e6982c
            { 52, 49, 90 }, -- #e6d775
            { 60, 39, 61 }, -- #9c9c5f
            { 39, 30, 54 }, -- #8a7c61
            { 36, 33, 90 }, -- #e6c79a
          },
        },
        {
          name = 'old avocado',
          background_mode = 'dark',
          background = { 45, 9, 12 }, -- #1f1f1c
          foreground = { 47, 4, 85 }, -- #d9d7d0
          accents = {
            { 64, 57, 65 }, -- #a0a647
            { 44, 81, 85 }, -- #d9aa29
            { 12, 80, 85 }, -- #d94e2b
            { 38, 55, 85 }, -- #d9ad62
            { 174, 100, 59 }, -- #009687
            { 235, 21, 74 }, -- #9598bc
            { 350, 88, 85 }, -- #d91a3a
          },
        },
        {
          name = 'rainforest',
          background_mode = 'dark',
          background = { 196, 60, 16 }, -- #102128
          foreground = { 132, 29, 79 }, -- #8fca9b
          accents = {
            { 210, 53, 85 }, -- #66a0d9
            { 218, 25, 100 }, -- #bfd7ff
            { 119, 65, 71 }, -- #41b43f
            { 193, 55, 92 }, -- #6acfeb
            { 14, 66, 92 }, -- #eb7450
            { 354, 69, 84 }, -- #d64251
            { 40, 72, 100 }, -- #ffc247
          },
        },
        {
          name = 'jungle',
          background_mode = 'dark',
          background = { 133, 33, 15 }, -- #19261c
          foreground = { 103, 13, 75 }, -- #aec0a7
          accents = {
            { 110, 47, 73 }, -- #71ba63
            { 40, 52, 100 }, -- #ffd37a
            { 180, 47, 74 }, -- #64bdbd
            { 340, 56, 90 }, -- #e4648f
            { 16, 40, 71 }, -- #b5806c
            { 190, 57, 100 }, -- #6ee7ff
            { 273, 41, 82 }, -- #aa7bd1
          },
        },
        {
          name = 'forest',
          background_mode = 'dark',
          background = { 133, 33, 11 }, -- #131d16
          foreground = { 99, 13, 83 }, -- #c3d5b9
          accents = {
            { 119, 45, 75 }, -- #6bbf69
            { 75, 80, 83 }, -- #aad52b
            { 54, 42, 100 }, -- #fff494
            { 158, 33, 85 }, -- #90d8be
            { 147, 66, 70 }, -- #3db372
            { 120, 39, 95 }, -- #94f394
            { 16, 69, 100 }, -- #ff7e4f
          },
        },
        {
          name = 'foggy cityscape',
          background_mode = 'dark',
          background = { 224, 26, 19 }, -- #242831
          foreground = { 228, 7, 100 }, -- #edf1ff
          accents = {
            { 214, 29, 100 }, -- #b5d5ff
            { 281, 20, 96 }, -- #e5c4f5
            { 23, 32, 100 }, -- #ffcdad
            { 170, 24, 80 }, -- #9ccdc5
            { 32, 42, 100 }, -- #ffcd94
            { 89, 35, 83 }, -- #b0d48a
            { 355, 30, 100 }, -- #ffb3b9
          },
        },
        {
          name = 'blazing oranges and reds of a forest fire',
          background_mode = 'dark',
          background = { 23, 26, 12 }, -- #1f1a17
          foreground = { 37, 15, 97 }, -- #f7e9d2
          accents = {
            { 25, 100, 100 }, -- #ff6a00
            { 30, 90, 100 }, -- #ff8c1a
            { 36, 80, 100 }, -- #ffae32
            { 43, 70, 100 }, -- #ffcb4c
            { 11, 80, 100 }, -- #ff5733
            { 11, 100, 100 }, -- #ff2e00
            { 0, 100, 90 }, -- #e60000
          },
        },
        {
          name = 'intense, searing heat of a desert at high noon',
          background_mode = 'dark',
          background = { 30, 51, 23 }, -- #3b2c1d
          foreground = { 42, 20, 96 }, -- #f5e6c4
          accents = {
            { 31, 70, 97 }, -- #f7a54b
            { 37, 54, 98 }, -- #f9c673
            { 16, 82, 91 }, -- #e85d2a
            { 15, 86, 85 }, -- #d94e1f
            { 41, 54, 77 }, -- #c4a35a
            { 30, 51, 65 }, -- #a67c52
            { 34, 49, 63 }, -- #a17e53
          },
        },
        {
          name = 'surreal, otherworldly dreamscape',
          background_mode = 'dark',
          background = { 231, 23, 15 }, -- #1d1e25
          foreground = { 0, 0, 87 }, -- #dedede
          accents = {
            { 272, 45, 100 }, -- #c98cff
            { 165, 58, 86 }, -- #5cdbbc
            { 33, 58, 100 }, -- #ffbc6b
            { 332, 58, 100 }, -- #ff6bb0
            { 103, 58, 86 }, -- #80db5c
            { 212, 58, 100 }, -- #6bb0ff
            { 0, 58, 100 }, -- #ff6b6b
          },
        },
        {
          name = 'star trek',
          background_mode = 'dark',
          background = { 218, 72, 24 }, -- #11213c
          foreground = { 0, 0, 100 }, -- #ffffff
          accents = {
            { 51, 74, 100 }, -- #ffe342
            { 15, 52, 100 }, -- #ff9c7a
            { 122, 37, 100 }, -- #a1ffa4
            { 14, 67, 100 }, -- #ff7c54
            { 207, 66, 100 }, -- #57b3ff
            { 291, 58, 100 }, -- #e96bff
            { 199, 79, 100 }, -- #36bfff
          },
        },
        {
          name = 'chinese garden',
          background_mode = 'dark',
          background = { 207, 23, 16 }, -- #1f2428
          foreground = { 60, 2, 97 }, -- #f8f8f2
          accents = {
            { 345, 62, 100 }, -- #ff6188
            { 20, 59, 99 }, -- #fc9867
            { 45, 60, 100 }, -- #ffd866
            { 90, 46, 73 }, -- #90bb64
            { 186, 48, 91 }, -- #78dce8
            { 250, 35, 95 }, -- #ab9df2
            { 345, 62, 100 }, -- #ff6188
          },
        },
        {
          name = 'Tropical Island',
          background_mode = 'dark',
          background = { 192, 49, 14 }, -- #132125
          foreground = { 60, 0, 100 }, -- #ffffff
          accents = {
            { 25, 70, 100 }, -- #ff974d
            { 222, 47, 100 }, -- #87abff
            { 255, 30, 100 }, -- #c6b3ff
            { 100, 50, 95 }, -- #a1f179
            { 342, 55, 100 }, -- #ff739d
            { 180, 20, 100 }, -- #ccffff
            { 258, 67, 100 }, -- #8754ff
          },
        },
        {
          name = 'OceanicNext',
          background_mode = 'dark',
          background = { 202, 48, 17 }, -- #17252c
          foreground = { 219, 7, 100 }, -- #edf3ff
          accents = {
            { 300, 25, 86 }, -- #dba4db
            { 114, 26, 87 }, -- #aadea4
            { 40, 60, 100 }, -- #ffcc66
            { 210, 50, 89 }, -- #72abe4
            { 179, 45, 77 }, -- #6dc5c4
            { 21, 65, 100 }, -- #ff9359
            { 357, 60, 100 }, -- #ff666e
          },
        },
        {
          name = 'gruvbox',
          background_mode = 'dark',
          background = { 0, 0, 15 }, -- #262626
          foreground = { 48, 21, 100 }, -- #fff4c9
          accents = {
            { 27, 90, 98 }, -- #fa7e19
            { 344, 36, 95 }, -- #f29bb2
            { 42, 81, 97 }, -- #f7bb2f
            { 61, 80, 85 }, -- #d6d92b
            { 157, 21, 88 }, -- #b1e0ce
            { 104, 35, 85 }, -- #a1d98d
            { 6, 79, 99 }, -- #fc4935
          },
        },
        {
          name = 'onedark',
          background_mode = 'dark',
          background = { 220, 23, 19 }, -- #252830
          foreground = { 219, 10, 79 }, -- #b6bdca
          accents = {
            { 286, 46, 92 }, -- #d27fec
            { 95, 38, 80 }, -- #9fcd7f
            { 29, 51, 87 }, -- #dea36d
            { 187, 56, 80 }, -- #5abfcd
            { 207, 59, 100 }, -- #69bbff
            { 39, 46, 96 }, -- #f4cd84
            { 355, 56, 97 }, -- #f76d78
          },
        },
        {
          name = 'dracula',
          background_mode = 'dark',
          background = { 231, 26, 17 }, -- #20222b
          foreground = { 60, 2, 97 }, -- #f7f7f2
          accents = {
            { 326, 53, 100 }, -- #ff78c4
            { 191, 45, 99 }, -- #8be8fc
            { 137, 59, 98 }, -- #66fa90
            { 270, 33, 97 }, -- #cfa6f7
            { 65, 44, 98 }, -- #f1fa8c
            { 135, 68, 99 }, -- #51fc7c
            { 0, 57, 100 }, -- #ff6e6e
          },
        },
        {
          name = 'solarized',
          background_mode = 'dark',
          background = { 192, 59, 15 }, -- #102327
          foreground = { 186, 0, 88 }, -- #e2e2e2
          accents = {
            { 175, 44, 97 }, -- #8af7ee
            { 205, 52, 100 }, -- #7ac8ff
            { 18, 59, 100 }, -- #ff9669
            { 237, 15, 100 }, -- #d9dbff
            { 331, 44, 100 }, -- #ff8fc5
            { 68, 70, 90 }, -- #d0e645
            { 1, 49, 100 }, -- #ff8482
          },
        },
        {
          name = 'barbie world',
          background_mode = 'dark',
          background = '#2a1d2d',
          foreground = '#f7d1e0',
          accents = {
            '#ff8fd4',
            '#f5a3e1',
            '#f7b8c6',
            '#f9e0a9',
            '#a6e6f2',
            '#b5a8f7',
            '#f77d9e',
          },
        },
        {
          name = 'circus',
          background_mode = 'dark',
          background = '#2b2a2f',
          foreground = '#f7f7f7',
          accents = {
            '#ffcb6b',
            '#4dd279',
            '#cfd485',
            '#57c7ff',
            '#ff6ac1',
            '#9a79d7',
            '#ff5c57',
          },
        },
      },
      hsv_palettes = {
        {
          name = 'Middle Eastern spice market',
          background_mode = 'dark',
          background = { 26, 30, 15 }, -- #27211b
          foreground = { 39, 0, 100 }, -- #ffffff
          accents = {
            { 33, 54, 100 }, -- #ffc175
            { 30, 43, 84 }, -- #d7a97a
            { 27, 26, 88 }, -- #e1c1a6
            { 32, 36, 100 }, -- #ffd4a3
            { 36, 5, 100 }, -- #fffaf3
            { 43, 41, 100 }, -- #ffe196
            { 13, 49, 100 }, -- #ff9d82
          },
        },
        {
          name = 'teenage mutant ninja turtles',
          background_mode = 'dark',
          background = { 196, 20, 13 }, -- #1b2022
          foreground = { 144, 0, 87 }, -- #dfdfdf
          accents = {
            { 129, 44, 84 }, -- #79d687
            { 49, 55, 100 }, -- #ffe673
            { 30, 68, 100 }, -- #ffa851
            { 200, 55, 100 }, -- #72d0ff
            { 146, 57, 82 }, -- #59d28d
            { 282, 41, 82 }, -- #b97dd2
            { 5, 42, 100 }, -- #ff9e94
          },
        },
        {
          name = 'studio ghibli forest park',
          background_mode = 'dark',
          background = { 167, 29, 15 }, -- #1a2523
          foreground = { 107, 4, 100 }, -- #f7fff5
          accents = {
            { 27, 60, 100 }, -- #ffa965
            { 12, 65, 100 }, -- #ff7b59
            { 173, 73, 72 }, -- #31b8a8
            { 197, 54, 91 }, -- #6ac3e7
            { 43, 55, 100 }, -- #ffd774
            { 38, 21, 100 }, -- #ffebca
            { 105, 29, 81 }, -- #a0cd91
          },
        },
        {
          name = 'monkey jungle',
          background_mode = 'dark',
          background = { 125, 0, 13 }, -- #202020
          foreground = { 60, 0, 100 }, -- #ffffff
          accents = {
            { 86, 28, 100 }, -- #e0ffb8
            { 29, 28, 100 }, -- #ffdab8
            { 154, 28, 100 }, -- #b8ffe0
            { 219, 28, 100 }, -- #b8d1ff
            { 331, 28, 100 }, -- #ffb8da
            { 269, 28, 100 }, -- #dab8ff
            { 0, 28, 100 }, -- #ffb8b8
          },
        },
        {
          name = 'cozy fireplace',
          background_mode = 'dark',
          background = { 17, 41, 15 }, -- #251a16
          foreground = { 37, 11, 100 }, -- #fff4e3
          accents = {
            { 28, 85, 100 }, -- #ff8b26
            { 48, 94, 100 }, -- #ffcf0f
            { 24, 100, 94 }, -- #ef6000
            { 6, 74, 77 }, -- #c54233
            { 283, 51, 79 }, -- #ad63cb
            { 204, 76, 97 }, -- #3bacf8
            { 168, 86, 83 }, -- #1ed3af
          },
        },
      },
      default_palette = 'jungle',
    }

    vim.cmd [[colorscheme text-to-colorscheme]]
  end,
}

return M

--[[
-- setup must be called before loading the colorscheme
-- Default options:
require("text-to-colorscheme").setup({
  ai = {
     gpt_model = "gpt-4",
     openai_api_key = nil, -- Set your own OpenAI API key to this value
     green_darkening_amount = 0.85, -- Often, the generated theme results in green colors that seem to our human eyes to be more bright than it actually is, therefore this is a fudge factor to account for this, to darken greens to better match the brightness of other colors.  Enabled or disabled with auto_darken_greens flag
     auto_darken_greens = true,
     minimum_foreground_contrast = 0.4, -- This is used to touch up the generated theme to avoid generating foregrounds that match the background too closely.  Enabled or disabled with enable_minimum_foreground_contrast flag
     enable_minimum_foreground_contrast = true,
     temperature = 0, -- Set this to a value between 0 and 1, where 0 means it will generate similar looking color schemes every time, and 1 means that each time will be very different.  See openai docs for more information on this setting
  },
  disable_builtin_schemes = false,  -- Set to true to disable all pre-generated color schemes, so that only your custom ones show in T2CSelect
  undercurl = true,
  underline = true,
  verbose_logs = false, -- When true, will output logs to echom, to help debugging issues with this plugin
  bold = true,
  italic = {
     strings = true,
     comments = true,
     operators = false,
     folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  save_as_hsv = false, -- When true, T2CSave will save colors as HSV instead of hex
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,
  dim_inactive = false,
  transparent_mode = false,
  hsv_palettes = {},
  hex_palettes = {},
  overrides = {},
  default_palette = "gruvbox",
}) ]]
