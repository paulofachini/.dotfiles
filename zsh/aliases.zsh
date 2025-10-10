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
# 🔧 Git Helpers
# =====================================================================================
alias g="git"
alias gs="git status"
alias gp="git pull"
alias gl="git log --oneline --graph --decorate"
alias gc="git commit -m"
alias ga="git add ."
alias gb="git branch"
alias gco="git checkout"
alias gcm="git checkout main"

# =====================================================================================
# Others Helpers
# =====================================================================================

# Get External IP / Internet Speed Test
alias myip="curl https://ipinfo.io/json"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
