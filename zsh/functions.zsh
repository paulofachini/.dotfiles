# =====================================================================================
# 🔄 Função para atualizar os dotfiles
# =====================================================================================
dotfiles-update() {
    echo "📦 Atualizando o repositório dos dotfiles..."
        
    # Entrar no diretório do dotfiles
    DOTFILES_DIR="$HOME/.dotfiles"
    cd "$DOTFILES_DIR" || { echo "❌ Diretório ~/.dotfiles não encontrado"; return 1; }

    # Buscar alterações do remoto e aplicar
    git fetch origin
    git pull origin main --rebase

    # Restaurar symlinks e configurações
    echo "🔄 Aplicando as configurações com restore.sh..."
    "$DOTFILES_DIR/scripts/restore.sh"

    # Recarregar o Zsh
    echo "⚡ Recarregando ~/.zshrc..."
    source ~/.zshrc

    echo "✅ Atualização concluída!"
}

alias dotupdate="dotfiles-update"
