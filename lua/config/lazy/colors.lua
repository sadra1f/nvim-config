function SetColors(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	local term_hl = "Normal:NormalFloat,EndOfBuffer:NormalFloat,SignColumn:NormalFloat"
	vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter", "WinEnter" }, {
		callback = function()
			local win = vim.api.nvim_get_current_win()
			if vim.bo.buftype == "terminal" then
				vim.wo[win].winhighlight = term_hl
			elseif vim.wo[win].winhighlight == term_hl then
				vim.wo[win].winhighlight = ""
			end
		end,
	})
end

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
