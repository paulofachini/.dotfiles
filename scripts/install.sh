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
# Versão: 3.2.0
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
  is_git_bash()    { [[ "$MSYSTEM" == MINGW* || "$MSYSTEM" == "MSYS" ]]; }
  br()             { local n="${1:-1}"; for ((i=0;i<n;i++)); do printf "\n"; done; }
  error()          { printf "❌ %s" "$1"; br; exit 1; }
  command_exists() { command -v "$1" >/dev/null 2>&1; }
fi

OS=$(detect_os)

# Auto-detecta o branch a partir do clone local quando DOTFILES_REF não foi fornecido.
# Útil quando o script é executado diretamente de um clone (bash scripts/install.sh)
# em vez de via curl pipe — elimina a dependência de export DOTFILES_REF= no shell.
if [[ -z "$DOTFILES_REF" && -d "$SCRIPT_DIR/../.git" ]]; then
  _detected_ref=$(cd "$SCRIPT_DIR/.." && git rev-parse --abbrev-ref HEAD 2>/dev/null || true)
  if [[ -n "$_detected_ref" && "$_detected_ref" != "HEAD" ]]; then
    DOTFILES_REF="$_detected_ref"
  fi
fi

# Ref padrão para operações de clone/update do repositório de dotfiles.
DOTFILES_REF_EFFECTIVE="${DOTFILES_REF:-main}"

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
    printf "🪟 Detectado Git Bash (Windows)."; br

    if ! is_git_bash 2>/dev/null; then
      error "Windows suportado apenas via Git Bash.\nInstale o Git for Windows e execute este script dentro do Git Bash."
    fi

    # Suporta tanto execução local quanto via curl pipe.
    # Quando install.sh é executado remotamente, baixa o helper de Windows em tempo de execução.
    INSTALL_ZSH_SCRIPT="$SCRIPT_DIR/install-zsh-gitbash.sh"
    if [[ ! -f "$INSTALL_ZSH_SCRIPT" ]]; then
      TMP_INSTALL_ZSH_SCRIPT="$(mktemp)"
      HELPER_DOWNLOADED=0

      # Prioridade de resolução:
      # 1) DOTFILES_RAW_BASE explícito (URL completa)
      # 2) DOTFILES_REF_EFFECTIVE (= DOTFILES_REF se fornecido, senão "main")
      #    Usa _EFFECTIVE (não $DOTFILES_REF direto) para garantir valor mesmo quando
      #    a variável não é propagada via env inline em alguns shells (ex: MSYS2 zsh).
      CANDIDATE_BASES=()
      if [[ -n "$DOTFILES_RAW_BASE" ]]; then
        CANDIDATE_BASES+=("$DOTFILES_RAW_BASE")
      else
        CANDIDATE_BASES+=("https://raw.githubusercontent.com/paulofachini/.dotfiles/$DOTFILES_REF_EFFECTIVE")
      fi

      printf "📥 Script local não encontrado. Baixando helper de instalação do zsh..."; br
      for base in "${CANDIDATE_BASES[@]}"; do
        if curl -fsSL "$base/scripts/install-zsh-gitbash.sh" -o "$TMP_INSTALL_ZSH_SCRIPT"; then
          HELPER_DOWNLOADED=1
          break
        fi
      done

      if [[ "$HELPER_DOWNLOADED" != "1" ]]; then
        printf "❌ Falha ao baixar scripts/install-zsh-gitbash.sh."; br
        printf "   URLs tentadas:"; br
        for base in "${CANDIDATE_BASES[@]}"; do
          printf "   - $base/scripts/install-zsh-gitbash.sh"; br
        done
        printf "   Dica: para forçar uma ref específica, use DOTFILES_REF=<ref>."; br
        printf "   Como alternativa, execute a partir do repositório clonado:"; br
        printf "   git clone https://github.com/paulofachini/.dotfiles.git ~/.dotfiles"; br
        printf "   bash ~/.dotfiles/scripts/install.sh"; br
        exit 1
      fi

      chmod +x "$TMP_INSTALL_ZSH_SCRIPT"
      INSTALL_ZSH_SCRIPT="$TMP_INSTALL_ZSH_SCRIPT"
    fi

    bash "$INSTALL_ZSH_SCRIPT"
    ;;
  *)
    error "Sistema operacional não suportado: $(uname -s)"
    ;;
