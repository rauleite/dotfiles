#!/bin/bash
# install.sh - Instalação automática dos dotfiles

# set -e  # Sai imediatamente se algum comando falhar

echo "🔄 Atualizando ubuntu..."
sudo apt update && sudo apt upgrade -y
export IS_UPDATED=1
export IS_UPGRADED=1

echo "🔄 Instalando Git"
sudo apt install git
export HAS_GIT=1

# Clone o repositório (se ainda não existir)
if [ ! -d ~/dotfiles ]; then
  echo "⏬ Clonando repositório 'dotfiles'..."
  git clone --recursive https://github.com/rauleite/dotfiles.git ~/dotfiles
fi

# Navega para o diretório
cd ~/dotfiles

# Atualiza submódulos
echo "🔄 Atualizando submódulos..."
git submodule update --init --recursive
git submodule update --remote --merge
git submodule foreach git checkout main
#
# Executa o bootstrap
echo "🚀 Executando configuração..."
chmod +x bootstrap.sh

exec bash -i -c "./bootstrap.sh"

echo "✅ Instalação concluída com sucesso!"
