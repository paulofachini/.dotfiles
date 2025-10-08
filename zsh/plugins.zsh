# =====================================================================================
# 🔌 Plugins do Oh My Zsh
# (carregados via oh-my-zsh.sh)
# =====================================================================================
plugins=(
  git
  docker
  node
  npm
  command-not-found
  colored-man-pages
)

# =====================================================================================
# 🚀 Inicialização do Oh My Zsh
# =====================================================================================
source $ZSH/oh-my-zsh.sh

# =====================================================================================
# 💡 Plugins externos (carregados manualmente)
# Ordem é importante: autosuggestions → syntax-highlighting
# =====================================================================================
[ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
  source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

[ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
  source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  