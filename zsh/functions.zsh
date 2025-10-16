# =====================================================================================
# ⚡ functions.zsh - Funções avançadas para automação
#
# Coleção de funções poderosas para tarefas comuns:
# - Gerenciamento de projetos e desenvolvimento
# - Utilitários de rede e conectividade
# - Ferramentas de produtividade e automação
# - Funções interativas com validação de entrada
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: Outubro 2025
# Versão: 1.3.0
# Licença: MIT
# =====================================================================================

DOTFILES_DIR="$HOME/.dotfiles"

# =====================================================================================
# 🧰 Aliases personalizados
# =====================================================================================
alias "dotfiles update"="dotupdate"
alias "dotfiles theme"="themeupdate"

# =====================================================================================
# 🔄 Função para atualizar os dotfiles
# Uso: dotupdate
# Alias: dotfiles update
# Exemplo: dotupdate (atualiza o repositório dos dotfiles)
# Descrição: Atualiza o repositório dos dotfiles, aplica as alterações
# e restaura as configurações personalizadas.
# Esta função também atualiza o tema do Powerlevel10k e executa o script de
# restauração restore.sh.
# Ela é útil para manter o ambiente de desenvolvimento sempre atualizado com as últimas
# configurações e temas.
# Dependências: select-theme.sh, restore.sh, banner.sh
# =====================================================================================
dotupdate() {
    echo "📦 Atualizando o repositório dos dotfiles..."
    
    # Entrar no diretório do dotfiles
    cd "$DOTFILES_DIR" || { echo "❌ Diretório $DOTFILES_DIR não encontrado"; return 1; }

    # Buscar alterações do remoto e aplicar
    git fetch origin
    git reset --hard origin/main
    git clean -fdx
    cd $HOME

    themeupdate

    # Restaurar symlinks e configurações
    echo "🔄 Aplicando as configurações com script de restauração restore.sh..."
    "$DOTFILES_DIR/scripts/restore.sh"
    echo "🎉 Dotfiles atualizados com sucesso!"

    # Banner de boas-vindas
    "$DOTFILES_DIR/scripts/banner.sh"
}

# =====================================================================================
# 🎨 Função para alterar o tema do Powerlevel10k
# Uso: themeupdate
# Alias: dotfiles theme
# Exemplo: themeupdate (atualiza o tema do Powerlevel10k)
# Descrição: Permite ao usuário escolher um novo tema para o Powerlevel10k
# e aplica as alterações.
# Dependências: select-theme.sh
# =====================================================================================
themeupdate() {
    echo "🎨 Atualizando o tema do Powerlevel10k..."
    
    # Entrar no diretório do dotfiles
    cd "$DOTFILES_DIR" || { echo "❌ Diretório $DOTFILES_DIR não encontrado"; return 1; }

    # Seleciona o tema do Powerlevel10k
    "$DOTFILES_DIR/scripts/select-theme.sh"

    cd $HOME
    echo "🎨 Tema do Powerlevel10k atualizado com sucesso!"
}

# =====================================================================================
# 📁 Função para criar e navegar para diretório
# Uso: mkcd <nome-do-diretorio>
# Exemplo: mkcd projetos/meu-app
# =====================================================================================
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# =====================================================================================
# 🧹 Função para limpar branches Git mescladas
# Uso: gclean
# Exemplo: gclean (remove todas as branches locais já mescladas)
# =====================================================================================
gclean() {
    git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
}

# =====================================================================================
# 🔧 Função para backup de arquivos
# Uso: backup <arquivo>
# Exemplo: backup config.txt (cria config.txt.backup.20251010_143022)
# =====================================================================================
backup() {
    cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# =====================================================================================
# 📦 Função para extrair qualquer arquivo
# Uso: extract <arquivo>
# Exemplos:
#   extract arquivo.tar.gz
#   extract projeto.zip
#   extract backup.7z
#   extract dados.tar.bz2
# Formatos suportados: tar.gz, tar.bz2, zip, rar, 7z, gz, bz2, tar, Z
# =====================================================================================
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
