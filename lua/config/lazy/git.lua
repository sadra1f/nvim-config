return {
	{ "tpope/vim-fugitive" },
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
