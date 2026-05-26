#!/bin/bash
# =====================================================================================
# 📦 install.sh - Script de instalação automatizada dos .dotfiles
#
# Instala e configura automaticamente o ambiente de desenvolvimento completo:
# - Dependências essenciais (git, zsh, curl, build-essential)
# - Configuração de locale para pt_BR.UTF-8
# - Oh My Zsh + Powerlevel10k theme
# - Plugins: zsh-autosuggestions e zsh-syntax-highlighting
# - Symlinks para configurações personalizadas
# - Detecção de ambiente Docker para comportamento adequado
#
# Uso: ./install.sh ou bash -c "$(curl -fsSL URL)"
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025 | Atualizado: Maio 2026
# Versão: 3.0.0
# Licença: MIT
# Dependências: bash, zsh, curl, git, sudo
# Plataformas: Linux/WSL (Fase 1) | Windows/Git Bash (Fase 2) | macOS (Fase 3)
# =====================================================================================

set -e # Encerra o script se um comando falhar

# Carrega funções utilitárias compartilhadas
# Quando executado via curl pipe, BASH_SOURCE[0] fica vazio e utils.sh não
# está disponível localmente — define as funções mínimas necessárias inline.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/utils.sh" ]]; then
  source "$SCRIPT_DIR/utils.sh"
else
  # Fallback inline para execução via curl pipe
  detect_os() {
    case "$(uname -s)" in
      Linux*)           echo "linux"   ;;
      Darwin*)          echo "macos"   ;;
      MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
      *)                echo "unknown" ;;
    esac
  }
  br()             { local n="${1:-1}"; for ((i=0;i<n;i++)); do printf "\n"; done; }
  error()          { printf "❌ %s" "$1"; br; exit 1; }
  command_exists() { command -v "$1" >/dev/null 2>&1; }
fi

OS=$(detect_os)

printf "📦 Verificando e instalando dependências..."; br

case "$OS" in
  linux)
    printf "🐧 Detectado sistema Linux (Ubuntu/Debian)."; br
    sudo apt-get update -y
    sudo apt-get install -y git zsh curl wget unzip tree screenfetch build-essential ca-certificates locales
    sudo update-ca-certificates

    sudo locale-gen pt_BR.UTF-8
    sudo update-locale LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8
    printf "🌐 Locale para pt_BR.UTF-8 configurado."; br
    ;;
  macos)
    error "Suporte a macOS ainda não implementado. Em desenvolvimento na Fase 3."
    ;;
  windows)
    error "Suporte a Windows ainda não implementado. Em desenvolvimento na Fase 2."
    ;;
  *)
    error "Sistema operacional não suportado: $(uname -s)"
    ;;
esac

# Instalar Oh My Zsh (se não estiver instalado)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    printf "🎨 Instalando Oh My Zsh..."; br
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    printf "✅ Oh My Zsh instalado com sucesso."; br
else
    printf "✅ Oh My Zsh já está instalado."; br
fi

# Definir Zsh como shell padrão (se não for)

# Exibe mensagem de shell padrão apenas se o comando chsh não falhar
mensagem_zsh="셸 Zsh definido como shell padrão."
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    if sudo chsh -s "$(which zsh)" "$USER"; then
        printf "$mensagem_zsh"; br
    else
        printf "⚠️ Não foi possível definir Zsh como padrão."; br
    fi
else
    printf "$mensagem_zsh"; br
fi

# Instalar plugins externos do Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="$ZSH_CUSTOM/plugins"
THEMES_DIR="$ZSH_CUSTOM/themes"

# zsh-autosuggestions
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    printf "🧩 Instalando o plugin zsh-autosuggestions..."; br
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
    printf "✅ zsh-autosuggestions instalado com sucesso."; br
else
    printf "✅ zsh-autosuggestions já está instalado."; br
fi

# zsh-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    printf "🧩 Instalando o plugin zsh-syntax-highlighting..."; br
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting"
    printf "✅ zsh-syntax-highlighting instalado com sucesso."; br
else
    printf "✅ zsh-syntax-highlighting já está instalado."; br
fi

# Instalar tema Powerlevel10k
if [ ! -d "$THEMES_DIR/powerlevel10k" ]; then
    printf "🎨 Instalando tema Powerlevel10k..."; br
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEMES_DIR/powerlevel10k"
    printf "✅ Powerlevel10k instalado com sucesso."; br
else
    printf "✅ Powerlevel10k já está instalado."; br
fi

# Clonar o repositório .dotfiles ou atualizar se já existir
DOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    printf "📂 Clonando o repositório `.dotfiles`..."; br
    git clone https://github.com/paulofachini/dotfiles.git "$DOTFILES_DIR"
    printf "✅ Repositório `.dotfiles` clonado com sucesso."; br
else
    printf "📂 Atualizando o repositório `.dotfiles`..."; br
    cd "$DOTFILES_DIR"
    # Pular atualização se estiver em container (evita conflitos com arquivos copiados)
    if [ -z "$DOCKER_CONTAINER" ]; then
        git fetch origin
        git reset --hard origin/main
        git clean -fdx
        printf "✅ Repositório `.dotfiles` atualizado com sucesso."; br
    else
        printf "⚠️ Pulando atualização do repositório (ambiente container)."; br
    fi
fi

# Definir permissões de execução para todos os scripts
chmod +x "$DOTFILES_DIR/scripts/"*.sh

# Seleciona o tema do Powerlevel10k
"$DOTFILES_DIR/scripts/select-theme.sh"

# Executar o script de restauração para criar os symlinks
"$DOTFILES_DIR/scripts/restore.sh"

# Banner de boas-vindas e instalação concluída!
"$DOTFILES_DIR/scripts/banner.sh"

# Verifica se o arquivo .p10k.zsh foi criado corretamente
if [ ! -f "$DOTFILES_DIR/zsh/.p10k.zsh" ]; then
    printf "⚠️ Arquivo .p10k.zsh não encontrado, restaurando arquivo padrão."; br
    cp "$DOTFILES_DIR/zsh/.p10k-clean.zsh" "$DOTFILES_DIR/zsh/.p10k.zsh"
fi
