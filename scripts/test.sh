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

# Teste de existência e integridade do arquivo .p10k.zsh
check_p10k_file() {
    echo "🎨 Verificando arquivo .p10k.zsh..."
    local p10k_file="$DOTFILES_DIR/zsh/.p10k.zsh"
    if [ ! -f "$p10k_file" ]; then
        echo "❌ Arquivo .p10k.zsh não encontrado!"
        exit 1
    fi
    # Verifica se o conteúdo corresponde a algum dos temas
    local valid=0
    for theme in .p10k-clean.zsh .p10k-darkest.zsh .p10k-rainbow.zsh; do
        if cmp -s "$DOTFILES_DIR/zsh/$theme" "$p10k_file"; then
            valid=1
            echo "✅ .p10k.zsh corresponde ao tema: $theme"
            break
        fi
    done
    if [ $valid -eq 0 ]; then
        echo "❌ .p10k.zsh não corresponde a nenhum tema conhecido!"
        exit 1
    fi
}

# Teste de fallback automático
test_p10k_fallback() {
    echo "🧪 Testando fallback automático do Powerlevel10k..."
    local p10k_file="$DOTFILES_DIR/zsh/.p10k.zsh"
    rm -f "$p10k_file"
    "$DOTFILES_DIR/scripts/install.sh" < /dev/null
    if [ ! -f "$p10k_file" ]; then
        echo "❌ Fallback do Powerlevel10k falhou: .p10k.zsh não criado!"
        exit 1
    fi
    echo "✅ Fallback automático OK"
}

# Teste de seleção de tema
test_theme_selection() {
    echo "🧪 Testando seleção de tema..."
    for choice in 1 2 3; do
        "$DOTFILES_DIR/scripts/select-theme.sh" "$choice"
        local p10k_file="$DOTFILES_DIR/zsh/.p10k.zsh"
        local theme_file="$DOTFILES_DIR/zsh/.p10k-clean.zsh"
        [ "$choice" = "2" ] && theme_file="$DOTFILES_DIR/zsh/.p10k-darkest.zsh"
        [ "$choice" = "3" ] && theme_file="$DOTFILES_DIR/zsh/.p10k-rainbow.zsh"
        if cmp -s "$theme_file" "$p10k_file"; then
            echo "✅ Seleção de tema $choice OK"
        else
            echo "❌ Seleção de tema $choice falhou!"
            exit 1
        fi
    done
}

# Executar verificações
check_symlinks
check_zsh
check_plugins
check_p10k_file
test_theme_selection
test_p10k_fallback

echo "🎉 Todos os testes passaram!"
exit 0
