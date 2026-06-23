return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
		build = ":TSUpdate",
		lazy = false,
		init = function()
			local treesitter = require("nvim-treesitter")
			local parsers = {
				"bash",
				"c",
				"cpp",
				"comment",
				"css",
				"editorconfig",
				"git_config",
				"gitignore",
				"go",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"rust",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"xml",
				"yaml",
			}

			local group = vim.api.nvim_create_augroup("ConfigTreesitter", { clear = true })

			local function installCLI()
				if vim.fn.executable("tree-sitter") == 0 then
					local registry = require("mason-registry")
					local pkg = registry.get_package("tree-sitter-cli")

					if not pkg:is_installed() then
						pkg:install()
					end
				end
			end

			local function startTreesitter(bufnr, parser_name)
				-- syntax highlighting, provided by Neovim
				vim.treesitter.start(bufnr, parser_name)
				-- folds, provided by Neovim
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo.foldmethod = "expr"
				-- indentation, provided by nvim-treesitter
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "VeryLazy",
				once = true,
				callback = function()
					installCLI()
					treesitter.install(parsers)
				end,
			})

			vim.api.nvim_create_autocmd({ "FileType" }, {
				group = group,
				callback = function(event)
					local bufnr = event.buf
					local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

					if filetype == "" then
						return
					end

					if vim.tbl_contains(parsers, filetype) then
						return
					end

					local parser_name = vim.treesitter.language.get_lang(filetype)
					if not parser_name then
						return
					end

					local parser_configs = require("nvim-treesitter.parsers")
					if not parser_configs[parser_name] then
						return
					end

					local parser_installed = pcall(vim.treesitter.get_installed, bufnr, parser_name)

					if not parser_installed then
						installCLI()
						treesitter.install({ parser_name }):await(function()
							startTreesitter(bufnr, parser_name)
						end)
					else
						startTreesitter(bufnr, parser_name)
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			local tscontext = require("treesitter-context")

			tscontext.setup({
				enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})

			vim.keymap.set("n", "<leader>ctx", function()
				tscontext.toggle()
			end)
		end,
	},
}
