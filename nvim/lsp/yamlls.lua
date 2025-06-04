-- Função para determinar o diretório raiz
return {
  -- name = "yamlls",
  capabilities = require('cmp_nvim_lsp').default_capabilities(), -- Adiciona suporte ao nvim-cmp
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yml" },
  -- root_dir = get_root_dir(), -- Define a raiz do projeto
  on_attach = function(client, bufnr)
    print("YAML LSP attached!") -- Confirma que o LSP está ativo
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  single_file_support = true,
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      format = { enable = true },
      -- customTags = { "!fn", "!Ref", "!Sub" },
      -- Caso queira associar schemas a certos arquivos:
      schemas = {
        -- kubernetes = "/*.yaml", -- Adicionado schema padrão para Kubernetes
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",

      },
    },
  },
}
-- Inicia o LSP com a configuração definida
-- vim.lsp.start(config)
