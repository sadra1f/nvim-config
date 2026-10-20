return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"fredrikaverpil/neotest-golang",
		"leoluz/nvim-dap-go",
	},
	cmd = { "Neotest" },
	keys = {
		{
			"<leader>tr",
			function()
				require("neotest").run.run({
					suite = false,
					testify = true,
				})
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tv",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Debug: Summary Toggle",
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.run({
					suite = true,
					testify = true,
				})
			end,
			desc = "Debug: Running Test Suite",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({
					suite = false,
					testify = true,
					strategy = "dap",
				})
			end,
			desc = "Debug: Debug Nearest Test",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open()
			end,
			desc = "Debug: Open test output",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.run(vim.fn.getcwd())
			end,
			desc = "Run all tests in working directory",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-golang")({
					dap = { justMyCode = false },
				}),
			},
		})
	end,
}
