#!/usr/bin/env bash

RESET='\033[0m'
BOLD='\033[1m'

# Função para aplicar gradiente (esquerda → direita)
gradient_line() {
  local text="$1"
  local start_color="$2"
  local end_color="$3"
  local length=${#text}
  local i r g b step_r step_g step_b

  # Converte cores hex em RGB
  hex_to_rgb() {
    echo "$1" | sed 's/../0x& /g' | { read -r r g b; echo "$r $g $b"; }
  }

  # Cores de início e fim (RGB)
  read -r r1 g1 b1 <<<"$(hex_to_rgb $start_color)"
  read -r r2 g2 b2 <<<"$(hex_to_rgb $end_color)"

  # Diferença entre os canais
  step_r=$(( (r2 - r1) / (length == 0 ? 1 : length) ))
  step_g=$(( (g2 - g1) / (length == 0 ? 1 : length) ))
  step_b=$(( (b2 - b1) / (length == 0 ? 1 : length) ))

  for (( i=0; i<length; i++ )); do
    local r=$((r1 + step_r * i))
    local g=$((g1 + step_g * i))
    local b=$((b1 + step_b * i))
    printf "\033[38;2;%d;%d;%dm%s" "$r" "$g" "$b" "${text:$i:1}"
  done

  printf "${RESET}\n"
}

print_dotfiles() {
  printf "\n"
  gradient_line "      _           _     __  _   _              " "FF0000" "8B00FF"
  gradient_line "     | |         | |   / _|(_) | |             " "FF0000" "8B00FF"
  gradient_line "   __| |   __    | |_ | |_  _| | |  ___   ___  " "FF0000" "8B00FF"
  gradient_line "  / _  |  / _ \  | __||  _|| | | | / _ \ / __| " "FF0000" "8B00FF"
  gradient_line " | (_| | | (_) | | |_ | |  | | | ||  __/ \__ \ " "FF0000" "8B00FF"
  gradient_line "  \____|  \___/   \__||_|  |_| |_| \___| |___/ " "FF0000" "8B00FF"
  printf "\n"
}

print_text() {
  local CYAN='\033[38;5;51m'
  local YELLOW='\033[38;5;226m'
  local GREEN='\033[38;5;46m'

  printf "${GREEN}...is now configured!${RESET}\n\n"
  printf "Before you code, take a look at your ${YELLOW}.zshrc${RESET} to tune aliases, plugins and environment.\n\n"
  printf "• Repo: ${CYAN}https://github.com/paulofachini/dotfiles${RESET}\n"
  printf "• Blog: ${CYAN}https://paulofachini.dev.br${RESET}\n"
  printf "• Follow: ${CYAN}https://github.com/paulofachini${RESET}\n\n"
  printf "✨ ${GREEN}Enjoy your terminal!${RESET}\n\n"
}

print_dotfiles
print_text
