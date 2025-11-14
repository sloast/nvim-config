return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'everforest',
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 
          'filename',
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
          }
        },
        lualine_x = {
          {
            -- Show LSP server name
            function()
              local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
              if #buf_clients == 0 then
                return "LSP Inactive"
              end
              return buf_clients[1].name
            end,
            icon = ' ',
          },
          'encoding',
          'fileformat',
          'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    })
  end
}
