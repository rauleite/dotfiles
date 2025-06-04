local wk = require("which-key") -- Certifique-se de que which-key.nvim está instalado

wk.add({
  { "<leader>d",  group = "Diagnóstico" }, -- Define grupo para diagnósticos
  { "<leader>df", vim.diagnostic.open_float, desc = "Mostrar diagnóstico flutuante" },
  {
    "<leader>dc",
    function()
      local cursor_pos = vim.api.nvim_win_get_cursor(0)                       -- Obtém posição do cursor
      local diagnostics = vim.diagnostic.get(0, { lnum = cursor_pos[1] - 1 }) -- Pega erro da linha atual

      if #diagnostics > 0 then
        local msg = diagnostics[1].message -- Pega a mensagem do primeiro diagnóstico na linha
        vim.fn.setreg("+", msg)            -- Copia para o clipboard
        print("Copiado para clipboard: " .. msg)
      else
        print("Nenhum diagnóstico nesta linha.")
      end
    end,
    desc = "Copiar diagnóstico atual para o clipboard"
  },
  -- LSP
  { "<leader>l",  group = "LSP" },

  { "<leader>ld", vim.lsp.buf.definition,      desc = "Ir para definição" },
  { "<leader>lr", vim.lsp.buf.references,      desc = "Mostrar referências" },
  { "<leader>lR", vim.lsp.buf.rename,          desc = "Renomear símbolo" },
  { "<leader>la", vim.lsp.buf.code_action,     desc = "Ações de código" },
  { "<leader>li", vim.lsp.buf.implementation,  desc = "Ir para implementação" },
  { "<leader>lt", vim.lsp.buf.type_definition, desc = "Definição do tipo" },
  -- { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Formatar código" },

  { "<leader>le", vim.diagnostic.open_float,   desc = "Mostrar diagnóstico flutuante" },
  { "<leader>ln", vim.diagnostic.goto_next,    desc = "Ir para próximo erro" },
  { "<leader>lp", vim.diagnostic.goto_prev,    desc = "Ir para erro anterior" },

  {
    -- Formata se o client lsp tiver essa função
    "<leader>lf",
    function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if clients[1] and clients[1]:supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ async = true })
      else
        vim.notify("Não há LSP ativo com suporte para formatação", vim.log.levels.WARN)
      end
    end,
    desc = "Formatar buffer com LSP",
  },

})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', '<leader>l', function()
      vim.lsp.buf.format({ async = true })
    end, {
      buffer = args.buf
    })
  end
})
