return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>vt",
				function()
					require("trouble").toggle("diagnostics")
				end,
			},

			{
				"[t",
				function()
					require("trouble").next("diagnostics", { skip_groups = true, jump = true })
				end,
			},

			{
				"]t",
				function()
					require("trouble").previous("diagnostics", { skip_groups = true, jump = true })
				end,
			},
		},
	},
}
