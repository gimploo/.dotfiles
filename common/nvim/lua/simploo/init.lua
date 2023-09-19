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
vim.call('plug#begin', '~/.config/nvim_installed_plugins')

    -- Themes
    Plug 'chriskempson/vim-tomorrow-theme'

    Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

    Plug 'mbbill/undotree'

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

    Plug'numToStr/Comment.nvim'

vim.call("plug#end")

-- remapping ctrl v to <leader> v since wsl2 has it binded for paste
vim.keymap.set("n", "<leader>v", "<C-v>", { noremap = true, silent = true }) 

vim.keymap.set("n", "<leader>s", ":Files<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = { "*.vs", "*.fs" },
    callback = function ()
        vim.cmd [[set ft=glslx]]
    end
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = { "*.h" },
    callback = function ()
        vim.cmd [[set ft=c]]
    end
})

vim.cmd.colorscheme("Tomorrow-Night-Bright")

local function dim_inactive_windows()
    vim.api.nvim_create_autocmd("WinLeave", {
        callback = function ()
            vim.opt.cursorline = false
        end
    })
    vim.api.nvim_create_autocmd("WinEnter", {
        callback = function ()
            vim.opt.cursorline = true
        end
    })
    vim.cmd[[ hi NormalNC ctermbg=black ]]
end



-- Remaped the jumps bw splited windows 
vim.keymap.set("n", "<leader>h",  ":wincmd h<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>j",  ":wincmd j<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>k",  ":wincmd k<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>l",  ":wincmd l<CR>", { noremap = true, silent = true } )

-- Delete a buffer without closing the split window
vim.keymap.set("n", "<leader>d",":bp|bd # <CR>",{ noremap = true, silent = true } )

-- Vertical Split window
vim.keymap.set("n", "<leader>/",":vsp | wincmd l<CR>",{ noremap = true, silent = true } )


-- Jumping between buffers
vim.keymap.set("n", "<leader>.",  ":bn<CR>", { noremap = true, silent = true } )
vim.keymap.set("n", "<leader>,",  ":bp<CR>", { noremap = true, silent = true } )

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
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
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

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "bash", "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}



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
    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
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
    vim.keymap.set("n", "[g", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]g", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
vim.diagnostic.config({
    virtual_text = true
})

local lspconfig = require('lspconfig')

lspconfig.clangd.setup{

    cmd = { 'clangd', '--background-index', '--completion-style=detailed', '--header-insertion=never'},
    capabilities = capabilities,
    filetypes = { "c", "h" },
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
}

require('Comment').setup({
     ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
    },
    ---LHS of extra mappings
    ---DISABLED
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = false,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
})

dim_inactive_windows()
