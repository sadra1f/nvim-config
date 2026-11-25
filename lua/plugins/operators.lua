return {
	{
		"nvim-mini/mini.operators",
		version = "v0.18.*",
		keys = {
			{
				"<leader>S",
				"gss",
				remap = true,
				mode = { "n" },
				desc = "Sort line (Use this over gss)",
			},
			{
				"<leader>S",
				"gs",
				remap = true,
				mode = { "x" },
				desc = "Sort (Use this over gs)",
			},
			{
				"<leader>=",
				"g==",
				remap = true,
				mode = { "n" },
				desc = "Evaluate line (Use this over g==)",
			},
			{
				"<leader>=",
				"g=",
				remap = true,
				mode = { "x" },
				desc = "Evaluate (Use this over g=)",
			},
		},
		opts = {
			-- Evaluate text and replace with output
			evaluate = {
				prefix = "g=",

				-- Function which does the evaluation
				func = nil,
			},

			-- Exchange text regions
			exchange = {
				-- prefix = "gx",
				prefix = "",

				-- Whether to reindent new text to match previous indent
				reindent_linewise = true,
			},

			-- Multiply (duplicate) text
			multiply = {
				-- prefix = "gm",
				prefix = "",

				-- Function which can modify text before multiplying
				func = nil,
			},

			-- Replace text with register
			replace = {
				-- prefix = "gr",
				prefix = "gr",

				-- Whether to reindent new text to match previous indent
				reindent_linewise = true,
			},

			-- Sort text
			sort = {
				prefix = "gs",

				-- Function which does the sort
				func = nil,
			},
		},
	},
}
