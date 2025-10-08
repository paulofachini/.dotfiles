# =====================================================================================
# Script de instalação do .dotfiles no $HOME
# Autor: Paulo Luiz Fachini
# =====================================================================================

DOTFILES_DIR="$HOME/.dotfiles"
ZSH_DIR="$DOTFILES_DIR/zsh"

echo "📦 Instalando .dotfiles no $HOME..."

# Criar symlink do .zshrc principal
# Verifica se existe e remove
if [ -e "$HOME/.zshrc" ] || [ -L "$HOME/.zshrc" ]; then
    echo "🔹 Removendo .zshrc antigo"
    rm -rf "$HOME/.zshrc"
fi

echo "🔗 Criando symlink .zshrc -> $ZSH_DIR/.zshrc"
ln -s "$ZSH_DIR/.zshrc" "$HOME/.zshrc"
echo "✅ Novo symlink .zshrc criado"

# Criar symlink do .p10k.zsh do Powerlevel10k
# Verifica se existe e remove
if [ -e "$HOME/.p10k.zsh" ] || [ -L "$HOME/.p10k.zsh" ]; then
    echo "🔹 Removendo .p10k.zsh antigo"
    rm -rf "$HOME/.p10k.zsh"
fi

# Cria o novo symlink apontando para o .dotfiles
echo "🔗 Criando symlink .p10k.zsh -> $ZSH_DIR/.p10k.zsh"
ln -sf "$ZSH_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
echo "✅ Novo symlink .p10k.zsh criado"

# Criar cache do Powerlevel10k
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"

echo "✅ .dotfiles instalado com sucesso!"
echo "Abra um novo terminal ou rode 'source ~/.zshrc' para aplicar as alterações."
