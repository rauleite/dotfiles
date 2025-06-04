--https://github.com/artempyanykh/marksman
return {
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "markdown.mdx", "md", "mdx" },
  root_makers = { ".marksman.toml", ".git" },
  settings = {
    marksman = {
      -- enableSourceErrorDiagnostics = true,
    },
  },
}
