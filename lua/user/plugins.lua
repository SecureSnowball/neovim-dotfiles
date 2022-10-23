-- Plugins
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require'nvim-treesitter.configs'.setup {
                context_commentstring = {
                    enable = true
                }
            }
        end
    }
    use 'folke/tokyonight.nvim'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-dap'

    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use {
        "rafamadriz/friendly-snippets",
        commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1"
    } -- a bunch of snippets to use

    use {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    } -- simple to use language server installer
    use "williamboman/mason-lspconfig.nvim"
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            sources = {require("null-ls").builtins.formatting.stylua, require("null-ls").builtins.diagnostics.eslint,
                       require("null-ls").builtins.completion.spell}
        end
    }

    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup()
        end
    }

    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup({
                plugins = {
                    marks = true, -- shows a list of your marks on ' and `
                    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    spelling = {
                        enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        suggestions = 20 -- how many suggestions should be shown in the list?
                    },
                    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                    -- No actual key bindings are created
                    presets = {
                        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                        motions = true, -- adds help for motions
                        text_objects = true, -- help for text objects triggered after entering an operator
                        windows = true, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = true, -- bindings for folds, spelling and others prefixed with z
                        g = true -- bindings for prefixed with g
                    }
                },
                -- add operators that will trigger motion and text object completion
                -- to enable all native operators, set the preset / operators plugin above
                operators = {
                    gc = "Comments"
                },
                key_labels = {
                    -- override the label used to display some keys. It doesn't effect WK in any other way.
                    -- For example:
                    -- ["<space>"] = "SPC",
                    -- ["<cr>"] = "RET",
                    -- ["<tab>"] = "TAB",
                },
                icons = {
                    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                    separator = "➜", -- symbol used between a key and it's label
                    group = "+" -- symbol prepended to a group
                },
                popup_mappings = {
                    scroll_down = '<c-d>', -- binding to scroll down inside the popup
                    scroll_up = '<c-u>' -- binding to scroll up inside the popup
                },
                window = {
                    border = "none", -- none, single, double, shadow
                    position = "bottom", -- bottom, top
                    margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
                    padding = {2, 2, 2, 2}, -- extra window padding [top, right, bottom, left]
                    winblend = 0
                },
                layout = {
                    height = {
                        min = 4,
                        max = 25
                    }, -- min and max height of the columns
                    width = {
                        min = 20,
                        max = 50
                    }, -- min and max width of the columns
                    spacing = 3, -- spacing between columns
                    align = "left" -- align columns left, center or right
                },
                ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
                hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
                show_help = true, -- show help message on the command line when the popup is visible
                show_keys = true, -- show the currently pressed key and its label as a message in the command line
                triggers = "auto", -- automatically setup triggers
                -- triggers = {"<leader>"} -- or specify a list manually
                triggers_blacklist = {
                    -- list of mode / prefixes that should never be hooked by WhichKey
                    -- this is mostly relevant for key maps that start with a native binding
                    -- most people should not need to change this
                    i = {"j", "k"},
                    v = {"j", "k"}
                },
                -- disable the WhichKey popup for certain buf types and file types.
                -- Disabled by deafult for Telescope
                disable = {
                    buftypes = {},
                    filetypes = {"TelescopePrompt"}
                }
            })
        end
    }

    use 'JoosepAlviste/nvim-ts-context-commentstring'

    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = {
                        left = '',
                        right = ''
                    },
                    section_separators = {
                        left = '',
                        right = ''
                    },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {}
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            })
        end
    }
    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("toggleterm").setup({
                direction = 'float',
                float_opts = {
                    border = 'curved'
                }
            })
        end
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end
    }
end)

