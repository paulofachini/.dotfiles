#!/bin/bash
# =====================================================================================
# 🧪 test.sh - Script de validação automatizada dos dotfiles
#
# Executa testes completos para validar a instalação dos dotfiles:
# - Verificação de symlinks criados corretamente
# - Teste de carregamento do Zsh sem erros
# - Validação da presença de plugins instalados
# - Relatórios detalhados de sucesso/falha
#
# Uso: ./test.sh (executado automaticamente pelo Docker)
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025
# Versão: 1.0.0
# Licença: MIT
# Dependências: zsh, git
# =====================================================================================

set -e

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_FILE="$DOTFILES_DIR/symlinks.conf"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "🧪 Iniciando testes dos dotfiles..."

# Função para verificar symlinks
check_symlinks() {
    echo "🔗 Verificando symlinks..."
    while read -r source_path target_path; do
        [[ -z "$source_path" || "$source_path" == \#* ]] && continue
        target_full="$HOME/$target_path"
        source_full="$DOTFILES_DIR/$source_path"
        if [ ! -L "$target_full" ]; then
            echo "❌ Symlink não encontrado: $target_full"
            exit 1
        fi
        if [ "$(readlink -f "$target_full")" != "$source_full" ]; then
            echo "❌ Symlink incorreto: $target_full -> $(readlink -f "$target_full") (esperado: $source_full)"
            exit 1
        fi
        echo "✅ Symlink OK: $target_full"
    done < "$CONFIG_FILE"
}

# Função para testar carregamento do Zsh
check_zsh() {
    echo "🐚 Testando carregamento do Zsh..."
    if ! zsh -c 'source ~/.zshrc && echo "Zsh carregado com sucesso"' >/dev/null 2>&1; then
        echo "❌ Falha ao carregar Zsh"
        exit 1
    fi
    echo "✅ Zsh OK"
}

# Função para verificar plugins
check_plugins() {
    echo "🧩 Verificando plugins..."
    plugins=("zsh-autosuggestions" "zsh-syntax-highlighting")
    for plugin in "${plugins[@]}"; do
        if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
            echo "❌ Plugin não encontrado: $plugin"
            exit 1
        fi
        echo "✅ Plugin OK: $plugin"
    done
}

# Executar verificações
check_symlinks
check_zsh
check_plugins

echo "🎉 Todos os testes passaram!"
exit 0
