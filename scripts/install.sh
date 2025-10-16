#!/bin/bash
# =====================================================================================
# 📦 install.sh - Script de instalação automatizada dos dotfiles
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
# Data: Outubro 2025
# Versão: 2.1.0
# Licença: MIT
# Dependências: bash, zsh, curl, git, sudo
# =====================================================================================

set -e # Encerra o script se um comando falhar

# Função para verificar se um comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

printf "📦 Verificando e instalando dependências..."

if [[ "$(uname)" == "Linux" ]]; then
    printf "🐧 Detectado sistema Linux (Ubuntu/Debian)."
    sudo apt-get update -y
    sudo apt-get install -y git zsh curl wget unzip tree screenfetch build-essential ca-certificates locales

    sudo locale-gen pt_BR.UTF-8 
    sudo update-locale LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8
    printf "🌐 Locale para pt_BR.UTF-8 configurado."
else
    printf "❌ Sistema operacional não suportado: $(uname)"
    exit 1
fi

# Instalar Oh My Zsh (se não estiver instalado)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    printf "🎨 Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    printf "✅ Oh My Zsh instalado com sucesso."
else
    printf "✅ Oh My Zsh já está instalado."
fi

# Definir Zsh como shell padrão (se não for)

# Exibe mensagem de shell padrão apenas se o comando chsh não falhar
mensagem_zsh="셸 Zsh definido como shell padrão."
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    if sudo chsh -s "$(which zsh)" "$USER"; then
        printf "$mensagem_zsh"
    else
        printf "⚠️ Não foi possível definir Zsh como padrão."
    fi
else
    printf "$mensagem_zsh"
fi

# Instalar plugins externos do Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="$ZSH_CUSTOM/plugins"
THEMES_DIR="$ZSH_CUSTOM/themes"

# zsh-autosuggestions
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    printf "🧩 Instalando o plugin zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
    printf "✅ zsh-autosuggestions instalado com sucesso."
else
    printf "✅ zsh-autosuggestions já está instalado."
fi

# zsh-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    printf "🧩 Instalando o plugin zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting"
    printf "✅ zsh-syntax-highlighting instalado com sucesso."
else
    printf "✅ zsh-syntax-highlighting já está instalado."
fi

# Instalar tema Powerlevel10k
if [ ! -d "$THEMES_DIR/powerlevel10k" ]; then
    printf "🎨 Instalando tema Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEMES_DIR/powerlevel10k"
    printf "✅ Powerlevel10k instalado com sucesso."
else
    printf "✅ Powerlevel10k já está instalado."
fi

# Clonar o repositório .dotfiles ou atualizar se já existir
DOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    printf "📂 Clonando o repositório `.dotfiles`..."
    git clone https://github.com/paulofachini/dotfiles.git "$DOTFILES_DIR"
    printf "✅ Repositório `.dotfiles` clonado com sucesso."
else
    printf "📂 Atualizando o repositório `.dotfiles`..."
    cd "$DOTFILES_DIR"
    # Pular atualização se estiver em container (evita conflitos com arquivos copiados)
    if [ -z "$DOCKER_CONTAINER" ]; then
        git fetch origin
        git reset --hard origin/main
        git clean -fdx
        printf "✅ Repositório `.dotfiles` atualizado com sucesso."
    else
        printf "⚠️ Pulando atualização do repositório (ambiente container)."
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
    printf "⚠️ Arquivo .p10k.zsh não encontrado, restaurando arquivo padrão."
    cp "$DOTFILES_DIR/zsh/.p10k-clean.zsh" "$DOTFILES_DIR/zsh/.p10k.zsh"
fi
