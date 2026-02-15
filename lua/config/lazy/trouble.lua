return {
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			gui_style = {
				fg = "NONE",
				bg = "NONE",
			},
			highlight = {
				before = "",
				keyword = "bg",
				after = "",
			},
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/todo-comments.nvim",
		},
		opts = {
			modes = {
				workspace = {
					desc = "Diagnostics and TODOs",
					sections = {
						"diagnostics",
						"todo",
					},
				},
			},
			win = {
				position = "right",
				size = 48,
			},
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>vt",
				function()
					require("trouble").toggle("workspace")
				end,
			},
		},
	},
}
