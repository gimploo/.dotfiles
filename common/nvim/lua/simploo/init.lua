vim.g.mapleader = ' '

vim.opt.exrc = true
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "line"
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.linebreak = true
vim.opt.swapfile = false
vim.opt.colorcolumn = "90"
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Keycode delay solution
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 50

vim.opt.mouse = "n" 
vim.opt.belloff = "all"

vim.opt.showtabline = 2

-- TextEdit might fail if hidden is not set.
vim.opt.hidden = true

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Give more space for displaying messages.
vim.opt.cmdheight = 2

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append { c = true }

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/lua/simploo/plugged')

    -- Themes
    Plug 'chriskempson/vim-tomorrow-theme'

    Plug 'Eric-Song-Nop/vim-glslx'
    Plug 'sakshamgupta05/vim-todo-highlight'
    Plug 'mbbill/undotree'
    Plug 'scrooloose/nerdcommenter'
    Plug('suan/vim-instant-markdown', {['for'] = 'markdown'})

    Plug('junegunn/fzf', { ['do'] = 'fzf#install()' })
    Plug 'junegunn/fzf.vim'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    -- LSP Support
    Plug 'neovim/nvim-lspconfig'      
    Plug 'williamboman/mason.nvim' 
    Plug 'williamboman/mason-lspconfig.nvim'

    -- Autocompletion
    Plug 'hrsh7th/nvim-cmp'    
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'L3MON4D3/LuaSnip'   

    Plug('VonHeikemen/lsp-zero.nvim', {['branch'] = 'v2.x'})

vim.call("plug#end")


vim.keymap.set("n", "<leader>s", ":Files<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = { "*.vs", "*.fs" },
    callback = function ()
        vim.cmd [[set ft=glslx]]
    end
})

vim.cmd.colorscheme("Tomorrow-Night-Bright")


-- Remaped the jumps bw splited windows 
vim.keymap.set("n", "<leader>h",  ":wincmd h<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>j",  ":wincmd j<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>k",  ":wincmd k<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>l",  ":wincmd l<CR>", { noremap = true, silent = true } )

-- Delete a buffer without closing the split window
vim.keymap.set( "n", "<leader>d", ":bd<CR>", { noremap = true, silent = true } )

-- Jumping between buffers
vim.keymap.set("n", "<leader>.",  ":bn<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>,",  ":bp<CR>", { noremap = true, silent = true } )

vim.keymap.set("n", "<leader>/",  ":NERDCommenterToggle<CR>", { noremap = true, silent = true } )

-- vimwiki
vim.keymap.set("n", "<leader>md",  ":InstantMarkdownPreview<CR>", { noremap = true, silent = true } )
--"markdown support
vim.g.vimwiki_ext2syntax = {
    ['.md'] = 'markdown',
    ['.markdown'] = 'markdown',
    ['.mdown'] = 'markdown' 
} 
vim.g.instant_markdown_autostart = 0 -- disable autostart 

-- Undotree
vim.keymap.set("n", "<leader>u",  ":UndotreeShow<CR>", { noremap = true, silent = true } )

-- Resizing window pane 
vim.keymap.set("n", "<leader>=",  ":vertical resize +5<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>-",  ":vertical resize -5<CR>", { noremap = true, silent = true } )

vim.cmd [[
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#righ_alt_sep = '|'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.colnr = ':'
let g:airline_symbols.colnr = ':'
let g:airline_symbols.crypt = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.spell = ''
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = ''

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.dirty=''
]]


local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
--https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    'tsserver',
    'eslint',
    'lua_ls',
    'bashls',
    'clangd',
    'tailwindcss'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),

})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach( function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
vim.diagnostic.config({
    virtual_text = true
})
--[[
lspconfig.clangd.setup{

    cmd = { 'clangd-15', '--header-insertion=never'},
    capabilities = capabilities,
    filetypes = { "c", "cpp" },

    on_attach = function(client) 
        -----------------------------------------------------------
        -- keymaps
        -----------------------------------------------------------
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
        --vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
        --vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
        vim.keymap.set("n", "g[", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "g]", vim.diagnostic.goto_prev, {buffer=0})
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})

    end,
    init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        clangdResourceDir = "",
        fallbackFlags = { 
            "-std=c11", 
            "-Wall",
            "-Wno-missing-braces",
            "-fno-exceptions"
        },
    },
}]]
