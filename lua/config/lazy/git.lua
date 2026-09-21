return {
	{
		"tpope/vim-fugitive",
		cmd = {
			"Git",
			"Gedit",
			"Gsplit",
			"Gdiffsplit",
			"Gvdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"Glgrep",
			"GMove",
			"GDelete",
			"GBrowse",
		},
		keys = {
			{
				"<leader>gg",
				"<cmd>botright vertical Git<cr>"
					.. "<cmd>vertical resize 48<cr>"
					.. "<cmd>set nonumber<cr>"
					.. "<cmd>set norelativenumber<cr>",
				mode = { "n" },
				desc = "Git",
			},
			{
				"<leader>gd",
				"<cmd>Gvdiffsplit<cr>",
				mode = { "n" },
				desc = "Git diff split",
			},
			{
				"<leader>gb",
				"<cmd>Git blame<cr>",
				mode = { "n" },
				desc = "Git blame",
			},
			{
				"<leader>gm",
				"<cmd>Git mergetool<cr>",
				mode = { "n" },
				desc = "Git merge",
			},
		},
	},
	{
		"airblade/vim-gitgutter",
		config = function()
			vim.cmd("GitGutterLineNrHighlightsEnable")

			-- Define custom highlight groups for line numbers
			vim.cmd([[
                highlight GitGutterAdd    guifg=#a6e3a1 gui=bold
                highlight GitGutterChange guifg=#f9e2af gui=bold
                highlight GitGutterDelete guifg=#f38ba8 gui=bold
            ]])
			-- vim.cmd([[
			--     highlight GitGutterAdd    guifg=green    gui=bold
			--     highlight GitGutterChange guifg=yellow   gui=bold
			--     highlight GitGutterDelete guifg=red      gui=bold
			-- ]])
		end,
	},
}
