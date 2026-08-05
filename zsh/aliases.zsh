# =====================================================================================
# 🧰 aliases.zsh - Aliases personalizados para produtividade
#
# Conjunto otimizado de aliases para ferramentas de desenvolvimento:
# - Navegação inteligente de arquivos e diretórios
# - Git básico (aliases avançados estão no .gitconfig)
# - Docker e containerização
# - Node.js/NPM para desenvolvimento web
# - Utilitários de rede, texto e sistema
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025
# Versão: 1.2.0
# Licença: MIT
# =====================================================================================

# =====================================================================================
# 🧰 Aliases
# =====================================================================================
alias ll="ls -lh"
alias la="ls -lha"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"
alias projects="cd ~/projects"

# =====================================================================================
# 🔧 Git Helpers (Básicos - os avançados estão no .gitconfig)
# =====================================================================================
alias g="git"
alias gs="git status"
alias gl="git log --oneline --graph --decorate"
alias pull="git pull origin main"
alias push="git push origin main"

# =====================================================================================
# 🐙 GitHub CLI Helpers
# =====================================================================================
alias ghauth="gh auth status"
alias ghpr="gh pr create"
alias ghprl="gh pr list"
alias ghprview="gh pr view"
alias ghrepo="gh repo view"

# =====================================================================================
# 🐳 Docker Helpers
# =====================================================================================
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dclean="docker system prune -af"

# =====================================================================================
# 🧩 Node/NPM Helpers
# =====================================================================================
alias npmi="npm install"
alias npmr="npm run"
alias npmt="npm test"

# =====================================================================================
# 🌐 Network & Web Helpers
# =====================================================================================
alias myip="curl -s https://api.ipify.org"
alias myipl="curl -s https://ipinfo.io/json"

# =====================================================================================
# 📝 Date & time
# =====================================================================================
alias now="date +'%Y-%m-%d %H:%M:%S'"
alias today="date +'%Y-%m-%d'"
alias week="date +'%V'"
