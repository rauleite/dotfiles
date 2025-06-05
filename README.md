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

```table
| Ferramenta       | Descrição                          |
|------------------|------------------------------------|
| Zsh + Plugins    | Shell avançado com autocompletar   |
| Neovim           | Editor com configuração completa   |
| Tmux             | Multiplexador de terminal          |
| Node.js (LTS)    | Runtime JavaScript via NVM         |
| Powerlevel10k    | Tema Zsh com fontes personalizadas |
```

## Troubleshooting

```issue 
Fontes não aparecendo
1. Verifique se as fontes estão em /usr/share/fonts
2. Execute: fc-cache -fv
```

