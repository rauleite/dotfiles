#!/bin/bash

# Habilitar modo de erro para sair em caso de falhas
set -e

echo "update e upgrade do sistema operacional..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3-full

# Verifica se pipx está instalado, senão instala
if ! command -v pipx &> /dev/null; then
    echo "pipx não encontrado globalmente. Usanto virtual env..."
    python3 -m venv /tmp/pipx_venv
    /tmp/pipx_venv/bin/pip install pipx
    export PATH="$PATH:/tmp/pipx_venv/bin"
    pipx ensurepath
    source ~/.bashrc
    # python3 -m pip install --user pipx
    # python3 -m pipx ensurepath
    echo "pipx instalado com sucesso!"
else
    echo "pipx já está instalado."
fi

# Atualizar o PATH para garantir que pipx esteja acessível
export PATH="$HOME/.local/bin:$PATH"

# Verifica se ansible já está instalado via pipx
if ! pipx list | grep -q "ansible"; then
    echo "Instalando Ansible via pipx..."
    pipx install --include-deps ansible
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
whoami
ansible-playbook -vv setup.yml

echo "Configuração concluída! 🚀"
