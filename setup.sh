#!/bin/bash
# setup.sh - Script de instalação e configuração do ambiente
#
# Este script realiza pré-checagens, instala pacotes do sistema, configura frameworks 
# (como o Oh My Zsh) e aplica os dotfiles (criação de links simbólicos) de maneira modular.
#
# Para usá-lo, basta dar permissões de execução e rodá-lo:
#   chmod +x setup.sh
#   ./setup.sh

#--------------------------------------------------------------------
# Configurações e variáveis 
#--------------------------------------------------------------------

# Comandos básicos
APT_GET_CMD="apt-get"
CURL_CMD="curl"
GIT_CMD="git"

# Versões e URLs
NVM_VERSION="v0.40.3"
NVM_INSTALL_URL="https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh"
NEOVIM_VERSION="v0.11.2"
NEOVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux-x86_64.tar.gz"

# Caminhos e nomes para a instalação do Neovim
NEOVIM_ARCHIVE="nvim-linux-x86_64.tar.gz"
NEOVIM_EXTRACTED_DIR="nvim-linux-x86_64"
NEOVIM_INSTALL_DIR="/usr/local/nvim"
NEOVIM_LINK="/usr/local/bin/nvim"

# Diretórios dos dotfiles (assumindo uma estrutura modular)
DOTFILES_DIR="$HOME/dotfiles"
ZSH_DOTFILES_DIR="${DOTFILES_DIR}/zsh"
NVIM_DOTFILES_DIR="${DOTFILES_DIR}/nvim"
TMUX_DOTFILES_DIR="${DOTFILES_DIR}/tmux"
NETPLAN_DOTFILES_DIR="${DOTFILES_DIR}/netplan"

# URLs para fontes do Powerlevel10k (para o Zsh)
declare -A POWERLEVEL10K_FONTS=(
  ["MesloLGS NF Regular.ttf"]="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
  ["MesloLGS NF Bold.ttf"]="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
  ["MesloLGS NF Italic.ttf"]="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
  ["MesloLGS NF Bold Italic.ttf"]="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)
FONT_DIR="/usr/share/fonts"   # Diretório onde as fontes serão instaladas

# Configuração para oh-my-zsh addons
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Pacotes do sistema que serão instalados
SYSTEM_PACKAGES=(build-essential zsh curl tmux git)

#--------------------------------------------------------------------
# Cores para log
#--------------------------------------------------------------------
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m"  # No Color

#--------------------------------------------------------------------
# Funções de Log
#--------------------------------------------------------------------
log_info() {
  echo -e "${GREEN}[INFO] $1${NC}"
}

log_warn() {
  echo -e "${YELLOW}[WARN] $1${NC}"
}

log_error() {
  echo -e "${RED}[ERROR] $1${NC}"
}

#--------------------------------------------------------------------
# Funções de Verificação
#--------------------------------------------------------------------
check_command() {
  if ! command -v "$1" &>/dev/null; then
    log_error "Comando '$1' não encontrado. Por favor, instale-o e tente novamente."
    exit 1
  else
    log_info "Comando '$1' encontrado."
  fi
}

check_sudo() {
  if ! sudo -n true 2>/dev/null; then
    log_warn "Senha sudo necessária..."
    sudo -v || { log_error "Falha ao obter privilégios sudo."; exit 1; }
  fi
}

#--------------------------------------------------------------------
# Funções de Instalação
#--------------------------------------------------------------------
pre_checks() {
  log_info "Executando verificações prévias..."
  check_command "$APT_GET_CMD"
  check_command "$CURL_CMD"
  check_command "$GIT_CMD"
}

install_system_packages() {
  log_info "Instalando pacotes do sistema..."
  check_sudo
  sudo apt-get update -y
  sudo apt-get install -y "${SYSTEM_PACKAGES[@]}"
  log_info "Pacotes de sistema instalados."
}

install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log_info "Instalando Oh My Zsh..."
    sh -c "$($CURL_CMD -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
      || { log_error "Falha ao instalar Oh My Zsh."; exit 1; }
    log_info "Oh My Zsh instalado com sucesso."
  else
    log_info "Oh My Zsh já está instalado."
  fi
}

install_zsh_fonts() {
  log_info "Instalando fontes do Powerlevel10k..."
  check_sudo
  sudo mkdir -p "${FONT_DIR}"
  for file in "${!POWERLEVEL10K_FONTS[@]}"; do
    url="${POWERLEVEL10K_FONTS[$file]}"
    log_info "Baixando fonte '${file}'..."
    sudo $CURL_CMD -fLo "${FONT_DIR}/${file}" "${url}"
  done
  log_info "Atualizando cache de fontes..."
  if command -v fc-cache &>/dev/null; then
    sudo fc-cache -fv "${FONT_DIR}"
  else
    log_warn "fc-cache não encontrado; atualize manualmente o cache de fontes se necessário."
  fi
  log_info "Fontes instaladas com sucesso em ${FONT_DIR}."
}

