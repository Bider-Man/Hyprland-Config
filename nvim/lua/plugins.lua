--------------------------------
-------- PLUGIN MANAGER --------
--------------------------------

-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{"Failed to clone lazy.nvim: \n", "ErrorMsg"},
			{out, "WarningMsg"},
			{"\nPress any key to exit..."},
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-------------------------
-------- PLUGINS --------
-------------------------

plugins = {

	---- NVIM-TREESITTER ----
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	---- BLINK-CMP ----
	{
		"saghen/blink.cmp",
		dependencies = {"rafamadriz/friendly-snippets"},
		version = "1.*",
		--@modules "blink.cmp"
		--@type blink.cmp.Config
		opts = {
			keymap = {preset = "default"},
			appearance = {
				nerd_font_variant = "mono"
			},
			completion = {documentation = {auto_show = false}},
			sources = {
				default = {"lsp", "path", "snippets", "buffer"},
			},
			fuzzy = {implementation = "prefer_rust_with_warning"}
		},
		opts_extend = {"sources.default"}
	},

	---- PYTHON-FSTRING-TOGGLE ----
	{
		"roobert/f-string-toggle.nvim",
		config = function()
			require("f-string-toggle").setup({
				key_binding = "<leader>q",
				key_binding_desc = "Toggle f-string",
				filestype = {"python"},
			})
		end,
	},

	---- MARKDOWN-PREVIEW ----
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = ":call mkdp#util#install()",
	},

	---- COLORSCHEME ----
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	---- TELESCOPE ----
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fr", builtin.live_grep, { desc = "Live Grep" })
	    	vim.keymap.set("n", "<leader>fr", builtin.buffers, { desc = "Find Buffers" })
	    	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
	    	vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
		end
	},

	---- FILE EXPLORER ----
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {
				view = {
					width = 35,
				},
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")
					local function opts(desc)
						return { desc = "File Tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
					end

					vim.keymap.set("n", "<leader>f", api.tree.toggle, opts("Toggle"))
					vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
					vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
					vim.keymap.set("n", "a", api.fs.create, opts("Create File/Directory"))
					vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
					vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
					vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
					vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
					vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
					vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
				end,
			}
		end
	},

	---- MASON ----
	{
		"williamboman/mason.nvim",
		opts = { ensure_installed = { "tree-sitter-cli" } },
	},

	---- NOTETAKING ----
	{
		"jbyuki/nabla.nvim",
		dependencies = {
			"nvim-neo-tree/neo-tree.nvim",
			"williamboman/mason.nvim",
		},
		lazy = true,

		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "latex" },
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

	---- TELEKASTEN ----
	{
		"renerocksai/telekasten.nvim",
		dependencies = {"nvim-telescope/telescope.nvim"}
	}
}

-------- SETTING UP PLUGINS --------

require("lazy").setup(plugins, {
	install = {colorscheme = {"tokyonight"}},
	checker = {enabled = true},
})

