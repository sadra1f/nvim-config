function R(name)
	require("plenary.reload").reload_module(name)
end

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
