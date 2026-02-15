return {
	{
		"github/copilot.vim",
		cmd = "Copilot",
		init = function()
			vim.g.copilot_enabled = false
			vim.g.copilot_filetypes = {
				["*"] = false,
			}
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		version = "^18.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"github/copilot.vim",
			"j-hui/fidget.nvim",
			"OXY2DEV/markview.nvim",
		},
		cmd = {
			"CodeCompanion",
			"CodeCompanionChat",
			"CodeCompanionActions",
		},
		keys = {
			{ "<leader>cc", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions" },
		},
		config = function()
			require("codecompanion").setup({
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
				local parts = {}
				table.insert(parts, adapter.formatted_name)
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

				local group = vim.api.nvim_create_augroup("dotfiles.codecompanion.spinner", {})

				vim.api.nvim_create_autocmd("User", {
					pattern = "CodeCompanionRequestStarted",
					group = group,
					callback = function(args)
						local handle = progress.handle.create({
							title = "",
							message = "Sending...",
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
	},
}
