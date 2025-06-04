return {
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      "folke/snacks.nvim", -- substitua "username" pelo dono correto do repositório de snacks.nvim
    },
    config = true,
    opts = {
      lsp = {
        filetypes = { "dart" },
        -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
        root_makers = { "pubspec.yaml" },
        -- on_attach = on_attach,
        settings = {
          -- dart = {
          completeFunctionCalls = true,
          showTodos = false,
          -- renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
          includeDependenciesInWorkspaceSymbol = false,
          lineLength = 70
          -- }
        }
      }
    }
  }
}
