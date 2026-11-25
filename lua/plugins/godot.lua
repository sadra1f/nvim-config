return {
	"dpowling/godot-lsp.nvim",
	commit = "4a29e680a6c21ff7b6f1c45f686d1cceb1420828",
	ft = "gdscript",
	config = function()
		local godot_lsp = require("godot-lsp")

		godot_lsp.setup()
		godot_lsp.start()

		vim.defer_fn(function()
			vim.cmd("LspRestart")
		end, 1000)
	end,
}
