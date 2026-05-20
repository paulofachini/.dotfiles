#!/bin/bash
# =====================================================================================
# 🧪 test.sh - Script de validação automatizada dos .dotfiles
#
# Executa testes completos para validar a instalação dos .dotfiles:
# - Verificação de symlinks criados corretamente
# - Teste de carregamento do Zsh sem erros
# - Validação da presença de plugins instalados
# - Relatórios detalhados de sucesso/falha
#
# Uso: ./test.sh (executado automaticamente pelo Docker)
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025 | Atualizado: Maio 2026
# Versão: 2.0.0
# Licença: MIT
# Dependências: zsh, git, scripts/utils.sh
# =====================================================================================

# Carrega funções utilitárias compartilhadas
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

set -e

DOTFILES_DIR="$HOME/.dotfiles"
OS=$(detect_os)
CONFIG_FILE="$DOTFILES_DIR/os/${OS}/symlinks.conf"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

printf "🧪 Iniciando testes dos .dotfiles..."; br

# Função para verificar symlinks
check_symlinks() {
    printf "🔗 Verificando symlinks..."; br
    while read -r source_path target_path; do
        [[ -z "$source_path" || "$source_path" == \#* ]] && continue
        target_full="$HOME/$target_path"
        source_full="$DOTFILES_DIR/$source_path"
        if [ ! -L "$target_full" ]; then
            printf "❌ Symlink não encontrado: $target_full"; br
            exit 1
        fi
        if [ "$(readlink -f "$target_full")" != "$source_full" ]; then
            printf "❌ Symlink incorreto: $target_full -> $(readlink -f "$target_full") (esperado: $source_full)"; br
            exit 1
        fi
        printf "✅ Symlink OK: $target_full"; br
    done < "$CONFIG_FILE"
}

# Função para testar carregamento do Zsh
check_zsh() {
    printf "🐚 Testando carregamento do Zsh..."; br
    if ! zsh -c 'source ~/.zshrc && printf "Zsh carregado com sucesso"' >/dev/null 2>&1; then
        printf "❌ Falha ao carregar Zsh"; br
        exit 1
    fi
    printf "✅ Zsh OK"; br
}

# Função para verificar plugins
check_plugins() {
    printf "🧩 Verificando plugins..."; br
    plugins=("zsh-autosuggestions" "zsh-syntax-highlighting")
    for plugin in "${plugins[@]}"; do
        if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
            printf "❌ Plugin não encontrado: $plugin"; br
            exit 1
        fi
        printf "✅ Plugin OK: $plugin"; br
    done
}

# Teste de existência e integridade do arquivo .p10k.zsh
check_p10k_file() {
    printf "🎨 Verificando arquivo .p10k.zsh..."; br
    local p10k_file="$DOTFILES_DIR/zsh/.p10k.zsh"
    if [ ! -f "$p10k_file" ]; then
        printf "❌ Arquivo .p10k.zsh não encontrado!"; br
        exit 1
    fi
    # Verifica se o conteúdo corresponde a algum dos temas
    local valid=0
    for theme in .p10k-clean.zsh .p10k-darkest.zsh .p10k-rainbow.zsh; do
        if cmp -s "$DOTFILES_DIR/zsh/$theme" "$p10k_file"; then
            valid=1
            printf "✅ .p10k.zsh corresponde ao tema: $theme"; br
            break
        fi
    done
    if [ $valid -eq 0 ]; then
        printf "❌ .p10k.zsh não corresponde a nenhum tema conhecido!"; br
        exit 1
    fi
}

# Teste de fallback automático
test_p10k_fallback() {
    printf "🧪 Testando fallback automático do Powerlevel10k..."; br
    local p10k_file="$DOTFILES_DIR/zsh/.p10k.zsh"
    rm -f "$p10k_file"
    "$DOTFILES_DIR/scripts/install.sh" < /dev/null
    if [ ! -f "$p10k_file" ]; then
        printf "❌ Fallback do Powerlevel10k falhou: .p10k.zsh não criado!"; br
        exit 1
    fi
    printf "✅ Fallback automático OK"; br
}

# Teste de seleção de tema
test_theme_selection() {
    printf "🧪 Testando seleção de tema..."; br
    for choice in 1 2 3; do
        "$DOTFILES_DIR/scripts/select-theme.sh" "$choice"
        local p10k_file="$DOTFILES_DIR/zsh/.p10k.zsh"
        local theme_file="$DOTFILES_DIR/zsh/.p10k-clean.zsh"
        [ "$choice" = "2" ] && theme_file="$DOTFILES_DIR/zsh/.p10k-darkest.zsh"
        [ "$choice" = "3" ] && theme_file="$DOTFILES_DIR/zsh/.p10k-rainbow.zsh"
        if cmp -s "$theme_file" "$p10k_file"; then
            printf "✅ Seleção de tema $choice OK"; br
        else
            printf "❌ Seleção de tema $choice falhou!"; br
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

printf "🎉 Todos os testes passaram!"; br
exit 0
