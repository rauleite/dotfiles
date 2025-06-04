return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- carrega o plugin ao entrar no modo de inserção
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        -- Se usar um snippet engine, defina a função de expansão aqui
        expand = function(args)
          -- Exemplo: require("luasnip").lsp_expand(args.body)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = 'luasnip' },
        { name = "path" },
      }),
    })
  end,
}
