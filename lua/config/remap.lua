vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", {
	noremap = false,
	silent = false,
	desc = "Run tests in current file",
})

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and preserve cursor position" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half a page down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half a page up and center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match, centered and unfolded" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search match, centered and unfolded" })
vim.keymap.set("n", "=ap", "ma=ap'a", { desc = "Reindent paragraph and return to original line" })
vim.keymap.set("n", "<leader>zig", "<cmd>lsp restart<cr><cmd>e<cr>", { desc = "Restart LSP and reload file" })

-- greatest remap ever
for _, key in ipairs({ "<leader>p", "<leader>pp" }) do
	vim.keymap.set("x", key, [["_dP]], { desc = "Paste over selection without replacing register" })
end

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without replacing register" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode shortcut" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix entry and center cursor" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix entry and center cursor" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list entry and center cursor" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list entry and center cursor" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor throughout file" }
)

-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

-- vim.keymap.set("n", "<leader><leader>", function()
-- 	vim.cmd("so")
-- end, { desc = "Source current file" })

-- Added shortcuts
vim.keymap.set(
	"n",
	"<leader>rn",
	"<cmd>set relativenumber!<CR>",
	{ silent = true, desc = "Toggle relative line numbers" }
)

vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { silent = true, desc = "Open new tab" })
vim.keymap.set("n", "<leader>tW", "<cmd>tabclose<CR>", { silent = true, desc = "Close current tab" })
vim.keymap.set("n", "<leader>tw", function()
	local target = vim.api.nvim_get_current_tabpage()

	-- if there was only one tab, open an empty one so the original can be closed
	if #vim.api.nvim_list_tabpages() == 1 then
		vim.cmd("tabnew")
	end

	-- buffers shown in the tab being closed
	local to_close = {}
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(target)) do
		to_close[vim.api.nvim_win_get_buf(win)] = true
	end

	-- buffers still shown in other tabs must stay
	for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
		if tab ~= target then
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
				to_close[vim.api.nvim_win_get_buf(win)] = nil
			end
		end
	end

	vim.cmd("tabclose " .. vim.api.nvim_tabpage_get_number(target))

	local kept = {}
	for buf in pairs(to_close) do
		if vim.api.nvim_buf_is_valid(buf) then
			if vim.bo[buf].modified then
				table.insert(kept, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t"))
			else
				-- terminal buffers which have a running job need to be forced
				local force = vim.bo[buf].buftype == "terminal"
				pcall(vim.api.nvim_buf_delete, buf, { force = force })
			end
		end
	end

	if #kept > 0 then
		vim.notify("Kept buffers with unsaved changes: " .. table.concat(kept, ", "), vim.log.levels.WARN)
	end
end, { silent = true, desc = "Close tab and its unshared saved buffers" })
vim.keymap.set("n", "<leader>t[", "<cmd>tabmove -1<CR>", { silent = true, desc = "Move tab left" })
vim.keymap.set("n", "<leader>t]", "<cmd>tabmove +1<CR>", { silent = true, desc = "Move tab right" })
vim.keymap.set("n", "<leader>t{", "<cmd>tabmove 0<CR>", { silent = true, desc = "Move tab first" })
vim.keymap.set("n", "<leader>t}", "<cmd>tabmove $<CR>", { silent = true, desc = "Move tab last" })
vim.keymap.set("n", "<leader>t<Left>", "gT", { silent = true, desc = "Previous tab" })
vim.keymap.set("n", "<leader>t<Right>", "gt", { silent = true, desc = "Next tab" })

vim.keymap.set("n", "<leader><Right>", "<cmd>foldopen<CR>", { silent = true, desc = "Open fold under cursor" })
vim.keymap.set("n", "<leader>a<Right>", "zR", { silent = true, desc = "Open all folds" })
vim.keymap.set("n", "<leader><Left>", "<cmd>foldclose<CR>", { silent = true, desc = "Close fold under cursor" })
vim.keymap.set("n", "<leader>a<Left>", "zM", { silent = true, desc = "Close all folds" })

vim.keymap.set({ "n", "v", "o" }, "<Up>", "gk", { desc = "Move up one display line" })
vim.keymap.set({ "n", "v", "o" }, "<Down>", "gj", { desc = "Move down one display line" })
vim.keymap.set("i", "<Up>", "<C-o>gk", { desc = "Move up one display line" })
vim.keymap.set("i", "<Down>", "<C-o>gj", { desc = "Move down one display line" })

vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], {
	desc = "Exit terminal mode",
})

vim.keymap.set("n", "<leader>gg", function()
	local cmd
	for _, candidate in ipairs({ "gitui", "lazygit" }) do
		if vim.fn.executable(candidate) == 1 then
			cmd = candidate
			break
		end
	end

	if not cmd then
		vim.notify("Neither gitui nor lazygit was found in PATH", vim.log.levels.WARN)
		return
	end

	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2) - 1,
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
	})

	local opts = {
		on_exit = function()
			vim.schedule(function()
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_close(win, true)
				end
				if vim.api.nvim_buf_is_valid(buf) then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end)
		end,
	}

	if vim.fn.has("nvim-0.11") == 1 then
		opts.term = true
		vim.fn.jobstart(cmd, opts)
	else
		vim.fn.termopen(cmd, opts)
	end

	vim.cmd("startinsert")
end, { desc = "Git TUI (gitui / lazygit)" })
