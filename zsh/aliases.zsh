# =====================================================================================
# 🧰 Aliases personalizados
# =====================================================================================
alias ll="ls -lh"
alias la="ls -lha"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"
alias reload='source ~/.zshrc'
alias projects="cd ~/projects"

# =====================================================================================
# 🔧 Git Helpers (Básicos - os avançados estão no .gitconfig)
# =====================================================================================
alias g="git"
alias gs="git status"
alias gp="git pull"
alias gl="git log --oneline --graph --decorate"

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
