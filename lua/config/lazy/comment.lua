return {
	{
		"nvim-mini/mini.comment",
		version = "v0.18.*",
		keys = {
			{
				"<leader>/",
				"gcc",
				remap = true,
				mode = { "n" },
				desc = "Toggle comment (Use this over gcc)",
			},
			{
				"<leader>/",
				"gc",
				remap = true,
				mode = { "x" },
				desc = "Toggle comment (Use this over gc)",
			},
		},
		opts = {
			options = {
				-- Function to compute custom 'commentstring'
				custom_commentstring = function(ref_position)
					local bufnr = vim.api.nvim_get_current_buf()
					local row, col
					if ref_position then
						row, col = ref_position[1] - 1, ref_position[2]
					else
						local cursor = vim.api.nvim_win_get_cursor(0)
						row, col = cursor[1] - 1, cursor[2]
					end
					local fallback = vim.bo[bufnr].commentstring
					local parser = vim.treesitter.get_parser(bufnr, "")
					if not parser then
						return fallback
					end
					local captures = vim.treesitter.get_captures_at_pos(bufnr, row, col)
					for i = #captures, 1, -1 do
						local capture = captures[i]
						local metadata = capture.metadata
						local commentstring = metadata["bo.commentstring"]
							or (metadata[capture.id] and metadata[capture.id]["bo.commentstring"])
						if commentstring then
							return commentstring
						end
					end
					return fallback
				end,

				-- Whether to ignore blank lines when commenting
				ignore_blank_line = false,

				-- Whether to ignore blank lines in actions and textobject
				start_of_line = false,

				-- Whether to force single space inner padding for comment parts
				pad_comment_parts = true,
			},

			mappings = {
				-- Toggle comment Normal and Visual modes
				comment = "gc",

				-- Toggle comment on current line
				comment_line = "gcc",

				-- Toggle comment on visual selection
				comment_visual = "gc",

				-- Define 'comment' textobject (like `dgc` - delete whole comment block)
				-- Works also in Visual mode if mapping differs from `comment_visual`
				textobject = "gc",
			},

			-- Hook functions to be executed at certain stage of commenting
			hooks = {
				-- Before successful commenting. Does nothing by default.
				pre = function() end,
				-- After successful commenting. Does nothing by default.
				post = function() end,
			},
		},
	},
}
