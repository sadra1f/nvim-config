return {
	"mbbill/undotree",
	cmd = {
		"UndotreeFocus",
		"UndotreeHide",
		"UndotreePersistUndo",
		"UndotreeShow",
		"UndotreeToggle",
	},
	keys = {
		{
			"<leader>u",
			function()
				vim.cmd.UndotreeToggle()
				vim.cmd.UndotreeFocus()
			end,
		},
	},
	init = function()
		vim.g.undotree_WindowLayout = 3 -- Open tree on the right
		vim.g.undotree_SplitWidth = 48 - 1
	end,
}
