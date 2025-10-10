# =====================================================================================
# 🔄 Função para atualizar os dotfiles
# Uso: dotupdate
# Exemplo: dotupdate (atualiza o repositório dos dotfiles)
# =====================================================================================
dotupdate() {
    echo "📦 Atualizando o repositório dos dotfiles..."
        
    # Entrar no diretório do dotfiles
    DOTFILES_DIR="$HOME/.dotfiles"
    cd "$DOTFILES_DIR" || { echo "❌ Diretório ~/.dotfiles não encontrado"; return 1; }

    # Buscar alterações do remoto e aplicar
    git fetch origin
    git pull origin main --rebase

    # Restaurar symlinks e configurações
    echo "🔄 Aplicando as configurações com script de restauração restore.sh..."
    "$DOTFILES_DIR/scripts/restore.sh"

    # Recarregar o Zsh
    echo "⚡ Recarregando ~/.zshrc..."
    source ~/.zshrc

    cd $HOME
    echo "✅ Atualização concluída!"
}

# =====================================================================================
# 📁 Função para criar e navegar para diretório
# Uso: mkcd <nome-do-diretorio>
# Exemplo: mkcd projetos/meu-app
# =====================================================================================
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# =====================================================================================
# 🧹 Função para limpar branches Git mescladas
# Uso: gclean
# Exemplo: gclean (remove todas as branches locais já mescladas)
# =====================================================================================
gclean() {
    git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
}

# =====================================================================================
# 🔧 Função para backup de arquivos
# Uso: backup <arquivo>
# Exemplo: backup config.txt (cria config.txt.backup.20251010_143022)
# =====================================================================================
backup() {
    cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# =====================================================================================
# 📦 Função para extrair qualquer arquivo
# Uso: extract <arquivo>
# Exemplos:
#   extract arquivo.tar.gz
#   extract projeto.zip
#   extract backup.7z
#   extract dados.tar.bz2
# Formatos suportados: tar.gz, tar.bz2, zip, rar, 7z, gz, bz2, tar, Z
# =====================================================================================
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
