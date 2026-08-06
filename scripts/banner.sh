#!/bin/bash
# =====================================================================================
# 🌈 banner.sh - Banner de boas-vindas exibido ao final da execução da instalação
#
# Exibe um banner ASCII colorido e mensagens de boas-vindas após a instalação dos .dotfiles:
# - Gradiente arco-íris em texto e arte ASCII
# - Mensagens úteis sobre configuração do ambiente
# - Links para repositório, GitHub e site
#
# Uso: ./banner.sh (chamado automaticamente pelo install.sh ou manualmente)
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025
# Versão: 1.0.0
# Licença: MIT
# Dependências: bash, zsh
# =====================================================================================

# Cores utilizadas
RESET='\033[0m'
BOLD='\033[1m'
VERDE='\033[38;2;0;255;0m'
AMARELO='\033[38;2;255;255;0m'
AZUL='\033[38;2;29;85;166m'


# Função auxiliar para aplicar gradiente arco-íris em um texto
apply_rainbow_gradient() {
  local text="$1"
  local length=${#text}
  local i
  
  # Cores do arco-íris em RGB
  local -a rainbow_rgb=(
    "255 0 0"       # Vermelho
    "255 127 0"     # Laranja
    "255 255 0"     # Amarelo
    "0 255 0"       # Verde
    "0 0 255"       # Azul
    "75 0 130"      # Índigo/Violeta
    "148 0 211"     # Violeta/Roxo
  )
  
  local num_colors=${#rainbow_rgb[@]}
  
  for (( i=0; i<length; i++ )); do
    local color_pos_scaled=$((i * (num_colors - 1) * 100 / (length - 1)))
    local color_index=$((color_pos_scaled / 100))
    local next_index=$((color_index + 1))
    
    if [[ $next_index -ge $num_colors ]]; then
      next_index=$((num_colors - 1))
    fi
    
    read -r r1 g1 b1 <<< "${rainbow_rgb[$color_index]}"
    read -r r2 g2 b2 <<< "${rainbow_rgb[$next_index]}"
    
    local ratio=$((color_pos_scaled - color_index * 100))
    local r=$(((r1 * (100 - ratio) + r2 * ratio) / 100))
    local g=$(((g1 * (100 - ratio) + g2 * ratio) / 100))
    local b=$(((b1 * (100 - ratio) + b2 * ratio) / 100))
    
    printf "\033[38;2;%d;%d;%dm%s" "$r" "$g" "$b" "${text:$i:1}"
  done
  printf "${RESET}"
}

# Quebra linha N vezes
br() {
  local count="${1:-1}"
  for (( i=0; i<count; i++ )); do
    printf "\n"
  done
}

# Imprime texto com gradiente arco-íris
printfrg() {
  local text="$1"
  apply_rainbow_gradient "$text"
}

# Imprime texto com gradiente arco-íris e negrito
printfrg_bold() {
  local text="$1"
  printf '%b' "$BOLD"
  printfrg "$text"
  printf '%b' "$RESET"
}

print_rainbow_gradient_ascii() {
  local array_name="$1"
  eval "for line in \"\${${array_name}[@]}\"; do
    apply_rainbow_gradient \"\$line\"
    br
  done"
  br
}

ascii_art=(
"                                                                             "
"            ░██               ░██        ░████ ░██░██                        "
"            ░██               ░██       ░██       ░██                        "
"            ░██               ░██       ░██       ░██                        "
"      ░████████  ░███████  ░████████ ░████████ ░██░██  ░███████   ░███████   "
"     ░██    ░██ ░██    ░██    ░██       ░██    ░██░██ ░██    ░██ ░██         "
"     ░██    ░██ ░██    ░██    ░██       ░██    ░██░██ ░█████████  ░███████   "
"     ░██   ░███ ░██    ░██    ░██       ░██    ░██░██ ░██               ░██  "
" ░██  ░█████░██  ░███████      ░████    ░██    ░██░██  ░███████   ░███████   "
"                                                                             "
)

print_text() {
  printfrg_bold "...está configurado e pronto para uso! 🎉"; br 2
  printf "Antes de começar, dê uma olhada nos diretórios e arquivos ${AMARELO}zsh${RESET}, ${AMARELO}git${RESET} e ${AMARELO}wsl${RESET}"; br
  printf "neles você pode ajustar aliases, plugins, variáveis de ambiente, entre outros"; br
  printf "e para obter ajuda sobre os comandos, execute: ${VERDE}dotfiles_help${RESET}"; br 2
  printf "${BOLD}Links úteis:${RESET}"; br
  printf "  • 📚 Repositório: ${AZUL}https://github.com/paulofachini/dotfiles${RESET}"; br
  printf "  • 🐙 GitHub: ${AZUL}https://github.com/paulofachini${RESET}"; br
  printf "  • 💻 Site: ${AZUL}https://paulofachini.dev.br${RESET}"; br 2
  printfrg "🌈✨ Aproveite o seu terminal!"; br 2
}

br 2
print_rainbow_gradient_ascii ascii_art
print_text
