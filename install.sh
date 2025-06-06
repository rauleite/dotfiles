#!/bin/bash
# install.sh - Instalação automática dos dotfiles

set -e  # Sai imediatamente se algum comando falhar

echo "▶️  Iniciando instalação dos dotfiles..."

# Clone o repositório (se ainda não existir)
if [ ! -d ~/dotfiles ]; then
  echo "⏬ Clonando repositório principal..."
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
# ./bootstrap.sh
exec bash -i -c "./bootstrap.sh"

echo "✅ Instalação concluída com sucesso!"
