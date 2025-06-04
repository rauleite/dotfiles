-- Exige que o shellcheck esteja instalado no computador:
-- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies
return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'bash', 'sh', 'zsh' },
  settings = {
    bash = {
      -- enableSourceErrorDiagnostics = true,
    },
  },
}
