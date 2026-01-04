return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local spectre = require("spectre")

		spectre.setup({
			open_cmd = "rightbelow vnew",
		})

		vim.keymap.set({ "n", "v" }, "<leader>pwf", function()
			spectre.open_visual({ select_word = true })
		end, { desc = "Search current word" })
		vim.keymap.set({ "n", "v" }, "<leader>pcf", function()
			spectre.open_file_search({ select_word = true })
		end, { desc = "Search on current file" })
	end,
}
