# =====================================================================================
# 🔄 Função para atualizar o .dotfiles
# =====================================================================================
dotfiles-update() {
    echo "📦 Atualizando o repositório .dotfiles..."
    
    # Entrar no diretório do dotfiles
    cd "$HOME/.dotfiles" || { echo "❌ Diretório ~/.dotfiles não encontrado"; return 1; }

    # Buscar alterações do remoto e aplicar
    git fetch origin
    git pull origin main --rebase

    # Restaurar symlinks e configurações
    echo "🔄 Aplicando as configurações com restore.sh..."
    ~/.dotfiles/restore.sh

    # Recarregar o Zsh
    echo "⚡ Recarregando ~/.zshrc..."
    source ~/.zshrc

    echo "✅ Atualização concluída!"
}

alias dotupdate="dotfiles-update"