esac

if ! command_exists zsh; then
  error "zsh não encontrado após a etapa de instalação. Verifique os logs acima e tente novamente."
fi

# Instalar Oh My Zsh (se não estiver instalado)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    printf "🎨 Instalando Oh My Zsh..."; br
  if [[ "$OS" == "windows" ]]; then
    # No Git Bash, mantém clone direto para evitar dependência do instalador oficial.
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" >/dev/null 2>&1
  else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
    printf "✅ Oh My Zsh instalado com sucesso."; br
else
    printf "✅ Oh My Zsh já está instalado."; br
fi

# Definir Zsh como shell padrão
if [[ "$OS" == "linux" ]]; then
    # No Linux, usa chsh para definir o shell padrão via PAM
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
elif [[ "$OS" == "windows" ]]; then
  # No Git Bash, chsh não está disponível.
  # A orientação para Windows Terminal é exibida uma única vez ao final da instalação.
  true
fi

# Instalar plugins externos do Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="$ZSH_CUSTOM/plugins"
THEMES_DIR="$ZSH_CUSTOM/themes"

# zsh-autosuggestions
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    printf "🧩 Instalando o plugin zsh-autosuggestions..."; br
  git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions" >/dev/null 2>&1
    printf "✅ zsh-autosuggestions instalado com sucesso."; br
else
    printf "✅ zsh-autosuggestions já está instalado."; br
fi

# zsh-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    printf "🧩 Instalando o plugin zsh-syntax-highlighting..."; br
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting" >/dev/null 2>&1
    printf "✅ zsh-syntax-highlighting instalado com sucesso."; br
else
    printf "✅ zsh-syntax-highlighting já está instalado."; br
fi

# Instalar tema Powerlevel10k
if [ ! -d "$THEMES_DIR/powerlevel10k" ]; then
    printf "🎨 Instalando tema Powerlevel10k..."; br
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEMES_DIR/powerlevel10k" >/dev/null 2>&1
    printf "✅ Powerlevel10k instalado com sucesso."; br
else
    printf "✅ Powerlevel10k já está instalado."; br
fi

# Clonar o repositório .dotfiles ou atualizar se já existir
DOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  printf "📂 Clonando o repositório .dotfiles..."; br
  git clone --branch "$DOTFILES_REF_EFFECTIVE" --single-branch https://github.com/paulofachini/.dotfiles.git "$DOTFILES_DIR" >/dev/null 2>&1
  printf "✅ Repositório .dotfiles clonado com sucesso."; br
else
  printf "📂 Atualizando o repositório .dotfiles..."; br
    cd "$DOTFILES_DIR"
    # Pular atualização se estiver em container (evita conflitos com arquivos copiados)
    if [ -z "$DOCKER_CONTAINER" ]; then
        git fetch -q origin
      if git show-ref --verify --quiet "refs/remotes/origin/$DOTFILES_REF_EFFECTIVE"; then
        git reset --hard "origin/$DOTFILES_REF_EFFECTIVE" >/dev/null 2>&1
      else
        printf "⚠️ Ref '%s' não encontrada no remoto. Usando 'main'." "$DOTFILES_REF_EFFECTIVE"; br
        git reset --hard origin/main >/dev/null 2>&1
      fi
        git clean -fdx -q
        printf "✅ Repositório .dotfiles atualizado com sucesso."; br
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

# Orientação final para criar perfil ZSH com Git Bash no Windows Terminal
if [[ "$OS" == "windows" ]]; then
    br
    source "$DOTFILES_DIR/scripts/messages.sh"
    show_windows_terminal_guidance
fi

# Verifica se o arquivo .p10k.zsh foi criado corretamente
if [ ! -f "$DOTFILES_DIR/zsh/.p10k.zsh" ]; then
    printf "⚠️ Arquivo .p10k.zsh não encontrado, restaurando arquivo padrão."; br
    cp "$DOTFILES_DIR/zsh/.p10k-clean.zsh" "$DOTFILES_DIR/zsh/.p10k.zsh"
fi
