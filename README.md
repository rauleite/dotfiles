# Dotfiles - Ambiente Dev Automatizado

![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?style=for-the-badge&logo=neovim&logoColor=white)
![tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)
![Zsh](https://img.shields.io/badge/zsh-%2320232a.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
```description
Configuração completa de ambiente de desenvolvimento com apenas um comando.
```

## Estrutura do Projeto

```structure
dotfiles/
├── nvim/          # Config do Neovim (submódulo)
├── tmux/          # Config do Tmux
└── zsh/           # Config do Zsh
├── bootstrap.sh   # Instalador automático
└── setup.yml      # Receita Ansible
```

Essa estrutura oferece modularidade, organização e fácil manutenção para suas configurações de ambiente. Aqui estão as principais vantagens:

✅ Submódulos para projetos independentes (nvim/): Permite gerenciar a configuração do Neovim separadamente, facilitando atualizações sem interferir nos outros dotfiles.

✅ Separação clara por ferramenta (tmux/, zsh/): Cada configuração tem seu próprio diretório, tornando fácil modificar e versionar individualmente.

✅ Automação eficiente (bootstrap.sh, setup.yml): O script bootstrap.sh pode ser usado para instalações rápidas, enquanto setup.yml (Ansible) facilita configurações declarativas.

✅ Facilidade de backup e migração: Como tudo está versionado, você pode clonar o repositório e restaurar o ambiente em segundos.

Isso torna o fluxo de trabalho mais organizado, portátil e escalável 🚀😃 

## Instalação Rápida

```bash
# Clone o repositório principal
git clone --recursive https://github.com/rauleite/dotfiles.git ~/dotfiles

# Atualize submódulos (Neovim)
cd ~/dotfiles
git submodule update --init --recursive

# Execute o bootstrap
chmod +x bootstrap.sh
./bootstrap.sh
```

```note
Todas as configurações podem ser editadas após instalação nos respectivos diretórios.
```

## Componentes Instalados

| Ferramenta       | Descrição                          |
|------------------|------------------------------------|
| Zsh + Plugins    | Shell avançado com autocompletar   |
| Neovim           | Editor com configuração completa   |
| Tmux             | Multiplexador de terminal          |
| Node.js (LTS)    | Runtime JavaScript via NVM         |
| Powerlevel10k    | Tema Zsh com fontes personalizadas |

## Troubleshooting

```issue 
Fontes não aparecendo
1. Verifique se as fontes estão em /usr/share/fonts
2. Execute: fc-cache -fv
```

## Instalação Manual (caso prefira ou precise)

| Componente       | Descrição                          | Link Oficial |
|------------------|------------------------------------|--------------|
| Zsh              | Shell avançado                     | [Zsh Official](https://www.zsh.org) |
| Oh My Zsh        | Framework para Zsh                 | [Oh My Zsh](https://ohmyz.sh) |
| Powerlevel10k    | Tema para Zsh                      | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) |
| Neovim           | Editor moderno                     | [Neovim](https://neovim.io) |
| Tmux             | Multiplexador de terminal          | [Tmux](https://github.com/tmux/tmux) |
| Node.js (NVM)    | Runtime JavaScript                 | [NVM](https://github.com/nvm-sh/nvm) |
| Ansible          | Automação de configurações         | [Ansible](https://docs.ansible.com) |
| Fontes Meslo     | Fontes para terminal               | [Meslo Fonts](https://github.com/romkatv/powerlevel10k#fonts) |

```>
Para instalação manual:
1. Use os links acima para baixar os componentes
2. Siga as instruções oficiais de cada projeto
3. Consulte o arquivo `setup.yml` para ver as versões recomendadas
```
