require("config")

if vim.fn.has("nvim-0.12") == 0 then
	vim.notify(
		"[NVIM VERSION NOT SUPPORTED] Please install neovim version 0.12.",
		vim.log.levels.WARN,
		{ title = "config" }
	)
end
