return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local blame = function()
			local file_path = vim.fn.expand("%:p")
			local current_line = vim.fn.line(".")

			return vim.fn.system(
				"git blame -L "
					.. current_line
					.. ","
					.. current_line
					.. " "
					.. file_path
					.. " 2>/dev/null"
					.. " | cut -d ' ' -f 2-4"
					.. " | cut -c 2-"
					.. " | tr -d '\n'"
			)

			-- return vim.fn.system(
			-- 	"git blame -L "
			-- 		.. current_line
			-- 		.. ","
			-- 		.. current_line
			-- 		.. " "
			-- 		.. file_path
			-- 		.. " 2>/dev/null"
			-- 		.. " | cut -c 2-"
			-- 		.. " | cut -d ' ' -f -4"
			-- 		.. " | sed 's/ (/: /g'"
			-- 		.. " | tr -d '\n'"
			-- )
		end

		require("lualine").setup({
			options = {
				icons_enabled = false,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "filename" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { blame },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
