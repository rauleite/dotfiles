#!/bin/bash
# ATENÇÃO: DEIXAR NO MESMO DIRETÓRIO DA CONFIGURAÇÃO DO TMUXP
# (ou mudar o diretório dentro do arquivo de configuração - yaml no caso)
# Seleciona a janela "editor" da sessão "ambiente_dev"
tmux select-window -t dev:edit
# sleep 0.2

# 1. Dividir horizontalmente: cria o painel à direita ocupando 50% da largura.
tmux split-window -h -l 50% zsh
# sleep 0.2

# 2. Seleciona o painel esquerdo e divide verticalmente (para ter dois painéis na coluna esquerda)
tmux select-pane -t 0
# sleep 0.2
tmux split-window -v -l 50% "tail -f /var/log/syslog"
# sleep 0.2

# 3. No painel superior (esquerdo) envia o comando para iniciar o nvim.
tmux send-keys -t 0 "nvim ." Enter
