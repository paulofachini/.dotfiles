#!/bin/bash
# =====================================================================================
# 🔄 restore.sh - Script de restauração dos symlinks dos dotfiles
#
# Cria e restaura os links simbólicos das configurações personalizadas:
# - Backup automático das configurações existentes
# - Criação de symlinks baseada no symlinks.conf
# - Restauração do Zsh com novas configurações
# - Relatório detalhado das operações realizadas
#
# Uso: ./restore.sh (chamado automaticamente pelo install.sh e dotupdate)
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025
# Versão: 1.1.0
# Licença: MIT
# Dependências: zsh
# =====================================================================================

BACKUP_DIR="$HOME/.backup_dotfiles_$(date +%Y%m%d_%H%M%S)"
DOTFILES_DIR="$HOME/.dotfiles"
ZSH_DIR="$DOTFILES_DIR/zsh"
CONFIG_FILE="$DOTFILES_DIR/symlinks.conf"

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

echo "📦 Instalando os dotfiles no $HOME..."

if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Arquivo de configuração de symlinks não encontrado em $CONFIG_FILE"
    exit 1
fi

# Ler o arquivo de configuração e criar os links
while read -r source_path target_path; do
    # Ignorar linhas em branco ou comentários
    [[ -z "$source_path" || "$source_path" == \#* ]] && continue

    create_symlink "$DOTFILES_DIR/$source_path" "$HOME/$target_path"
done < "$CONFIG_FILE"

# Criar cache do Powerlevel10k
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"

echo "✅ dotfiles instalado com sucesso!"
