#!/bin/bash
# =====================================================================================
# 💬 messages.sh - Mensagens auxiliares exibidas durante e após a instalação
#
# Centraliza mensagens de orientação para cenários específicos de plataforma,
# mantendo o install.sh enxuto e com responsabilidades bem definidas.
#
# Uso: source scripts/messages.sh
#
# Funções expostas:
# - show_windows_terminal_guidance: exibe orientação final para configurar o
#   perfil Git Bash no Windows Terminal com zsh (modo local ou global).
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Maio 2026
# Versão: 1.1.0
# Licença: MIT
# Dependências: bash
# =====================================================================================

# Fallback para execução em contextos sem utils.sh carregado.
if ! command -v br >/dev/null 2>&1; then
  br() {
    local count="${1:-1}"
    for (( i=0; i<count; i++ )); do
      printf "\n"
    done
  }
fi

show_windows_terminal_guidance() {
  printf "⚠️ Passo adicional importante"; br
  printf "Para usar o Zsh e temas como padrão no perfil 'Git Bash' do Windows Terminal:"; br
  printf "Atualize a Linha de comando para uma das opções abaixo:"; br

  if [[ -x "$HOME/.local/bin/zsh" ]]; then
    printf '%s\n' "  • Instalação local (sem admin): C:\Program Files\Git\bin\bash.exe -lc \"$HOME/.local/bin/zsh -l\""
  fi

  if [[ -x "/usr/bin/zsh.exe" ]]; then
    printf '%s\n' "  • Instalação global (com admin): C:\Program Files\Git\usr\bin\zsh.exe -l"
  fi
}
