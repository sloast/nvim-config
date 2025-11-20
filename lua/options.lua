-- [nfnl] fnl/options.fnl
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.undofile = true
vim.opt.guicursor:append("t:block-blinkon0")
local function _1_()
  return vim.highlight.on_yank({higroup = "IncSearch", timeout = 250})
end
return vim.api.nvim_create_autocmd("TextYankPost", {group = vim.api.nvim_create_augroup("highlight_yank", {}), desc = "Highlight selection on yank", pattern = "*", callback = _1_})
