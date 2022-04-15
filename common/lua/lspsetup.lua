local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

--
-- Native LSP Setup
--

require 'lspconfig'.clangd.setup{
    capabilities = capabilities,
    filetypes = {"c", "cpp"},
    on_attach = function() 
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
        --vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
        --vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
        vim.keymap.set("n", "g[", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "g]", vim.diagnostic.goto_prev, {buffer=0})
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})
    end
}

--
-- Auto complete
--

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
       completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
      ['<C-Down>'] = cmp.mapping.scroll_docs(4),
      ['<C-.>'] = cmp.mapping.complete(),
      ['<C-/>'] = cmp.mapping.abort(),
      ['<Enter>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources( {
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    },{
      { name = 'buffer' },
    })
})

