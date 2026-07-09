return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},
	{
		"nmac427/guess-indent.nvim",
		commit = "84a4987ff36798c2fc1169cbaff67960aed9776f",
		opts = { auto_cmd = true },
	},
}
