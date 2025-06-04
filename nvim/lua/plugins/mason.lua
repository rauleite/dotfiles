return {
  -- Mason (gerenciador de LSPs/linters/formatters)
  {
    "williamboman/mason.nvim",
    -- "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Integração Mason com LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    -- "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "yamlls", "marksman" },
        -- automatic_installation = false,
      })
    end,
  },
}
