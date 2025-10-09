#!/bin/bash
# =====================================================================================
# Script de instalação do .dotfiles no $HOME
# Autor: Paulo Luiz Fachini
# =====================================================================================

DOTFILES_DIR="$HOME/.dotfiles"
ZSH_DIR="$DOTFILES_DIR/zsh"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Função para criar symlinks e fazer backup de arquivos existentes
create_symlink() {
    local source_file=$1
    local target_file=$2

    # Se o alvo existe, não é um symlink e é um arquivo regular, faça backup
    if [ -f "$target_file" ] && [ ! -L "$target_file" ]; then
        echo "🔹 Encontrado arquivo existente em $target_file. Fazendo backup..."
        mkdir -p "$BACKUP_DIR"
        mv "$target_file" "$BACKUP_DIR/"
        echo "✅ Backup criado em $BACKUP_DIR"
    fi

    # Cria ou substitui o symlink
    ln -sf "$source_file" "$target_file"
    echo "🔗 Symlink criado: $target_file -> $source_file"
}

echo "📦 Instalando .dotfiles no $HOME..."

create_symlink "$ZSH_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$ZSH_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

# Criar cache do Powerlevel10k
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"

echo "✅ .dotfiles instalado com sucesso!"
echo "Abra um novo terminal ou rode 'source ~/.zshrc' para aplicar as alterações."
