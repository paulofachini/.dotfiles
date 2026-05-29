#!/bin/bash
# =====================================================================================
# 🔧 utils.sh - Funções utilitárias compartilhadas entre os scripts
#
# Fornece detecção de plataforma e utilitários comuns:
# - Detecção de OS: Linux, macOS, Windows (Git Bash)
# - Detecção de ambientes especiais: WSL, Docker, Git Bash
# - Funções auxiliares de output
#
# Uso: source scripts/utils.sh (chamado pelos outros scripts)
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Maio 2026
# Versão: 1.1.0
# Licença: MIT
# =====================================================================================

# =====================================================================================
# 🖥️ Detecção de Sistema Operacional
# =====================================================================================

# Retorna a plataforma atual: "linux" | "macos" | "windows" | "unknown"
detect_os() {
    case "$(uname -s)" in
        Linux*)  echo "linux"   ;;
        Darwin*) echo "macos"   ;;
        MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
        *)       echo "unknown" ;;
    esac
}

# Retorna true se estiver rodando dentro do WSL
is_wsl() {
    grep -qi microsoft /proc/version 2>/dev/null
}

# Retorna true se estiver rodando dentro do Git Bash (Windows)
is_git_bash() {
    [[ "$MSYSTEM" == MINGW* || "$MSYSTEM" == "MSYS" ]]
}

# Retorna true se estiver rodando dentro de um container Docker
is_docker() {
    [[ -n "$DOCKER_CONTAINER" ]] || grep -q "docker\|containerd" /proc/1/cgroup 2>/dev/null
}

# =====================================================================================
# 🖨️ Funções de Output
# =====================================================================================

# Quebra linha N vezes
br() {
    local count="${1:-1}"
    for (( i=0; i<count; i++ )); do
        printf "\n"
    done
}

# Exibe mensagem de informação
info() {
    printf "ℹ️ %s" "$1"; br
}

# Exibe mensagem de sucesso
success() {
    printf "✅ %s" "$1"; br
}

# Exibe mensagem de aviso
warn() {
    printf "⚠️ %s" "$1"; br
}

# Exibe mensagem de erro e encerra (exit 1)
error() {
    printf "❌ %s" "$1"; br
    exit 1
}

# =====================================================================================
# 🔍 Funções de Verificação
# =====================================================================================

# Retorna true se o comando existir no PATH
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
