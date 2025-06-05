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

# Executa o bootstrap
echo "🚀 Executando configuração..."
chmod +x bootstrap.sh
./bootstrap.sh

echo "✅ Instalação concluída com sucesso!"
