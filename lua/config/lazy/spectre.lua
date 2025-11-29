return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- vim.keymap.set("n", "<leader>pwh", '<cmd>lua require("spectre").toggle()<CR>', {
		-- 	desc = "Toggle Spectre",
		-- })
		vim.keymap.set("n", "<leader>pwf", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("v", "<leader>pwf", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("n", "<leader>pcf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			desc = "Search on current file",
		})
	end,
}
