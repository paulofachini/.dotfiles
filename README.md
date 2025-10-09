# Repositório `.dotfiles`

**Este repositório contém meus arquivos de configuração do `zsh` para o ambiente de desenvolvimento `WSL/Ubuntu`, organizados de forma modular, portátil e versionável.**

## Características

- Oh My Zsh com o tema Powerlevel10k.
- Plugins externos adicionais: `zsh-autosuggestions` e `zsh-syntax-highlighting`.
- Variáveis de ambiente e `PATH` configurados (Node, Python e Go).
- Aliases, helpers e funções personalizadas.
- Histórico e opções avançadas do `.zsh`.

---

## Como usar este repositório

### Pré-requisitos

- [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/pt-br/windows/wsl/install) com Ubuntu.
- [Windows Terminal](https://github.com/microsoft/terminal).
- [Git](https://git-scm.com/).
- [Oh My Zsh](https://ohmyz.sh/#install).
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k).
- Fontes instaladas e configuradas no terminal ([MesloLGS NF](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k)).
- Garanta que o `locale` esteja configurado para `pt_BR.UTF-8`.

  ```bash
  sudo locale-gen pt_BR.UTF-8 && sudo update-locale LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8
  ```

### Estrutura do projeto

```text
~/.dotfiles/
├── restore.sh        → Script para restaurar e criar os symlinks no diretório $HOME
└── zsh
    ├── .p10k.zsh     → Configuração Powerlevel10k
    ├── .zshrc        → Carrega todos os módulos
    ├── aliases.zsh   → Aliases para Git, Docker, Node/NPM
    ├── functions.zsh → Funções customizadas
    ├── languages.zsh → Node/NVM, Python/pyenv, Go
    ├── path.zsh      → Variáveis de ambiente e PATH
    ├── plugins.zsh   → Oh My Zsh + plugins externos
    ├── setup.zsh     → Configurações iniciais do Powerlevel10k, histórico e autocompletion
    └── theme.zsh     → Powerlevel10k e configuração do `~/.p10k.zsh`
```

---

### Instalando as Configurações do `.dotfiles`

Execute o script abaixo para restaurar seu ambiente de desenvolvimento completo,
criando symlinks e aplicando suas configurações do Zsh, Oh My Zsh e Powerlevel10k.

```bash
# Clonar o repositório no diretório $HOME do WSL
git clone https://github.com/paulofachini/.dotfiles.git ~/.dotfiles

# Tornar o script executável
chmod +x ~/.dotfiles/restore.sh

# Executar o script
~/.dotfiles/restore.sh

# Reiniciar o terminal ou aplicar alterações
source ~/.zshrc
```

O script `restore.sh` fará o seguinte:

- Remoção de arquivos `.zshrc` e `.p10k.zsh` antigos ou symlinks existentes.
- Cria symlinks para os arquivos do `.dotfiles`.
- Garantia do Instant Prompt do Powerlevel10k no topo.
- Preparação do cache necessário para autocomplete e Powerlevel10k.

---

### Atualizando as Configurações do `.dotfiles`

Quando houver novas alterações no repositório remoto, siga estes passos para atualizar o seu ambiente:

#### Alternativa automática

Execute o comando `dotupdate` para atualizar e aplicar as mudanças automaticamente:

```bash
dotupdate
```

O comando `dotupdate` fará o seguinte:

- Faz pull do repositório remoto.
- Executa o script `restore.sh`.
- Recarrega e aplica as configurações do Zsh automaticamente.

#### Alternativa manual

```bash
# Entrar no diretório do .dotfiles
cd ~/.dotfiles

# Buscar alterações do repositório remoto e aplicar
git fetch origin
git pull origin main --rebase

# Aplicar as configurações (symlinks, plugins, variáveis, etc.)
~/.dotfiles/restore.sh

# Recarregar o Zsh para aplicar alterações
source ~/.zshrc
```

---

## Plugins externos

Certifique-se de ter instalado os seguintes plugins no seu diretório `~/.oh-my-zsh/custom/plugins`:

- `zsh-autosuggestions`

  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  ```

- `zsh-syntax-highlighting`

  ```bash
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  ```

  > O script de instalação não instala plugins externos automaticamente, mas ignora o source se não existirem.

## Personalização

Você pode personalizar os seguintes aspectos do seu ambiente:

- Powerlevel10k: caso queira reconfigurar o tema, execute o comando abaixo no terminal:

```bash
p10k configure
```

- Para trocar o Tema: edite o arquivo `theme.zsh`

- Aliases, PATH e variáveis de ambiente: edite os arquivos:

  - `aliases.zsh`
  - `languages.zsh`
  - `path.zsh`

- Opções do shell e histórico: edite o arquivo `setup.zsh`
- Plugins customizados do Oh My Zsh: edite o arquivo `plugins.zsh`

## Licença

Este repositório é de uso pessoal, mas sinta-se à vontade para se inspirar.
