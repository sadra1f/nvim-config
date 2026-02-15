return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		opts = {
			close_if_last_window = false,
			sort_case_insensitive = true,
			source_selector = {
				winbar = true,
				statusline = false,
				sources = {
					{ source = "filesystem", display_name = "Files" },
					{ source = "buffers", display_name = "Buffers" },
					{ source = "git_status", display_name = "Git " },
					{ source = "document_symbols", display_name = "Symbols" },
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
			},
			document_symbols = {
				follow_cursor = true,
			},
		},
		cmd = { "Neotree" },
		keys = {
			{ "<leader>E", "<cmd>Neotree<cr>" },
			{ "<leader>e", "<cmd>Neotree toggle<cr>" },
		},
	},
}
