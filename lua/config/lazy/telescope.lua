return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.2",
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
			"<leader>pF",
			function()
				require("telescope.builtin").git_files()
			end,
		},
		{
			"<leader>pb",
			function()
				require("telescope.builtin").buffers()
			end,
		},
		{
			"<leader>tT",
			function()
				require("telescope.builtin").oldfiles()
			end,
		},
		{
			"<C-p>",
			function()
				require("telescope.builtin").commands()
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
