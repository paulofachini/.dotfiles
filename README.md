# .dotfiles

[![Status](https://img.shields.io/badge/status-active-brightgreen)](https://github.com/paulofachini/.dotfiles) [![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE) [![Zsh](https://img.shields.io/badge/Zsh-5.9-blueviolet)](https://www.zsh.org/) [![Node.js](https://img.shields.io/badge/Node.js-18-green)](https://nodejs.org/) [![Python](https://img.shields.io/badge/Python-3.12-blue)](https://www.python.org/) [![Docker](https://img.shields.io/badge/Docker-24.0.5-blue)](https://www.docker.com/) [![Git](https://img.shields.io/badge/Git-2.42-red)](https://git-scm.com/)

**Este repositório contém meus arquivos de configuração do `zsh` para o ambiente de desenvolvimento `WSL/Ubuntu`, organizados de forma modular, portátil e versionável.**

## Principais Características

- Oh My Zsh com Powerlevel10k.
- Plugins externos: `zsh-autosuggestions` e `zsh-syntax-highlighting`.
- Variáveis de ambiente e PATH para Node, Python e Go.
- Aliases e helpers para Docker, Git e NPM.
- Histórico e opções avançadas do Zsh.
- Configurações de tema Powerlevel10k com Instant Prompt para inicialização rápida.
- Symlink do `.p10k.zsh` garantindo compatibilidade e versionamento.

---

## Estrutura do Repositório

```text
~/.dotfiles/
├── install.sh        → Script para criar symlinks no diretório home
└── zsh
    ├── .p10k.zsh     → Configuração Powerlevel10k versionada
    ├── .zshrc        → Carrega todos os módulos
    ├── aliases.zsh   → Aliases para Git, Docker, Node/NPM
    ├── languages.zsh → Node/NVM, Python/pyenv, Go
    ├── path.zsh      → Variáveis de ambiente e PATH
    ├── plugins.zsh   → Oh My Zsh + plugins externos
    ├── setup.zsh     → Configurações iniciais do Powerlevel10k, histórico e autocompletion
    └── theme.zsh     → Powerlevel10k e configuração do `~/.p10k.zsh`
```

---

## Instalação Rápida

```bash
# Clonar o repositório no home do WSL
git clone https://github.com/paulofachini/.dotfiles.git ~/.dotfiles

# Tornar o script executável
chmod +x ~/.dotfiles/install.sh

# Executar o script
~/.dotfiles/install.sh

# Reiniciar o terminal ou aplicar alterações
source ~/.zshrc
```

---

## Detalhes da Instalação

O script `install.sh` fará o seguinte:

- Remoção de arquivos `.zshrc` e `.p10k.zsh` antigos ou symlinks existentes
- Cria symlinks para os arquivos do `.dotfiles`
- Garantia do Instant Prompt do Powerlevel10k no topo
- Preparação do cache necessário para autocomplete e Powerlevel10k

## Plugins externos

Certifique-se de ter instalado os seguintes plugins no seu $HOME/.zsh:

- `zsh-autosuggestions`

  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  ```

- `zsh-syntax-highlighting`

  ```bash
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
  ```

  > O script de instalação não instala plugins externos automaticamente, mas ignora o source se não existirem.

## Personalização

- Powerlevel10k: para reconfigurar, rode:

```bash
p10k configure
```

- Aliases, PATH e variáveis de ambiente: edite os arquivos dentro de `zsh/`:

  - `aliases.zsh`
  - `languages.zsh`
  - `path.zsh`

- Opções do shell e histórico: `setup.zsh`
- Tema e Powerlevel10k: `theme.zsh`

## Licença

Este repositório é de uso pessoal, mas sinta-se à vontade para se inspirar.
