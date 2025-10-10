# =====================================================================================
# 🌍 path.zsh - Variáveis de ambiente e configuração do PATH
#
# Configurações essenciais do ambiente de desenvolvimento:
# - PATH otimizado com diretórios locais e globais
# - Variáveis do Zsh e Oh My Zsh
# - Editor padrão e configurações de localização
# - Variáveis de ambiente
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025
# Versão: 1.1.0
# Licença: MIT
# =====================================================================================
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM_PLUGINS="$ZSH/custom/plugins"
export EDITOR="code -w"
export LANG="pt_BR.UTF-8"
export LC_ALL="pt_BR.UTF-8"
