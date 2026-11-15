return {
	"stevearc/conform.nvim",
	opts = {
		-- format_on_save = {
		-- 	timeout_ms = 5000,
		--     lsp_format = "fallback",
		-- },
		formatters_by_ft = {
			astro = { "prettier" },
			blade = { "prettier" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			css = { "prettier" },
			dockerfile = { "dockerfmt" },
			gdscript = { "gdformat" },
			go = { "gofmt" },
			html = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			php = { "pint" },
			python = { "black" },
			sh = { "shfmt" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			yaml = { "prettier" },
		},
		formatters = {
			["clang-format"] = {
				prepend_args = { "-style=file", "-fallback-style=LLVM" },
			},
		},
	},
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ bufnr = 0 })
			end,
			desc = "Format current buffer",
		},
		{
			"<leader>F",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			desc = "Format current buffer asynchronously",
		},
	},
}
