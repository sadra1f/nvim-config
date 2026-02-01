return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			-- format_on_save = {
			-- 	timeout_ms = 5000,
			--     lsp_format = "fallback",
			-- },
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				lua = { "stylua" },
				go = { "gofmt" },
				html = { "prettier" },
				css = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "prettier" },
				astro = { "prettier" },
				python = { "black" },
				sh = { "shfmt" },
				dockerfile = { "dockerfmt" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = { "-style=file", "-fallback-style=LLVM" },
				},
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ bufnr = 0 })
		end)
		vim.keymap.set("n", "<leader>F", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end)
	end,
}
