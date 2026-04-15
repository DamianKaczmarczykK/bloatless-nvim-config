-- Require:
-- - nvim 0.12
-- - fzf, rg, fd
-- - LSPs (gopls, rust_analyzer etc.) - of course, if you need them

vim.opt.number = true -- show number 
vim.opt.relativenumber = true -- relative number
vim.opt.wrap = true -- wrap lines
vim.opt.tabstop = 2 -- spaces for tab
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80

vim.opt.swapfile = false -- is swapfile enabled?
vim.g.mapleader = ' ' -- key for leader
vim.opt.mouse = "a" -- enable mouse support

vim.opt.signcolumn = 'yes' -- keep signcolumn
vim.opt.winborder = 'rounded'
vim.schedule(function() -- synchronize with os clipboard 
		vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.inccommand = 'split' -- preview substitutions live, as you type
vim.opt.cursorline = true -- highlight background of cursor line
vim.opt.list = true -- show whitespaces using below characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", }
vim.opt.hlsearch = true -- highlight search
vim.opt.breakindent = true -- break indent

-- external plugins
vim.pack.add {
  { src = 'https://github.com/neovim/nvim-lspconfig' }, -- default LSP configs
  { src = 'https://github.com/ibhagwan/fzf-lua' }, -- fuzzy search engine
  { src = 'https://github.com/vague-theme/vague.nvim' }, -- coloscheme
}

require('vim._core.ui2').enable({}) -- enable new UI
local fzf_lua_plugin = require('fzf-lua') -- init fzf-lua plugin, populating `FzfLua`
fzf_lua_plugin.register_ui_select() -- register vim.ui.select backend

vim.cmd.colorscheme('vague') -- colorscheme

-- LSPs config 
-- NOTE: make sure below LSPs are installed
vim.opt.completeopt = 'menu,menuone,noselect,popup' -- ensures the menu appears even for a single match and uses the native popup window.
vim.opt.autocomplete = true -- enables the overall completion feature.
vim.lsp.config('lua_ls', { settings = { Lua = { diagnostics = { globals = { "vim" }}}} })
vim.lsp.config('tsserver', { cmd = { 'typescript-language-server', '--stdio' }, })
vim.lsp.enable({'lua_ls', 'gopls', 'rust_analyzer', 'ols', 'tsserver'}) -- enabled LSPs

-- autocomplete for lsp
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_completion', { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    if not client_id then
      return
    end

    local client = vim.lsp.get_client_by_id(client_id)
    if client and client:supports_method('textDocument/completion') then
      -- enable native LSP completion for this client + buffer
      vim.lsp.completion.enable(true, client_id, args.buf, {
        autotrigger = true,   -- auto-show menu as you type (recommended)
        -- you can also set { autotrigger = false } and trigger manually with <C-x><C-o>
      })
    end
  end,
})

-- shortcuts (mode, keys, function_to_call, description)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message' })
vim.keymap.set('n', '<leader>sf', fzf_lua_plugin.files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>sw', fzf_lua_plugin.live_grep, { desc = 'Search word' })
vim.keymap.set('n', '<leader>sd', fzf_lua_plugin.lsp_document_diagnostics, { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format file' })
vim.keymap.set('n', 'gra', fzf_lua_plugin.lsp_code_actions, { desc = 'Code actions' }) -- remapped to use fzf-lua
vim.keymap.set('n', 'grr', fzf_lua_plugin.lsp_references, { desc = 'Goto references' }) -- remapped to use fzf-lua
vim.keymap.set('n', 'gri', fzf_lua_plugin.lsp_implementations, { desc = 'Goto implementations' }) -- remapped to use fzf-lua
vim.keymap.set('n', 'grt', fzf_lua_plugin.lsp_typedefs, { desc = 'Goto typedefinitions' }) -- remapped to use fzf-lua
-- TODO: maybe add treesitter, autoformat
