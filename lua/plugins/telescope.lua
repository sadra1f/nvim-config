return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")

		telescope.setup({
			extensions = {
				["ui-select"] = {
					themes.get_cursor({
						layout_config = {
							height = 12,
						},
					}),
				},
			},
		})
		telescope.load_extension("ui-select")

		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>pF", builtin.git_files, { desc = "Find Git files" })
		vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Find open buffers" })
		vim.keymap.set("n", "<leader>T", builtin.oldfiles, { desc = "Find recent files" })
		vim.keymap.set("n", "<C-p>", builtin.commands, { desc = "Search commands" })
		vim.keymap.set("n", "<leader>?", builtin.keymaps, { desc = "Search keymaps" })
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Search help tags" })
		vim.keymap.set("n", "<leader>pws", function()
			builtin.grep_string({
				search = vim.fn.expand("<cword>"),
			})
		end, { desc = "Search word under cursor" })
		vim.keymap.set("n", "<leader>pWs", function()
			builtin.grep_string({
				search = vim.fn.expand("<cWORD>"),
			})
		end, { desc = "Search WORD under cursor" })
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({
				search = vim.fn.input("Grep > "),
			})
		end, { desc = "Search for text" })
		for _, key in ipairs({ "<leader>p", "<leader>pp" }) do
			vim.keymap.set("n", key, function()
				builtin.registers(themes.get_cursor({
					layout_config = {
						height = 12,
					},
				}))
			end, { desc = "Browse registers (Clipboard)" })
		end
	end,
}
