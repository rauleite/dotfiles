return {
  -- Seus outros plugins aqui...

  -- Adicione o Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- Configuração opcional do tema (se desejar)
      require("catppuccin").setup({
        -- suas configurações do tema aqui
      })
      -- vim.cmd.colorscheme("catppuccin")
    end
  }
}
