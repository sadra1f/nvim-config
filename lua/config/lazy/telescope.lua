return {
	"nvim-telescope/telescope.nvim",
	-- WARN: This version is not compatible with "main" branch of "nvim-treesitter"
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = { "Telescope" },
	keys = {
		{
			"<leader>pf",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"<C-p>",
			function()
				require("telescope.builtin").git_files()
			end,
		},
		{
			"<leader>pws",
			function()
				local word = vim.fn.expand("<cword>")
				require("telescope.builtin").grep_string({ search = word })
			end,
		},
		{
			"<leader>pWs",
			function()
				local word = vim.fn.expand("<cWORD>")
				require("telescope.builtin").grep_string({ search = word })
			end,
		},
		{
			"<leader>ps",
			function()
				require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
			end,
		},
		{
			"<leader>vh",
			function()
				require("telescope.builtin").help_tags()
			end,
		},
	},
}
