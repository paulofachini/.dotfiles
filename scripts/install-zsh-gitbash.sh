#!/bin/bash
# =====================================================================================
# 🪟 install-zsh-gitbash.sh - Instala zsh no Git Bash (Windows)
#
# Baixa pacotes do repositório MSYS2 (msys/x86_64) e os instala no diretório
# do Git for Windows, tornando o zsh disponível dentro do Git Bash.
#
# Como funciona:
#   No Git Bash, o caminho POSIX "/" corresponde a "C:\Program Files\Git\".
#   Extraindo os pacotes MSYS2 em "/" os binários ficam em /usr/bin/zsh,
#   e as DLLs (.dll) ficam em /usr/bin/, que já está no PATH do Git Bash.
#
# Pré-condição:
#   Execute o Git Bash como Administrador no Windows Terminal para permitir a
#   instalação em C:\Program Files\Git\usr\bin.
#
# Para atualizar as versões dos pacotes, consulte:
#   https://packages.msys2.org/search?r=msys&q=zsh
#   https://packages.msys2.org/search?r=msys&q=ncurses
#   https://packages.msys2.org/search?r=msys&q=libpcre
#
# Uso: bash scripts/install-zsh-gitbash.sh
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Maio 2026
# Versão: 1.2.0
# Licença: MIT
# =====================================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/utils.sh" ]]; then
  source "$SCRIPT_DIR/utils.sh"
else
  br()      { local n="${1:-1}"; for ((i=0;i<n;i++)); do printf "\n"; done; }
  info()    { printf "ℹ️ %s" "$1"; br; }
  success() { printf "✅ %s" "$1"; br; }
  warn()    { printf "⚠️ %s" "$1"; br; }
  error()   { printf "❌ %s" "$1"; br; exit 1; }
fi

# ─────────────────────────────────────────────────────────────────────────────
# Pacotes MSYS2 (msys/x86_64)
# As versões são resolvidas dinamicamente no mirror para evitar 404 em updates.
# ─────────────────────────────────────────────────────────────────────────────
MSYS2_MIRROR="https://mirror.msys2.org/msys/x86_64"
ZSH_PKG=""
NCURSES_PKG=""
LIBPCRE_PKG=""
ZSTD_HELPER_URL="https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-v1.5.7-win64.zip"

# ─────────────────────────────────────────────────────────────────────────────

# Verificação: já instalado?
if command -v zsh &>/dev/null; then
  success "zsh já está instalado: $(zsh --version)"
  exit 0
fi

# Pré-requisitos básicos
command -v curl &>/dev/null || error "curl não encontrado. Instale o Git for Windows completo e tente novamente."
command -v tar  &>/dev/null || error "tar não encontrado. Instale o Git for Windows completo e tente novamente."
command -v powershell.exe &>/dev/null || error "powershell.exe não encontrado. Necessário para extração auxiliar de zstd no Windows."

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
ZSTD_BIN=""

download_zstd_helper() {
  if [[ -n "$ZSTD_BIN" && -x "$ZSTD_BIN" ]]; then
    return 0
  fi

  if command -v zstd &>/dev/null; then
    ZSTD_BIN="$(command -v zstd)"
    return 0
  fi

  if command -v unzstd &>/dev/null; then
    ZSTD_BIN="$(command -v unzstd)"
    return 0
  fi

  info "Ferramenta zstd não encontrada. Baixando helper portátil..."

  local helper_zip="$TMP_DIR/zstd-win64.zip"
  local helper_dir="$TMP_DIR/zstd-helper"
  mkdir -p "$helper_dir"

  curl -fsSL "$ZSTD_HELPER_URL" -o "$helper_zip" || error "Falha ao baixar helper zstd portátil."

  local helper_zip_win helper_dir_win
  helper_zip_win="$(cygpath -w "$helper_zip")"
  helper_dir_win="$(cygpath -w "$helper_dir")"

  powershell.exe -NoProfile -Command "Expand-Archive -Path '$helper_zip_win' -DestinationPath '$helper_dir_win' -Force" >/dev/null 2>&1 \
    || error "Falha ao extrair helper zstd portátil via PowerShell."

  ZSTD_BIN="$(find "$helper_dir" -type f -name "zstd.exe" | head -n1)"
  [[ -n "$ZSTD_BIN" && -x "$ZSTD_BIN" ]] || error "Helper zstd.exe não encontrado após extração."
}

extract_pkg_to() {
  local pkg_path="$1"
  local destination="$2"

  download_zstd_helper

  # Compatível com tar do Git Bash que não possui zstd embutido.
  tar -xf "$pkg_path" -C "$destination" \
    --use-compress-program="$ZSTD_BIN -d --stdout" \
    --exclude='.BUILDINFO' \
    --exclude='.MTREE' \
    --exclude='.PKGINFO' \
    --exclude='.INSTALL'
}

download_packages() {
  local mirror_index
  mirror_index="$(curl -fsSL "$MSYS2_MIRROR/")" || error "Falha ao consultar índice do mirror MSYS2."

  find_latest_pkg() {
    local package_prefix="$1"
    printf "%s" "$mirror_index" \
      | grep -Eo "${package_prefix}-[0-9][^\"]*-x86_64\.pkg\.tar\.zst" \
      | sort -V \
      | tail -n1
  }

  ZSH_PKG="$(find_latest_pkg "zsh")"
  NCURSES_PKG="$(find_latest_pkg "ncurses")"
  LIBPCRE_PKG="$(find_latest_pkg "libpcre")"

  [[ -n "$ZSH_PKG" ]] || error "Pacote zsh não encontrado no mirror MSYS2."
  [[ -n "$NCURSES_PKG" ]] || error "Pacote ncurses não encontrado no mirror MSYS2."
  [[ -n "$LIBPCRE_PKG" ]] || error "Pacote libpcre não encontrado no mirror MSYS2."

  info "Baixando as versões resolvidas:"

  for pkg in "$ZSH_PKG" "$NCURSES_PKG" "$LIBPCRE_PKG"; do
    info "- $pkg..."
    curl -fsSL "$MSYS2_MIRROR/$pkg" -o "$TMP_DIR/$pkg" || error "Falha ao baixar: $MSYS2_MIRROR/$pkg"
  done
}

install_global() {
  printf "🪟 Instalando zsh globalmente em /usr/bin (Git for Windows)..."; br
  br

  for pkg in "$ZSH_PKG" "$NCURSES_PKG" "$LIBPCRE_PKG"; do
    info "Extraindo $pkg em /..."
    if ! extract_pkg_to "$TMP_DIR/$pkg" "/"; then
      error "Falha ao extrair $pkg para / (instalação global)."
    fi
    success "$pkg instalado (global)."
    br
  done
}

download_packages

if touch "/usr/bin/.zsh_install_test" 2>/dev/null; then
  rm -f "/usr/bin/.zsh_install_test"
  install_global
else
  error "Sem permissão para escrever em /usr/bin. Abra o Windows Terminal com o perfil Git Bash configurado para executar como Administrador e tente novamente."
fi

# Verificação final
if command -v zsh &>/dev/null; then
  success "zsh instalado com sucesso: $(zsh --version)"
else
  error "Instalação concluída, mas o zsh não ficou acessível no PATH do Git Bash."
fi
