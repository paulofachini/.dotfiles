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
# 🧰 .dotfiles aliases para as funções
# =====================================================================================
alias dotfiles_help="dothelp"
alias dotfiles_update="dotupdate"
alias dotfiles_theme="themeupdate"
alias dotfiles_reload='source ~/.zshrc'
alias dotfiles_ghtoken="ghtoken"

# =====================================================================================
# ℹ️ Função para exibir ajuda dos .dotfiles
# Uso: dothelp
# Alias: dotfiles_help
# Exemplo: dotfiles_help (exibe a ajuda dos .dotfiles)
# Descrição: Mostra uma lista de comandos disponíveis para gerenciar os .dotfiles.
# Dependências: N/A
# =====================================================================================
dothelp() {
    VERDE='\033[38;2;0;255;0m'
    AMARELO='\033[38;2;255;255;0m'
    BOLD='\033[1m'
    RESET='\033[0m'
    
    printf "\n"
    printf "${BOLD}ℹ️ Ajuda .dotfiles\n\n"
    printf "${BOLD}Comandos disponíveis:${RESET}\n"
    printf "  • ${VERDE}dotfiles_help${RESET}: Mostra esta ajuda\n"
    printf "  • ${VERDE}dotfiles_update${RESET}: Atualiza os dotfiles\n"
    printf "  • ${VERDE}dotfiles_theme${RESET}: Altera o tema do Powerlevel10k\n"
    printf "  • ${VERDE}dotfiles_ghtoken${RESET}: Configura GitHub CLI token\n"
    printf "  • ${VERDE}dotfiles_reload${RESET}: Recarrega o Zsh (${AMARELO}source ~/.zshrc${RESET})\n\n"
}

# =====================================================================================
# 🔄 Função para atualizar os .dotfiles
# Uso: dotupdate [branch]
# Alias: dotfiles_update
# Exemplo: dotupdate (atualiza usando a branch main)
# Exemplo: dotupdate develop (atualiza usando a branch develop)
# Descrição: Atualiza o repositório dos .dotfiles, aplica as alterações
# e restaura as configurações personalizadas.
# Esta função também atualiza o tema do Powerlevel10k e executa o script de
# restauração restore.sh.
# Ela é útil para manter o ambiente de desenvolvimento sempre atualizado com as últimas
# configurações e temas.
# Dependências: select-theme.sh, restore.sh, banner.sh
# =====================================================================================
dotupdate() {
    local target_branch="${1:-main}"

    echo "📦 Atualizando o repositório dos .dotfiles..."
    echo "🌿 Branch alvo: $target_branch"
    
    # Entrar no diretório do .dotfiles
    cd "$DOTFILES_DIR" || { echo "❌ Diretório $DOTFILES_DIR não encontrado"; return 1; }

    # Buscar alterações do remoto
    git fetch origin || { echo "❌ Falha ao buscar alterações do remoto"; cd "$HOME"; return 1; }

    # Validar que a branch existe no remoto
    if ! git show-ref --verify --quiet "refs/remotes/origin/$target_branch"; then
        echo "❌ Branch origin/$target_branch não encontrada no remoto"
        cd "$HOME"
        return 1
    fi

    # Garantir que a branch local alvo exista e esteja ativa
    if git show-ref --verify --quiet "refs/heads/$target_branch"; then
        git switch "$target_branch" || { echo "❌ Falha ao trocar para a branch $target_branch"; cd "$HOME"; return 1; }
    else
        git switch -c "$target_branch" --track "origin/$target_branch" || { echo "❌ Falha ao criar branch $target_branch rastreando origin/$target_branch"; cd "$HOME"; return 1; }
    fi

    # Sincronizar branch local com a branch remota
    git reset --hard "origin/$target_branch" || { echo "❌ Falha ao sincronizar $target_branch com origin/$target_branch"; cd "$HOME"; return 1; }
    git clean -fdx || { echo "❌ Falha ao limpar arquivos não rastreados"; cd "$HOME"; return 1; }
    cd "$HOME"

    themeupdate

    # Restaurar symlinks e configurações
    echo "🔄 Aplicando as configurações com script de restauração restore.sh..."
    "$DOTFILES_DIR/scripts/restore.sh"
    echo "🎉 .dotfiles atualizados com sucesso!"

    # Banner de boas-vindas
    "$DOTFILES_DIR/scripts/banner.sh"
}

