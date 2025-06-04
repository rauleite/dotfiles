return {

  -- Configuração do lua_ls
  -- cmd = { "/home/raul/.local/share/nvim/mason/bin/lua-language-server" }, -- Ou caminho completo: vim.fn.stdpath("data") .. "/mason/bin/lua-language-server"
  cmd = { "lua-language-server" }, -- Ou caminho completo: vim.fn.stdpath("data") .. "/mason/bin/lua-language-server"
  filetypes = { "lua" },
  -- capabilities = require('cmp_nvim_lsp').default_capabilities(),          -- Adiciona suporte ao nvim-cmp
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "require" }, -- Declara variáveis globais
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Reconhece runtime do Neovim
        checkThirdParty = false,                           -- Ignora warnings em projetos de terceiros
      },
      telemetry = { enable = false },
    },
  },
}