install_zsh_addons() {
  log_info "Instalando addons para Zsh..."
  # zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" 2>/dev/null || \
    log_warn "Plugin zsh-autosuggestions já instalado ou erro ao clonar."
  # zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" 2>/dev/null || \
    log_warn "Plugin zsh-syntax-highlighting já instalado ou erro ao clonar."
  # Instala fontes para Zsh
  install_zsh_fonts
  # Clona o tema powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k" 2>/dev/null || \
    log_warn "Tema powerlevel10k já instalado ou erro ao clonar."
  log_warn "É NECESSÁRIO configurar o tema em ~/.zshrc: ZSH_THEME=\"powerlevel10k/powerlevel10k\""
}

install_neovim() {
  log_info "Instalando Neovim ${NEOVIM_VERSION}..."
  # Baixa o arquivo tar.gz do Neovim
  $CURL_CMD -fLo "$NEOVIM_ARCHIVE" "$NEOVIM_DOWNLOAD_URL"
  log_info "Download concluído: ${NEOVIM_ARCHIVE}"

  # Extrai o arquivo baixado
  log_info "Extraindo o arquivo..."
  tar -xzf "$NEOVIM_ARCHIVE"
  log_info "Extração concluída: diretório '${NEOVIM_EXTRACTED_DIR}' criado."

  # Remove instalação anterior, se houver
  if [ -d "$NEOVIM_INSTALL_DIR" ]; then
    log_info "Removendo instalação anterior em ${NEOVIM_INSTALL_DIR}..."
    check_sudo
    sudo rm -rf "$NEOVIM_INSTALL_DIR"
  fi

  log_info "Movendo '${NEOVIM_EXTRACTED_DIR}' para ${NEOVIM_INSTALL_DIR}..."
  check_sudo
  sudo mv "$NEOVIM_EXTRACTED_DIR" "$NEOVIM_INSTALL_DIR"

  log_info "Criando link simbólico em ${NEOVIM_LINK}..."
  check_sudo
  sudo ln -sf "${NEOVIM_INSTALL_DIR}/bin/nvim" "$NEOVIM_LINK"

  log_info "Removendo o arquivo de download ${NEOVIM_ARCHIVE}..."
  rm -f "$NEOVIM_ARCHIVE"
  
  log_info "Instalação do Neovim concluída com sucesso!"
}

install_nvm_and_node() {
  log_info "Instalando NVM..."
  $CURL_CMD -o- "$NVM_INSTALL_URL" | bash

  # Carrega o NVM para a sessão atual
  if [ -s "$HOME/.nvm/nvm.sh" ]; then
    log_info "Carregando NVM..."
    # shellcheck source=/dev/null
    source "$HOME/.nvm/nvm.sh"
  else
    log_error "Falha ao carregar NVM. Verifique a instalação."
    exit 1
  fi

  log_info "Instalando a versão LTS do Node.js..."
  nvm install --lts

  log_info "Verificando versões do Node.js e npm:"
  NODE_VERSION=$(node --version)
  NPM_VERSION=$(npm --version)
  log_info "Node.js: ${NODE_VERSION}"
  log_info "npm: ${NPM_VERSION}"
}

configure_dotfiles() {
  log_info "Configurando dotfiles..."

  # ZSH: Cria links para cada arquivo de configuração do diretório (evitando "." e "..")
  if [ -d "$ZSH_DOTFILES_DIR" ]; then
    log_info "Linkando arquivos do Zsh a partir de ${ZSH_DOTFILES_DIR}..."
    for file in "$ZSH_DOTFILES_DIR"/.*; do
      base="$(basename "$file")"
      if [[ "$base" == "." || "$base" == ".." ]]; then
        continue
      fi
      ln -sf "$file" "$HOME/"
      log_info "Link criado para $base"
    done
  else
    log_warn "Diretório de dotfiles do Zsh não encontrado em ${ZSH_DOTFILES_DIR}"
  fi

  # Neovim: Cria link para a configuração em ~/.config/nvim
  log_info "Linkando configuração do Neovim..."
  mkdir -p "$HOME/.config"
  ln -sf "$NVIM_DOTFILES_DIR" "$HOME/.config/nvim"
  log_info "Configuração do Neovim linkada para $HOME/.config/nvim"

  # Netplan: Cria link para o arquivo de configuração (necessita de privilégios sudo)
  log_info "Linkando configuração do Netplan..."
  check_sudo
  sudo ln -sf "${NETPLAN_DOTFILES_DIR}/01-network-manager-all.yaml" "/etc/netplan/01-network-manager-all.yaml"
  log_warn "É NECESSÁRIO confirmar/ajustar o IP em /etc/netplan/01-network-manager-all.yaml"

  # Tmux: Cria link para o arquivo de configuração do Tmux
  log_info "Linkando configuração do Tmux..."
  ln -sf "${TMUX_DOTFILES_DIR}/.tmux.conf" "$HOME/.tmux.conf"
  log_info "Dotfile do Tmux linkado para $HOME/.tmux.conf"
}

#--------------------------------------------------------------------
# Função Principal
#--------------------------------------------------------------------
main() {
  log_info "Iniciando o processo de instalação e configuração..."
  pre_checks
  install_system_packages
  install_oh_my_zsh
  install_zsh_addons
  install_nvm_and_node
  install_neovim
  configure_dotfiles
  log_info "Configuração concluída com sucesso!"
}

# Executa a função principal
main
