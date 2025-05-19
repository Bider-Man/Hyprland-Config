-- Setting up Lazypath
local lazypath =vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Input which plugins you want to install
plugins = {
    -- Colour Scheme
    "tanvirtin/monokai.nvim",

    --NVim Web Dev Icons
    {
        "nvim-tree/nvim-web-devicons",
        opts = {},
        url = "https://github.com/nvim-tree/nvim-web-devicons.git",
    },

    --Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html"},
                sync_install = false,
                highlight = {enabled = true},
                indent = {enabled = true},
            })
        end
    },

    --Luarocks
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, --Very high required
        config = true,
    },

    --Nvim Bar
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },

    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },

    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
            "hrsh7th/cmp-buffer", -- buffer auto-completion
            "hrsh7th/cmp-path", -- path auto-completion
            "hrsh7th/cmp-cmdline", -- cmdline auto-completion
        },
        config = function()
            require("config.nvim-cmp")
        end,
    },

    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },

    -- LSP Manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- LazyGit Integration
    {
        "kdheepak/lazygit.nvim",
        lazy = true, -- Ensure this is lazy-loaded
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim", -- Required dependency
        },
        keys = {
            { "<leader>lg", "w<cmd>LazyGit<cr>", desc = "LazyGit" } -- Keybinding
        },
    },

    --Multicursor
    {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvimtools/hydra.nvim",
        },
        opts = {},
        cmd = {"MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPatten", "MCunderCursor"},
        keys = {
            {
                mode = {"v", "n"},
                "<Leader>m",
                "<cmd>MCstart<cr>",
                desc = "Select or choose a word under cursor",
            },
        },
    },

    --Nvim Orgmode
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        config = function()
            require("orgmode").setup({
                org_agenda_files = "~/orgfiles/**/*",
                org_default_notes_files = "~orgfiles/refile.org",
            })
        end,
    },

    --nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            --Disable netrw (MUST be before setup)
           vim.g.loaded_netrw = 1
           vim.g.loaded_netrwPlugin = 1

            --Enable 24 bit colours
           vim.opt.termguicolors = true

            --Setup custom options
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end,
        --Optional: Lazy-load when opening NvimTree
        cmd = {"NvimTreeToggle", "NvimTreeFocus"},
        keys = {
            {"<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer"}
        }
    },

    --Scientific Note-taking
    {
        "jbyuki/nabla.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "williamboman/mason.nvim",
        },
        lazy = true,

        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {"latex"},
                auto_install = true,
                sync_install = false,
            })
        end,

        keys = function()
            return {
                {
                    "<leader>p",
                    ':lua require("nabla").popup()<cr>',
                    desc = "NablaPopUp",
                },
            }
        end,
    },
}

-- Installing the plugins
require("lazy").setup(plugins)
