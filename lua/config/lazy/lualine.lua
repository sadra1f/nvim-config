return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local last_buf = nil
		local last_line = nil
		local last_result = ""
		local current_job = nil

		local blame = function()
			local current_buffer = vim.api.nvim_get_current_buf()
			local current_line = vim.fn.line(".")

			if current_buffer == last_buf and current_line == last_line then
				return last_result
			end
			last_buf, last_line = current_buffer, current_line

			local file_path = vim.fn.expand("%:p")
			if vim.bo.buftype ~= "" or file_path == "" then
				return last_result
			end

			if current_job and not current_job:is_closing() then
				current_job:kill(15) -- SIGTERM
			end

			local this_job
			this_job = vim.system(
				{ "git", "blame", "--line-porcelain", "-L", current_line .. "," .. current_line, file_path },
				{ text = true },
				function(obj)
					if current_job ~= this_job or obj.code ~= 0 or not obj.stdout then
						return
					end

					local author, author_time

					for l in obj.stdout:gmatch("[^\r\n]+") do
						if vim.startswith(l, "author ") then
							author = l:sub(8)
						elseif vim.startswith(l, "author-time ") then
							author_time = tonumber(l:sub(13))
						end
					end

					if author and author_time then
						last_result = string.format("%s %s", author, os.date("%Y-%m-%d", author_time))
						vim.schedule(function()
							require("lualine").refresh()
						end)
					end
				end
			)

			current_job = this_job

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
