#!/bin/bash
# =====================================================================================
# 🎨 select-theme.sh - Seleção interativa de tema Powerlevel10k
#
# Permite ao usuário escolher um dos temas visuais para o prompt do Zsh:
# - Clean (padrão): visual limpo e minimalista
# - Darkest: visual escuro
# - Rainbow: visual colorido
#
# O tema selecionado é copiado para zsh/.p10k.zsh, sobrescrevendo o anterior.
# Uso: ./select-theme.sh (chamado automaticamente pelo install.sh ou manualmente)
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025
# Versão: 1.0.0
# Licença: MIT
# Dependências: bash
# =====================================================================================

DOTFILES_DIR="$HOME/.dotfiles"
ZSH_DIR="$DOTFILES_DIR/zsh"

BOLD='\033[1m'
RESET='\033[0m'
GREEN='\033[38;2;0;255;0m'
YELLOW='\033[38;2;255;255;0m'
BLUE='\033[38;2;29;85;166m'

CLEAN="🧼 Clean (padrão)"
DARKEST="🌑 Darkest"
RAINBOW="🌈 Rainbow"

# Método que realiza a troca do tema (1, 2 ou 3)
set_theme() {
  local theme_choice="$1"
  local theme_file theme_name

  case "$theme_choice" in
    2)
      theme_file=".p10k-darkest.zsh"
      theme_name="$DARKEST"
      ;;
    3)
      theme_file=".p10k-rainbow.zsh"
      theme_name="$RAINBOW"
      ;;
    *)
      theme_file=".p10k-clean.zsh"
      theme_name="$CLEAN"
      ;;
  esac

  cp "$ZSH_DIR/$theme_file" "$ZSH_DIR/.p10k.zsh"
  br
  printf "${BOLD}${BLUE}🎨 Tema selecionado:${RESET} ${BOLD}$theme_name${RESET}\n"
}

# Método que exibe a mensagem para o usuário escolher o tema
show_theme_selection() {
  br
  printf "${BOLD}Selecione um dos temas de sua preferência:${RESET}"; br
  printf "  [1] - ${BOLD}${CLEAN}${RESET}: visual limpo e minimalista"; br
  printf "  [2] - ${BOLD}${DARKEST}${RESET}: visual escuro"; br
  printf "  [3] - ${BOLD}${RAINBOW}${RESET}: visual colorido"; br
  printf "Digite o número do tema desejado [1-3] ou pressione [Enter] para selecionar o tema padrão:${RESET} "
  read -r THEME_CHOICE
  set_theme "$THEME_CHOICE"
  br
}

# Quebra linha N vezes
br() {
  local count="${1:-1}"
  for (( i=0; i<count; i++ )); do
    printf "\n"
  done
}

# Se recebeu argumento, aplica diretamente (modo não-interativo: CI, test.sh)
# Caso contrário, exibe o menu interativo (uso manual)
if [[ -n "$1" ]]; then
  set_theme "$1"
else
  show_theme_selection
fi
