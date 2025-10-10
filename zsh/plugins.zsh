# =====================================================================================
# 🔌 plugins.zsh - Configuração de plugins do Oh My Zsh
#
# Plugins externos carregados manualmente:
# - zsh-autosuggestions: Sugestões automáticas de comandos baseadas no histórico
# - zsh-syntax-highlighting: Destaque de sintaxe em tempo real na linha de comando
#
# Dependências: Oh My Zsh instalado
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025
# Versão: 1.0.0
# Licença: MIT
# =====================================================================================
plugins=(
  # Lista vazia - apenas plugins externos carregados manualmente
)

# =====================================================================================
# 🚀 Inicialização do Oh My Zsh
# =====================================================================================
source $ZSH/oh-my-zsh.sh

# =====================================================================================
# 💡 Plugins externos (carregados manualmente)
# Ordem é importante: autosuggestions → syntax-highlighting
# =====================================================================================
[ -f "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
  source "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"

[ -f "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
  source "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  