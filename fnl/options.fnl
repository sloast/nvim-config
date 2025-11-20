(macro opt [name val]
  `(set ,(sym (.. :vim.opt. (tostring name))) ,val))

;; -- Tabs --
(opt :shiftwidth 4)
(opt :tabstop 4)
(opt :smartindent true)
(opt :autoindent true)

;; -- Line numbers --
(opt :number true)
(opt :relativenumber true)
(opt :numberwidth 2)

;; -- Folding --
(opt :foldmethod :expr)
(opt :foldexpr "nvim_treesitter#foldexpr()")
(opt :foldlevel 99)
(opt :foldlevelstart 99)

(opt :undofile true)

;; -- Cursor --
(vim.opt.guicursor:append "t:block-blinkon0")

;; -- Highlight on Yank --
(vim.api.nvim_create_autocmd :TextYankPost
                             {:group (vim.api.nvim_create_augroup :highlight_yank
                                                                  {})
                              :desc "Highlight selection on yank"
                              :pattern "*"
                              :callback (fn []
                                          (vim.highlight.on_yank {:higroup :IncSearch
                                                                  :timeout 250}))})

