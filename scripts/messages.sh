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
#   perfil ZSH com Git Bash no Windows Terminal após a instalação.
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Maio 2026 | Atualizado: Agosto 2026
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
  printf "Para usar o ZSH e temas como padrão no Windows Terminal:"; br
  printf "Crie um novo perfil com os dados abaixo:"; br
  printf '%s\n' "  • Nome: ZSH com Git Bash"
  printf '%s\n' "  • Diretório inicial: %USERPROFILE%"
  printf '%s\n' "  • Ícone: C:\Program Files\Git\mingw64\share\git\git-for-windows.ico"
  printf '%s\n' "  • Executar como Administrador: Ativado"
  printf '%s\n' "  • Linha de comando: C:\Program Files\Git\usr\bin\zsh.exe -l"
}
