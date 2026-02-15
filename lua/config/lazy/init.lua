return {
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"eandrju/cellular-automaton.nvim",
		keys = {
			{
				"<leader>ca",
				function()
					require("cellular-automaton").start_animation("make_it_rain")
				end,
			},
		},
	},
}
