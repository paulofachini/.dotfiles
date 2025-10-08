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
