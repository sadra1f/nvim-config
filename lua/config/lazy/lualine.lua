return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local last_buf = nil
		local last_line = nil
		local last_result = ""

		local blame = function()
			local current_buffer = vim.api.nvim_get_current_buf()
			local current_line = vim.fn.line(".")

			-- Return cached result if nothing changed
			if current_buffer == last_buf and current_line == last_line then
				return last_result
			end

			last_buf = current_buffer
			last_line = current_line

			local file_path = vim.fn.expand("%:p")
			if file_path == "" then
				last_result = ""
				return last_result
			end

			local cmd = string.format(
				"git blame --line-porcelain -L %d,%d %s 2>/dev/null",
				current_line,
				current_line,
				vim.fn.shellescape(file_path)
			)

			local output = vim.fn.systemlist(cmd)
			if vim.v.shell_error ~= 0 or not output then
				last_result = ""
				return last_result
			end

			local author, author_time

			for _, l in ipairs(output) do
				if vim.startswith(l, "author ") then
					author = l:sub(8)
				elseif vim.startswith(l, "author-time ") then
					author_time = tonumber(l:sub(13))
				end
			end

			if not author or not author_time then
				last_result = ""
				return last_result
			end

			local date = os.date("%Y-%m-%d", author_time)
			last_result = string.format("%s %s", author, date)

			return last_result
		end

		require("lualine").setup({
			options = {
				icons_enabled = false,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"filename",
						on_click = function(n, mouse_button, modifiers)
							if mouse_button == "l" then -- left click
								vim.cmd("Telescope find_files")
							end
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						on_click = function(n, mouse_button, modifiers)
							if mouse_button == "l" then -- left click
								vim.cmd("Telescope git_branches")
							end
						end,
					},
					{
						"diff",
						on_click = function(n, mouse_button, modifiers)
							if mouse_button == "l" then -- left click
								vim.cmd("Telescope git_status")
							end
						end,
					},
					{
						"diagnostics",
						on_click = function(n, mouse_button, modifiers)
							if mouse_button == "l" then -- left click
								vim.cmd("Trouble workspace toggle")
							end
						end,
					},
				},
				lualine_c = {
					{
						blame,
						on_click = function(n, mouse_button, modifiers)
							if mouse_button == "l" then -- left click
								vim.cmd("Git blame")
							end
						end,
					},
				},
				lualine_x = {
					"encoding",
					"fileformat",
					{
						"filetype",
						on_click = function(n, mouse_button, modifiers)
							if mouse_button == "l" then -- left click
								vim.cmd("Telescope filetypes")
							end
						end,
					},
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
