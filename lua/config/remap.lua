vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>lsp restart<cr><cmd>e<cr>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
--
-- vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
--
-- vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a')
--
-- vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj')
--
-- vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i')

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- Added shortcuts
vim.keymap.set("n", "<leader>rn", "<cmd>set relativenumber<CR>", { silent = true })
vim.keymap.set("n", "<leader>Rn", "<cmd>set norelativenumber<CR>", { silent = true })

vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { silent = true })
vim.keymap.set("n", "<leader>tW", "<cmd>tabclose<CR>", { silent = true })
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
end, { silent = true })
vim.keymap.set("n", "<leader>t>", "<cmd>tabmove +1<CR>", { silent = true })
vim.keymap.set("n", "<leader>t<", "<cmd>tabmove -1<CR>", { silent = true })

vim.keymap.set("n", "<leader>>", "<cmd>foldopen<CR>", { silent = true })
vim.keymap.set("n", "<leader>a>", "zR", { silent = true })
vim.keymap.set("n", "<leader><", "<cmd>foldclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>a<", "zM", { silent = true })

vim.keymap.set({ "n", "v", "o" }, "<Up>", "gk")
vim.keymap.set({ "n", "v", "o" }, "<Down>", "gj")
vim.keymap.set("i", "<Up>", "<C-o>gk")
vim.keymap.set("i", "<Down>", "<C-o>gj")

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
