#!/bin/bash

# Habilitar modo de erro para sair em caso de falhas
set -e

# Obtém o nome do shell atual
CURRENT_SHELL=$(basename "$SHELL")

if [ -z "$IS_UPDATED" ] || [ "$IS_UPDATED" -eq 0 ]; then
  echo "update do sistema operacional..."
  sudo apt update
  IS_UPDATED=1
fi

if [ -z "$IS_UPGRADED" ] || [ "$IS_UPGRADED" -eq 0 ]; then
  echo "upgrade do sistema operacional..."
  sudo apt upgrade -y
  IS_UPGRADED=1
fi

# sudo apt install -y python3-full
sudo apt install -y python3 python3-venv python3-pip

# Verifica se pipx está instalado, senão instala
if ! command -v pipx &> /dev/null; then
    echo "pipx não encontrado globalmente. Usando virtual env..."
    # python3 -m venv /tmp/pipx_venv
    python3 -m venv ~/.venvs/pipx_venv
    # python3 -m venv ~/.local/share/pipx/venvs 
    #
    # /tmp/pipx_venv/bin/pip install pipx
    ~/.venvs/pipx_venv/bin/pip install pipx
    # ~/.local/share/pipx/venvs/bin/pip install pipx 
    # export PATH="$PATH:/tmp/pipx_venv/bin"

    # Garantido mais abaixo
    # export PATH="$PATH:~/.venvs/pipx_venv/bin"

    # export PATH="~/.local/share/pipx/venvs/bin"
    # pipx ensurepath
    # source ~/.bashrc
    echo "pipx instalado com sucesso!"
else
    echo "pipx já está instalado."
fi

# Atualizar o PATH para garantir que pipx esteja acessível
# export PATH="$HOME/.local/bin:$PATH"

export PATH="$PATH:~/.venvs/pipx_venv/bin"
export PATH="$HOME/.local/bin:$PATH"
pipx ensurepath

# Executa o comando `source` no arquivo correto
# case "$CURRENT_SHELL" in
#     bash)
#         source ~/.bashrc
#         ;;
#     zsh)
#         source ~/.zshrc
#         ;;
#     *)
#         echo "Shell não reconhecido: $CURRENT_SHELL. Nenhum arquivo carregado."
#         ;;
# esac
source ~/.bashrc
    
# Verifica se ansible já está instalado via pipx
if ! pipx list | grep -q "ansible"; then
    echo "Instalando Ansible via pipx..."
    # pipx install --include-deps ansible
    pipx install --include-deps ansible-core
    echo "Ansible instalado com sucesso!"
else
    echo "Ansible já está instalado."
fi

# Confirmar que ansible-playbook está disponível
if ! command -v ansible-playbook &> /dev/null; then
    echo "Erro: ansible-playbook não encontrado no PATH."
    echo "Verifique se o PATH está configurado corretamente."
    exit 1
else
    echo "Ansible está funcionando corretamente."
    ansible-playbook --version
fi

ansible-playbook -v setup.yml --extra-vars "is_upgraded=$IS_UPGRADED is_updated=$IS_UPDATED has_git=$HAS_GIT"

# script -q -c "zsh -i -c 'p10k configure'"
# zsh -i -c "source ~/.zshrc && p10k configure"

sudo apt autoremove -y
