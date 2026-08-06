# =====================================================================================
# 🎨 theme.zsh - Configuração de tema e aparência do terminal
#
# Tema Powerlevel10k para uma experiência visual rica:
# - Tema: powerlevel10k/powerlevel10k
# - Configuração personalizada em ~/.p10k.zsh
# - Suporte a ícones e cores avançadas
# - Prompt informativo e customizável
#
# Para personalizar: execute `p10k configure`
#
# Dependências: Powerlevel10k instalado
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025 | Atualizado: Agosto 2026
# Versão: 1.0.0
# Licença: MIT
# =====================================================================================
ZSH_THEME="powerlevel10k/powerlevel10k"

# =====================================================================================
# 🌈 Powerlevel10k Configuration
# Para manter a personalização utilize o `p10k configure`
# =====================================================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Windows MSYS2: sobrescreve parâmetros após source de ~/.p10k.zsh e antes de
# oh-my-zsh carregar o p10k. Usa opções válidas do p10k para desabilitar
# gitstatus (daemon/fifos) e evita worker assíncrono no prompt direito.
case "$OSTYPE" in
  cygwin*|msys*)
    typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
    typeset -g POWERLEVEL9K_DISABLE_GITSTATUS=true
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
    ;;
esac
