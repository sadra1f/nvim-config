return {
	"olimorris/codecompanion.nvim",
	version = "^19.0.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"j-hui/fidget.nvim",
		"OXY2DEV/markview.nvim",
	},
	cmd = {
		"CodeCompanion",
		"CodeCompanionChat",
		"CodeCompanionActions",
		"CodeCompanionCmd",
		"CodeCompanionCLI",
	},
	keys = {
		{
			"<leader>CC",
			function()
				require("codecompanion").cli({ agent = "codex" })
			end,
			mode = "n",
			desc = "Codex CLI",
		},
		{
			"<leader>cc",
			function()
				local bufnr = vim.api.nvim_get_current_buf()
				local filepath = vim.api.nvim_buf_get_name(bufnr)

				if filepath == "" or vim.bo[bufnr].buftype ~= "" then
					require("codecompanion").cli({ agent = "codex" })
				else
					local filename = vim.fn.fnamemodify(filepath, ":.")

					require("codecompanion").cli(("- Selected file @%s"):format(filename), {
						agent = "codex",
					})
				end
			end,
			mode = "n",
			desc = "Codex CLI (current file)",
		},
		{
			"<leader>CC",
			"<cmd>CodeCompanion<cr>",
			mode = "v",
			desc = "AI prompt",
		},
		{
			"<leader>cc",
			function()
				require("codecompanion").cli("", { agent = "codex" })
			end,
			mode = "v",
			desc = "Prompt Codex with selection",
		},
	},
	config = function()
		require("codecompanion").setup({
			interactions = {
				cli = {
					agent = "codex",
					agents = {
						codex = {
							cmd = "codex",
							args = {},
							description = "OpenAI Codex CLI",
							provider = "terminal",
						},
					},
					opts = {
						auto_insert = true,
						reload = true,
					},
				},
				chat = {
					adapter = "http_api",
				},
				cmd = {
					adapter = "http_api",
				},
				inline = {
					adapter = "http_api",
				},
				background = {
					adapter = "http_api",
				},
			},
			adapters = {
				http = {
					http_api = function()
						return require("codecompanion.adapters").extend("openai", {
							name = "http_api",
							formatted_name = "HTTP API",
							url = "http://127.0.0.1:11434/v1/chat/completions",
							schema = {
								model = {
									default = "default",
								},
							},
						})
					end,
				},
			},
			display = {
				chat = {
					window = {
						layout = "vertical",
						position = "right",
						width = 48,
						opts = {
							number = false,
							relativenumber = false,
							wrap = true,
							signcolumn = "no",
						},
					},
				},
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "codecompanion" },
			callback = function()
				vim.cmd("Markview attach")
			end,
		})

		local spinner = {
			completed = "Completed",
			error = "Error",
			cancelled = "Cancelled",
		}

		local function format_adapter(adapter)
			local parts = { adapter.formatted_name }
			if adapter.model and adapter.model ~= "" then
				table.insert(parts, "(" .. adapter.model .. ")")
			end
			return table.concat(parts, " ")
		end

		local function codecompanion_spinner()
			local ok, progress = pcall(require, "fidget.progress")
			if not ok then
				return
			end

			spinner.handles = {}

			local group = vim.api.nvim_create_augroup("dotfiles.codecompanion.spinner", { clear = true })

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionRequestStarted",
				group = group,
				callback = function(args)
					local handle = progress.handle.create({
						title = "",
						message = "Processing...",
						lsp_client = {
							name = format_adapter(args.data.adapter),
						},
					})
					spinner.handles[args.data.id] = handle
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionRequestFinished",
				group = group,
				callback = function(args)
					local handle = spinner.handles[args.data.id]
					spinner.handles[args.data.id] = nil

					if handle then
						if args.data.status == "success" then
							handle.message = spinner.completed
						elseif args.data.status == "error" then
							handle.message = spinner.error
						else
							handle.message = spinner.cancelled
						end
						handle:finish()
					end
				end,
			})
		end

		codecompanion_spinner()
	end,
}
