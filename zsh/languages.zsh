# =====================================================================================
# 🛠️ languages.zsh - Configurações de linguagens de programação
#
# Configurações otimizadas para ambientes de desenvolvimento:
# - Node.js/NVM: Gerenciamento de versões do Node.js
# - Python: Configuração de virtualenv e pip
# - Go: Variáveis de ambiente e GOPATH
#
# Dependências: nvm, pyenv, go
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025 | Atualizado: Agosto 2026
# Versão: 1.1.0
# Licença: MIT
# =====================================================================================

# Detectar Sistema Operacional
_detect_os() {
  case "$(uname -s)" in
    Linux*)   echo "linux"   ;;
    Darwin*)  echo "macos"   ;;
    *)        echo "unknown" ;;
  esac
}

# Configurações específicas por Sistema Operacional
case "$(_detect_os)" in
  macos)

    # ======================================================================
    # 🍎 macOS - Python 3.10 (Homebrew)
    # ======================================================================
    if [ -d "/opt/homebrew/opt/python@3.10/libexec/bin" ]; then
      export PATH="/opt/homebrew/opt/python@3.10/libexec/bin:$PATH"
    fi

    ;;
  linux)

    # ======================================================================
    # 🟩 NVM (Node Version Manager)
    # ======================================================================
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
      source "$NVM_DIR/nvm.sh"
    fi
    if [ -s "$NVM_DIR/bash_completion" ]; then
      source "$NVM_DIR/bash_completion"
    fi

    # ======================================================================
    # 🐍 Pyenv
    # ======================================================================
    export PYENV_ROOT="$HOME/.pyenv"
    if command -v pyenv >/dev/null; then
      export PATH="$PYENV_ROOT/bin:$PATH"
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi

    # ======================================================================
    # 🐹 Go Lang
    # ======================================================================
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

    ;;
esac
