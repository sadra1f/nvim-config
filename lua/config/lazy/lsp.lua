return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"brenoprata10/nvim-highlight-colors",
	},
	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local highlight_colors = require("nvim-highlight-colors")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("html", {
			filetypes = {
				"html",
				"blade",
			},
		})

		vim.lsp.config("tailwindcss", {
			filetypes = {
				"astro",
				"astro-markdown",
				"blade",
				"django-html",
				"htmldjango",
				"html",
				"htmlangular",
				"mdx",
				"php",
				"razor",
				"css",
				"less",
				"postcss",
				"sass",
				"scss",
				"stylus",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"svelte",
			},
		})

		vim.lsp.config("intelephense", {
			on_attach = function(client, bufnr)
				client.server_capabilities.diagnosticProvider = nil
			end,
			settings = {
				intelephense = {
					telemetry = { enabled = false },
				},
			},
		})

		vim.lsp.config("phpantom_lsp", {
			on_attach = function(client, bufnr)
				local disabled_methods = {
					["textDocument/completion"] = true,
					["textDocument/hover"] = true,
					["textDocument/definition"] = true,
				}

				client.server_capabilities.completionProvider = nil
				client.server_capabilities.hoverProvider = nil
				client.server_capabilities.definitionProvider = nil

				local supports_method = client.supports_method

				client.supports_method = function(self, method, opts)
					if disabled_methods[method] then
						return false
					end
					return supports_method(self, method, opts)
				end
			end,
		})

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"astro",
				-- "cspell_ls",
				"cssls",
				"docker_compose_language_service",
				"docker_language_server",
				"eslint",
				-- "gopls",
				"html",
				"intelephense",
				"jsonls",
				"lua_ls",
				"phpantom_lsp",
				"pyright",
				-- "rust_analyzer",
				"tailwindcss",
				"vtsls",
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		highlight_colors.setup({
			exclude_filetypes = {
				"codecompanion",
				"lazy",
				"mason",
				"neo-tree",
				"spectre_panel",
				"TelescopePrompt",
			},
			exclude_buftypes = {},
		})

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				-- { name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
			formatting = {
				format = function(entry, item)
					local color = highlight_colors.format(entry, {
						kind = item.kind,
					})

					if color.abbr then
						item.icon = color.abbr
						item.icon_hl_group = color.abbr_hl_group
					end

					return item
				end,
			},
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
