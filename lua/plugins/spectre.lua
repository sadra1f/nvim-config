return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		open_cmd = "botright vnew | vertical resize 48 | set nonumber | set norelativenumber",
		replace_engine = vim.fn.has("macunix") == 1 and vim.fn.executable("gsed") == 1 and {
			sed = {
				cmd = "gsed",
				args = { "-i", "-E" },
			},
		} or nil,
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
