# =====================================================================================
# ⚡ Powerlevel10k Instant Prompt (mantenha no topo)
# =====================================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =====================================================================================
# ⚙️ Opções de shell (qualidade de vida)
# =====================================================================================
setopt AUTO_CD              # Entrar em diretórios sem precisar usar 'cd'
setopt CORRECT              # Corrige pequenos erros de digitação em comandos
setopt SHARE_HISTORY        # Compartilha histórico entre múltiplos terminais
setopt HIST_IGNORE_DUPS     # Evita duplicar comandos no histórico
setopt HIST_IGNORE_SPACE    # Ignora comandos iniciados com espaço
setopt EXTENDED_GLOB        # Permite padrões avançados em wildcards
setopt COMPLETE_IN_WORD     # Autocomplete dentro de palavras

# =====================================================================================
# 🧠 Histórico
# =====================================================================================
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# =====================================================================================
# 🔍 Autocompletion e cache
# =====================================================================================
autoload -Uz compinit
compinit -d ~/.cache/zcompdump-$HOST
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
