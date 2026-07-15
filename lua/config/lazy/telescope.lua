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

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>pF", builtin.git_files, {})
		vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>T", builtin.oldfiles, {})
		vim.keymap.set("n", "<C-p>", builtin.commands, {})
		vim.keymap.set("n", "<leader>?", builtin.keymaps, {})
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>pws", function()
			builtin.grep_string({
				search = vim.fn.expand("<cword>"),
			})
		end, {})
		vim.keymap.set("n", "<leader>pWs", function()
			builtin.grep_string({
				search = vim.fn.expand("<cWORD>"),
			})
		end, {})
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({
				search = vim.fn.input("Grep > "),
			})
		end, {})
	end,
}
