return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		open_cmd = "rightbelow vnew",
	},
	cmd = { "Spectre" },
	keys = {
		{
			"<leader>pwf",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			mode = { "n", "v" },
			desc = "Search current word",
		},
		{
			"<leader>pcf",
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			mode = { "n", "v" },
			desc = "Search on current file",
		},
	},
}