# =====================================================================================
# 🎨 Função para alterar o tema do Powerlevel10k
# Uso: themeupdate
# Alias: dotfiles_theme
# Exemplo: themeupdate (atualiza o tema do Powerlevel10k)
# Descrição: Permite ao usuário escolher um novo tema para o Powerlevel10k
# e aplica as alterações.
# Dependências: select-theme.sh
# =====================================================================================
themeupdate() {
    echo "🎨 Atualizando o tema do Powerlevel10k..."
    
    # Entrar no diretório do .dotfiles
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

# =====================================================================================
# 🐙 Função para configurar GitHub CLI token
# Uso: ghtoken
# Alias: dotfiles_ghtoken
# Descrição: Configura o GH_TOKEN no arquivo ~/.zshrc.local de forma interativa.
# O token é salvo de forma segura com permissões restritas (600).
# O arquivo .zshrc.local persiste mesmo quando atualiza os dotfiles.
# Dependências: gh (GitHub CLI)
# =====================================================================================
ghtoken() {
    echo ""
    echo "🐙 Configuração do GitHub CLI"
    echo ""
    echo "Para usar comandos como 'gh pr create', você precisa de um token GitHub."
    echo ""
    echo "📚 Como gerar um token:"
    echo "   1. Acesse: https://github.com/settings/personal-access-tokens"
    echo "   2. Clique em 'Generate new token'"
    echo "   3. Selecione as permissões: repo, read:org"
    echo "   4. Copie o token (aparece só uma vez!)"
    echo ""

    # Pergunta se tem o token
    local resposta
    read -k 1 "?👉 Você já tem um token GitHub? (s/n): " resposta
    echo ""
    echo ""

    if [[ ! "$resposta" =~ ^[Ss]$ ]]; then
        echo "ℹ️ Tudo bem! Você pode gerar um token depois e executar esta função novamente."
        echo ""
        return 0
    fi

    local token
    read -s "?🔑 Cole seu token GitHub (será ocultado): " token
    echo ""
    echo ""

    if [[ -z "$token" ]]; then
        echo "❌ Token vazio. Operação cancelada."
        echo ""
        return 1
    fi

    local zshrc_local="$HOME/.zshrc.local"

    # Criar .zshrc.local se não existir
    if [[ ! -f "$zshrc_local" ]]; then
        cat > "$zshrc_local" << 'EOF'
# =====================================================================================
# 🔐 .zshrc.local - Configurações locais (não versionado)
#
# Este arquivo é carregado automaticamente ao final do .zshrc
# e persiste mesmo quando você atualiza os dotfiles.
# Use-o para variáveis de ambiente, tokens e configurações pessoais.
#
# =====================================================================================

EOF
        chmod 600 "$zshrc_local"
    fi

    # Validar que o arquivo existe
    if [[ ! -f "$zshrc_local" ]]; then
        echo "❌ Não foi possível criar $zshrc_local"
        echo ""
        return 1
    fi

    # Atualizar ou adicionar o token
    if grep -q "export GH_TOKEN=" "$zshrc_local"; then
        # Token já existe, atualizar
        sed -i.bak "s|export GH_TOKEN=.*|export GH_TOKEN=\"$token\"|g" "$zshrc_local"
        rm -f "$zshrc_local.bak"
    else
        # Token não existe, adicionar
        echo "" >> "$zshrc_local"
        echo "# GitHub CLI Token" >> "$zshrc_local"
        echo "export GH_TOKEN=\"$token\"" >> "$zshrc_local"
    fi

    # Validar token
    echo "🔍 Validando token GitHub..."
    if GH_TOKEN="$token" gh auth status >/dev/null 2>&1; then
        echo "✅ Token validado com sucesso!"
        echo ""

        # Carregar na sessão atual
        export GH_TOKEN="$token"

        echo "🐙 GitHub CLI configurado!"
        echo "   Arquivo: $zshrc_local"
        echo "   Você já pode usar: gh pr create, gh issue list, etc."
        echo ""
        return 0
    else
        echo "❌ Token inválido ou expirado"
        echo ""
        echo "Verifique se o token:"
        echo "  • Está correto (copie novamente da página de tokens)"
        echo "  • Não expirou"
        echo "  • Tem as permissões corretas (repo, read:org)"
        echo ""
        return 1
    fi
}
