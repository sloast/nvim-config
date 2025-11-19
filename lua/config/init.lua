local config_path = vim.fn.stdpath("config") .. "/lua/config"
for _, file in ipairs(vim.fn.readdir(config_path)) do
	if file:match("%.lua$") and file ~= "init.lua" then
		require("config." .. file:gsub("%.lua$", ""))
	end
end
