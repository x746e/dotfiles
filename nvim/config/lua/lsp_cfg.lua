local lspconfig = require('lspconfig')

lspconfig.pyright.setup {
    cmd = {'run_in_venv', 'pyright-python-langserver', '--stdio'},

    on_attach = function(client, bufnr)
        -- TODO: Remove these after upgrading to, I assume, Neovim 0.11 
        vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
        vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
        vim.keymap.set('n', 'grr', vim.lsp.buf.references)
        vim.keymap.set('n', 'gri', vim.lsp.buf.implementation)
    end,
}
