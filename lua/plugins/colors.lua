return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = false,
				float = {
					transparent = false, -- enable transparent floating windows
					solid = false, -- use solid styling for floating windows, see |winborder|
				},
				no_italic = true,
				custom_highlights = function(colors)
					return {
						CursorLineNr = { fg = colors.lavender, bold = true },
					}
				end,
			})

			-- Use this on active color scheme
			SetColors()
		end,
	},
}
