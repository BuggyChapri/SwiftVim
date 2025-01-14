-- Packer Plugin Manager
vim.cmd([[packadd packer.nvim]])
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Plugin Manager
  use 'neovim/nvim-lspconfig' -- LSP
  use 'hrsh7th/nvim-cmp' -- Autocomplete
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'nvim-treesitter/nvim-treesitter' -- Syntax highlighting
  use 'nvim-lua/plenary.nvim' -- Dependency for many plugins
  use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'kyazdani42/nvim-tree.lua' -- File explorer
  use 'folke/tokyonight.nvim' -- Tokyo Night Colorscheme
  use 'EdenEast/nightfox.nvim' -- nightfox theme
  use {
    "neovim/nvim-lspconfig", -- Core LSP configuration
    "williamboman/mason.nvim", -- LSP installer
    "williamboman/mason-lspconfig.nvim", -- LSP integration with Mason
}
  use { "othree/html5.vim" } -- Adds better HTML support (useful for Svelte files)
  use { "evanleck/vim-svelte" } -- Svelte syntax highlighting and indentation

  use {
   "williamboman/mason.nvim",
    run = ":MasonUpdate" -- Automatically update Mason on install
}    
  use {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig" -- Dependency for LSP configuration
}

  use {
  'hrsh7th/nvim-cmp', -- Completion plugin
  requires = {
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer', -- Buffer completions
    'hrsh7th/cmp-path', -- Path completions
    'hrsh7th/cmp-cmdline', -- Command-line completions 'L3MON4D3/LuaSnip', -- Snippet engine
    'saadparwaiz1/cmp_luasnip' -- Snippet completions
  }

}

end)

vim.cmd([[
  augroup AutoSave
    autocmd!
    autocmd InsertLeave,TextChanged * silent! write
  augroup END
]])

local lspconfig = require('lspconfig')

-- Python LSP
lspconfig.pyright.setup{
  on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  end
}


-- Set the tab size to 4 spaces
vim.opt.tabstop = 4          -- Number of spaces that a tab character represents
vim.opt.shiftwidth = 4       -- Number of spaces for each indentation level
vim.opt.expandtab = true     -- Convert tabs to spaces

vim.opt.smartindent = true      -- Enable smart indentation
vim.opt.autoindent = true       -- Automatically indent new lines

-- Set up nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- Snippets { name = 'buffer' },
    { name = 'path' },
  })
})

-- Use buffer source for `/` and `?` (searches)
cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
-- Use path and cmdline source for `:`
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
})

-- Ensure Svelte is supported
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").svelte.setup {
  capabilities = capabilities,
}

vim.cmd [[
  autocmd BufRead,BufNewFile *.svelte set filetype=svelte
]]

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  auto_close          = true,
  open_on_tab         = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  update_cwd          = true,
  view = {
    width = 30,
    side = 'left',
    auto_resize = true,
  },
}

-- Keybindings vim.g.mapleader = " " -- Space as leader key
vim.keymap.set('n', '<C-t>', ':Telescope find_files<CR>') -- File search
vim.keymap.set('n', '<C-g>', ':Telescope live_grep<CR>') -- Text search
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- LSP Settings
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{} -- Python LSP
lspconfig.tsserver.setup{} -- TypeScript/JavaScript LSP Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "python", "javascript", "html", "css" },
  highlight = { enable = true },
}

-- Autocomplete
local cmp = require('cmp')
cmp.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

-- Mason setup for installing LSPs
require("mason").setup()
require("mason-lspconfig").setup()

-- LSP configuration for Svelte
require("lspconfig").svelte.setup {}


-- Statusline
require('lualine').setup()

-- File Explorer
require('nvim-tree').setup()

vim.cmd[[colorscheme nightfox]]
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "pyright", "svelte", "tsserver" } -- Add LSPs you need
}

-- Enable relative line numbers
vim.o.relativenumber = true
vim.o.number = true -- Enable absolute line number for the current line

-- Optional: Enable line numbers only in normal mode for a cleaner look
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.wo.relativenumber = false
  end
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function() vim.wo.relativenumber = true
  end
})

-- Save file with Ctrl + S (works in normal mode)
-- Save file with Ctrl + S (works in normal mode)
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- Make a new file with Ctrl + N vim.api.nvim_set_keymap('n', '<C-n>', ':enew<CR>', { noremap = true, silent = true })

-- Rename current file with F2
vim.api.nvim_set_keymap('n', '<F2>', ':file %:h/NEW_NAME<CR>', { noremap = true, silent = true })

-- Split window horizontally with Ctrl + H
vim.api.nvim_set_keymap('n', '<C-h>', ':split<CR>', { noremap = true, silent = true })

-- Split window vertically with Ctrl + Shift + V
vim.api.nvim_set_keymap('n', '<C-S-v>', ':vsplit<CR>', { noremap = true, silent = true })

-- Close the current window with Ctrl + Shift + X
vim.api.nvim_set_keymap('n', '<C-S-x>', ':q<CR>', { noremap = true, silent = true })

-- Cut with Ctrl + X in Insert Mode
vim.api.nvim_set_keymap('i', '<C-x>', '<Esc>dwi', { noremap = true, silent = true })

-- Paste with Ctrl + V in Insert Mode
vim.api.nvim_set_keymap('i', '<C-v>', '<Esc>P', { noremap = true, silent = true })

-- Open a new tab with Ctrl + T
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true })

-- Switch to next tab with Ctrl + T
vim.api.nvim_set_keymap('n', '<C-T>', ':tabnext<CR>', { noremap = true, silent = true })

-- Switch to previous tab with Ctrl + Shift + Tab
vim.api.nvim_set_keymap('n', '<C-S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })

-- Close current tab with Ctrl + W
vim.api.nvim_set_keymap('n', '<C-w>', ':tabclose<CR>', { noremap = true, silent = true })

-- Go to next word with Ctrl + Right Arrow
vim.api.nvim_set_keymap('n', '<C-Right>', 'w', { noremap = true, silent = true })

-- Go to previous word with Ctrl + Left Arrow
vim.api.nvim_set_keymap('n', '<C-Left>', 'b', { noremap = true, silent = true })

-- Start searching with '/'
vim.api.nvim_set_keymap('n', '/', '/', { noremap = true, silent = true })

-- Go to next search result with 'n'
vim.api.nvim_set_keymap('n', 'n', 'n', { noremap = true, silent = true })

-- Go to previous search result with 'N'
vim.api.nvim_set_keymap('n', 'N', 'N', { noremap = true, silent = true })

-- Open file with Ctrl + O
vim.api.nvim_set_keymap('n', '<C-o>', ':e<Space>', { noremap = true, silent = true })

-- Use Tab and Shift-Tab for indenting
vim.api.nvim_set_keymap('i', '<Tab>', '<C-T>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-D>', { noremap = true, silent = true })


-- Switch between windows with Ctrl + h/j/k/l
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
-- Set transparent background for floating windows
vim.api.nvim_exec([[
augroup TransparentBackground
  autocmd!
  autocmd ColorScheme * highlight NormalFloat ctermbg=none guibg=none
  autocmd ColorScheme * highlight FloatBorder ctermbg=none guibg=none
augroup END
]], false)



-- Enable Transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Set cursor shapes
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.g.neovide_cursor_vfx_mode = "railgun" -- Adds cool cursor effects

