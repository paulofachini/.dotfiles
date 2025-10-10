#!/bin/bash
# =====================================================================================
# Script de Setup do Ambiente de Desenvolvimento
# Instala dependências e configura os dotfiles.
# =====================================================================================

set -e # Encerra o script se um comando falhar

# Função para verificar se um comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "📦 Verificando e instalando dependências..."

if [[ "$(uname)" == "Linux" ]]; then
    echo "🐧 Detectado sistema Linux (Ubuntu/Debian)."
    sudo apt-get update -y
    sudo apt-get install -y git zsh curl wget unzip tree screenfetch build-essential ca-certificates locales
    
    echo "🌐 Configurando locale para pt_BR.UTF-8..."
    sudo locale-gen pt_BR.UTF-8 
    sudo update-locale LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8
else
    echo "❌ Sistema operacional não suportado: $(uname)"
    exit 1
fi

# Instalar Oh My Zsh (se não estiver instalado)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🎨 Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh já está instalado."
fi

# Definir Zsh como shell padrão (se não for)
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo "셸 Definindo Zsh como shell padrão..."
    chsh -s "$(which zsh)"
    echo "✅ Zsh definido como padrão. Por favor, faça logout e login para aplicar."
fi

# Instalar plugins externos do Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="$ZSH_CUSTOM/plugins"
THEMES_DIR="$ZSH_CUSTOM/themes"

echo "🧩 Instalando plugins do Zsh..."
# zsh-autosuggestions
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
else
    echo "✅ zsh-autosuggestions já está instalado."
fi

# zsh-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting"
else
    echo "✅ zsh-syntax-highlighting já está instalado."
fi

# Instalar tema Powerlevel10k
echo "🎨 Instalando tema Powerlevel10k..."
if [ ! -d "$THEMES_DIR/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEMES_DIR/powerlevel10k"
else
    echo "✅ Powerlevel10k já está instalado."
fi

# Clonar o repositório .dotfiles ou atualizar se já existir
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "📂 Clonando o repositório dotfiles..."
    git clone https://github.com/paulofachini/dotfiles.git "$DOTFILES_DIR"
    chmod +x "$DOTFILES_DIR/scripts/restore.sh"
else
    echo "📂 Atualizando o repositório dotfiles..."
    cd "$DOTFILES_DIR"
    git fetch origin
    git pull origin main --rebase
fi

# Executar o script de restauração para criar os symlinks
echo "🚀 Executando o script restore.sh..."
"$DOTFILES_DIR/scripts/restore.sh"

echo "🎉 Instalação concluída! Reinicie o terminal para ver as mudanças."
