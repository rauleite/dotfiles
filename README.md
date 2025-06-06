# Dotfiles - Ambiente Dev Automatizado e Sincronizado

![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?style=for-the-badge&logo=neovim&logoColor=white)
![tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)
![Zsh](https://img.shields.io/badge/zsh-%2320232a.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

Configuração completa de ambiente de desenvolvimento com apenas um comando.

*Embora seja um mero bootstrap pós-instalação do SO, ele é baseado em meus requisitos essenciais míminos, portanto, é opnativo, sendo o SO o Ubuntu e suas ferramentas que considero básicas.*

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

✅ **Submódulos para projetos independentes `(nvim/)`:** Permite gerenciar a configuração do Neovim separadamente, facilitando atualizações sem interferir nos outros dotfiles.

✅ **Separação clara por ferramenta `(tmux/, zsh/)`:** Cada configuração tem seu próprio diretório, tornando fácil modificar e versionar individualmente.

✅ **Automação eficiente `(bootstrap.sh, setup.yml)`:** O script bootstrap.sh pode ser usado para instalações rápidas, enquanto setup.yml (Ansible) facilita configurações declarativas.

✅ **Facilidade de backup e migração:** Como tudo está versionado, você pode clonar o repositório e restaurar o ambiente em segundos.

Isso torna o fluxo de trabalho mais organizado, portátil e escalável 🚀😃 

## Instalação

### Instalação rápida

```bash
curl -fsSL https://raw.githubusercontent.com/rauleite/dotfiles/main/install.sh | bash
```
### Instalação a partir do repositório

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

## Componentes Instalados

| Ferramenta       | Descrição                          |
|------------------|------------------------------------|
| Zsh + Plugins    | Shell avançado com autocompletar   |
| Neovim           | Editor com configuração completa   |
| Tmux             | Multiplexador de terminal          |
| Node.js (LTS)    | Runtime JavaScript via NVM         |
| Powerlevel10k    | Tema Zsh com fontes personalizadas |

## Informações

### `~/dotfiles`

Neste diretório residem os arquivos de configuração linkados aos seus respectivos paths corretos.

Lembre que, por serem links, suas modificações podem ser feita de maneira bidirecional (origem ou destino do link). Mas você vai optar por trabalhar como faria normalmente, fazendo modificações dentro de seus paths 'naturais', que são os **destinos** dos links:

| **Origem**                       | **Destino \[x\]**               | **Descrição**                  |
|----------------------------------|---------------------------|--------------------------------|
| `~/dotfiles/zsh/.p10k.zsh`       | `~/.p10k.zsh`             | Configuração do Powerlevel10k  |
| `~/dotfiles/zsh/.zshrc`          | `~/.zshrc`                | Arquivo de configuração do Zsh |
| `~/dotfiles/nvim`                | `~/.config/nvim`          | Configuração do Neovim         |
| `~/dotfiles/tmux/.tmux.conf`     | `~/.tmux.conf`            | Configuração do Tmux           |

### Shell e variáveis de ambiente

- o `~/.profile` é o local ideal para você incluir as configurações **tanto do bash, quanto do *zsh***.
- o `~/.bashrc` continua sendo específico para *bash*, e o `~/.zshrc` (e o `~/.zprofile`) para *zsh*.

### Instalações e configurações sob demanda

Algumas *tasks* do `setup.yml` estão com *tags*, permitindo que sejam apenas elas executadas, caso você precise por algum motivo. Como por exemplo:

```bash
ansible-playbook setup.yml --tags tmux_conf
```
Este comando do exemplo executará somente tasks *relacionadas* às instalações de plugins e configurações do tmux

<a name="instalacao-neovim"></a>

#### Instalação (e atualização) do binário do Neovim (obs.: versão LTS, sempre)

Em `setup.yml` altere para a var *nvm_version* desejada (como por ex. *nvm_version: "v0.40.3"*) e execute:

```bash
ansible-playbook setup.yml --tags neovim_bin
```

#### Instalação dos pacotes que são feitos via *pipx* (pip/python)

```bash
ansible-playbook setup.yml --tags pipx_packages
```
#### Histórico de comandos (`history`) unificado (entre *bash* e *zsh*)

Compartilhamento de histórico entre sessões das distintas shells: bin e zsh. Centralizado no arquivo *~/.history*

```bash
ansible-playbook setup.yml --tags unify_histories
```

*No entanto, todas as tasks (com ou sem *tags*) já são executadas durante a instação geral (bootstrap)*

### Atualizações de pacotes instalados

#### Atualizando pacotes que são instalados via pipx do python

``` bash
# caso queira saber quais são os pacotes instalados através do pipx
pipx list

# checar lista de pacotes desatualizados
piplexed list --outdated

# atualização sob demanda
pipx upgrade nome_do_pacote

# atualização de todos
pipx upgrade-all
```

#### Atualizando o binário do Neovim 

[Seção de instalação e atualização do Neovim](#instalacao-neovim)

## Troubleshooting

O [NVM](https://github.com/nvm-sh/nvm?tab=readme-ov-file#manual-install) faz uma [bagucinha quando encontra bash e zsh](https://github.com/nvm-sh/nvm?tab=readme-ov-file#troubleshooting-on-macos) no mesmo ambiente.

1. recorte (copie e delete) o bloco do NVM presente no final do arquivo `~/.bashrc`
2. copie esta referência (do ~/.bashrc) no seu `~/.profile`
3. delete o bloco presente no `~/.zshrc`

### Se um arquivo ou link for apagado [ou quebrado] acidentalmente do `~/dotfiles/`

- Calma, eles estão, idealmente, sincronizados no Github. Esse é todo o espírito da coisa. Provavelmente bastará dar um `git pull` e/ou re-linkar, ou algo equivalente. Na dúvida, peça ajuda.

## Instalação Manual (caso prefira ou precise)

| Componente       | Descrição                          | Link Oficial |
|------------------|------------------------------------|--------------|
| Zsh              | Shell avançado                     | [Zsh Official](https://www.zsh.org) |
| Oh My Zsh        | Framework para Zsh                 | [Oh My Zsh](https://ohmyz.sh) |
| Powerlevel10k    | Tema para Zsh                      | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) |
| Neovim           | Editor moderno                     | [Neovim](https://neovim.io) |
| Tmux             | Multiplexador de terminal          | [Tmux](https://github.com/tmux/tmux) |
| Node.js (NVM)    | Runtime JavaScript                 | [NVM](https://github.com/nvm-sh/nvm) |
| Fontes Meslo     | Fontes para terminal               | [Meslo Fonts](https://github.com/romkatv/powerlevel10k#fonts) |

