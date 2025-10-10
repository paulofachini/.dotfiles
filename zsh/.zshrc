# =====================================================================================
# 🔃 .zshrc - Configuração principal do Zsh
#
# Arquivo principal de configuração do Zsh que orquestra o carregamento modular:
# - Setup básico: instant prompt, opções de shell, histórico
# - Variáveis de ambiente e PATH otimizado
# - Tema Powerlevel10k com configuração personalizada
# - Plugins essenciais do Oh My Zsh
# - Linguagens de programação (Node.js, Python, Go)
# - Aliases e funções personalizadas
#
# Ordem crítica de carregamento:
# 1. Setup (instant prompt + opções)
# 2. PATH e variáveis de ambiente
# 3. Tema (Powerlevel10k)
# 4. Plugins
# 5. Linguagens
# 6. Aliases e funções
#
# Dependências: Oh My Zsh, Powerlevel10k, plugins instalados
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025
# Versão: 1.2.0
# Licença: MIT
# =====================================================================================
DOTFILES_ZSH_DIR="$HOME/.dotfiles/zsh"

# =============================================================================
# 1️⃣ Setup básico (instant prompt + opções de shell, histórico, autocomplete)
# =============================================================================
source "$DOTFILES_ZSH_DIR/setup.zsh"

# ⚠️ ALERTA: Nunca mude a ordem do carregamento abaixo
# Instant Prompt deve ser carregado antes do Powerlevel10k
# Powerlevel10k (theme) deve ser carregado antes de plugins e aliases

# =============================================================================
# 2️⃣ Variáveis de ambiente e PATH
# =============================================================================
source "$DOTFILES_ZSH_DIR/path.zsh"

# =============================================================================
# 3️⃣ Linguagens e gerenciadores
# =============================================================================
source "$DOTFILES_ZSH_DIR/languages.zsh"

# =============================================================================
# 4️⃣ Powerlevel10k e Oh My Zsh
# =============================================================================
source "$DOTFILES_ZSH_DIR/theme.zsh"

# ⚠️ Verificação de ordem
if [[ -z "$POWERLEVEL9K_INSTANT_PROMPT" ]]; then
  echo "⚠️ AVISO ⚠️"
  echo "O Powerlevel10k Instant Prompt não foi carregado corretamente!"
  echo "Não altere a ordem de carregamento no .zshrc."
fi

# =============================================================================
# 5️⃣ Plugins externos
# =============================================================================
source "$DOTFILES_ZSH_DIR/plugins.zsh"

# =============================================================================
# 6️⃣ Aliases, helpers e funções
# =============================================================================
source "$DOTFILES_ZSH_DIR/aliases.zsh"
source "$DOTFILES_ZSH_DIR/functions.zsh"

# =============================================================================
# 7️⃣ Carrega configurações locais, se existirem (não versionado)
# =============================================================================
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
