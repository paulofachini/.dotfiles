> [EN] English version available here: [README.en.md](./README.en.md)

![dotfiles](images/dotfiles-banner.png)

# 🧰 Repositório de `.dotfiles`

**Este repositório contém meus arquivos de configuração (dotfiles) para o ambiente de desenvolvimento, utilizando `zsh`, `Oh My Zsh` e `Powerlevel10k`.**

O objetivo é ter um ambiente produtivo, bonito e facilmente replicável com um único comando.

| Plataforma              | Status                         | Shell             |
| ----------------------- | ------------------------------ | ----------------- |
| 🐧 Linux / WSL (Ubuntu) | ✅ Suportado                   | `zsh` + Oh My Zsh |
| 🪟 Windows (Git Bash)   | ✅ Suportado                   | `zsh` + Oh My Zsh |
| 🍎 macOS                | 🚧 Em desenvolvimento (Fase 3) | `zsh` + Oh My Zsh |

## ✨ Características

- **Instalação Automatizada**: Um único comando para configurar todo o ambiente.
- **Tema Powerlevel10k**: Altamente customizável, com seleção interativa de temas e excelente performance.
- **Plugins Essenciais**: `zsh-autosuggestions` e `zsh-syntax-highlighting` instalados automaticamente.
- **Estrutura Modular**: Configurações separadas para `aliases`, `funções`, `path` e `linguagens`.
- **Atualizações Fáceis**: Comando `dotfiles_update` para sincronizar suas configurações com o repositório.
- **Configurações Locais**: Suporte para um arquivo `.zshrc.local` para suas configurações privadas e não versionadas.
- **Comandos Principais**: Funções como `dotfiles_help`, `dotfiles_update`, `dotfiles_theme` e `dotfiles_reload` para facilitar manutenção e personalização.
- **Testes Automatizados via Docker**: Validação do ambiente em container para garantir funcionamento em ambiente limpo.
- **Compatibilidade Total**: Otimizado para WSL/Ubuntu e Windows (Git Bash). Suporte a macOS em desenvolvimento (Fase 3).

---

## 🚀 Instalação

### 📌 Pré-requisitos

Antes de começar, garanta que você tenha:

- **Fonte Nerd Font**: Instale a fonte **[MesloLGS NF](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k)** e **configure-a como padrão** no seu terminal.
- **Linux / WSL**: execute o instalador no terminal Bash.
- **Windows**:
  instale o Git for Windows manualmente com `winget install --id Git.Git -e --source winget`.
- **Windows**:
  crie um perfil `Git Bash` no Windows Terminal apontando para `C:\Program Files\Git\bin\bash.exe`, com diretório inicial `%USERPROFILE%`, ícone `C:\Program Files\Git\mingw64\share\git\git-for-windows.ico` e a opção para executar como Administrador ativada.
- **Windows**:
  execute o instalador nesse perfil do Git Bash no Windows Terminal, não no PowerShell.

### ⚡️ Instalação com Um Comando

Para configurar um novo ambiente, cole o comando abaixo no terminal correto da sua plataforma (Bash no Linux/WSL ou Git Bash no Windows). Ele cuidará de tudo para você.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/paulofachini/.dotfiles/main/scripts/install.sh)"
```

O script de instalação fará o seguinte:

- **Linux / WSL (Ubuntu)**:
  instala dependências com `apt`, configura `locale` `pt_BR.UTF-8` e define o `zsh` como shell padrão.
- **Windows (Git Bash)**:
  instala `zsh` globalmente no Git for Windows usando o perfil elevado do Git Bash.
- **Ambos**:
  instala Oh My Zsh, plugins, tema Powerlevel10k, clona/atualiza `~/.dotfiles` e cria os symlinks de configuração.

Ao final, **reinicie seu terminal** para que todas as mudanças tenham efeito.

### 🪟 Configurando o perfil Git Bash no Windows Terminal

Se o perfil ainda não existir, adicione-o manualmente no Windows Terminal:

- Abra o Windows Terminal.
- Clique na seta para baixo da barra superior e abra Configurações, ou use `Ctrl + ,`.
- Na lateral esquerda, clique em adicionar um novo perfil.
- Crie um perfil vazio.
- Preencha os campos com os valores abaixo e salve.

```json
{
  "commandline": "C:\\Program Files\\Git\\bin\\bash.exe",
  "elevate": true,
  "icon": "C:\\Program Files\\Git\\mingw64\\share\\git\\git-for-windows.ico",
  "name": "Git Bash",
  "startingDirectory": "%USERPROFILE%"
}
```

---

## 🖥️ Comandos Principais

Após a instalação, você pode utilizar comandos práticos para gerenciar e personalizar seu ambiente:

| Comando           | O que faz                                                                                    |
| ----------------- | -------------------------------------------------------------------------------------------- |
| `dotfiles_help`   | Exibe uma lista de comandos úteis e ajuda dos `.dotfiles`.                                   |
| `dotfiles_update` | Atualiza o repositório dos `.dotfiles`, aplica as últimas configurações e restaura symlinks. |
| `dotfiles_theme`  | Abre o seletor interativo de tema Powerlevel10k para personalizar o visual do terminal.      |
| `dotfiles_reload` | Recarrega o Zsh aplicando imediatamente as alterações feitas nos arquivos de configuração.   |

Esses comandos estão disponíveis automaticamente após a instalação e facilitam a manutenção e personalização do seu ambiente.

---

## 🔄 Atualizando as Configurações

Para manter suas configurações atualizadas com as últimas mudanças do repositório, basta executar o comando:

```shell
dotfiles_update
```

Este comando (um alias para a função `dotupdate()`) irá automaticamente baixar as novidades, recriar os symlinks e recarregar seu shell.

---

## 🎨 Personalização de Temas

### 🖌️ Selecionando um dos Temas pré-definidos

Para escolher um dos temas pré-definidos do `.dotfiles`, execute o seguinte comando:

```shell
dotfiles_theme
```

Este comando abrirá um seletor interativo onde você poderá escolher entre os temas disponíveis:

- **🧼 Clean**: Visual limpo e minimalista.
- **🌑 Darkest**: Tema escuro.
- **🌈 Rainbow**: Tema colorido.

Após selecionar o tema, o script irá gerar o arquivo `.p10k.zsh` necessário com as configurações correspondentes.

### ✏️ Criando o seu próprio tema com o Powerlevel10k

Caso você não queira nenhum dos temas disponíveis, você pode criar o seu próprio tema.
Para isso utilize o comando do próprio Powerlevel10k, executando no terminal:

```shell
p10k configure
```

---

## 🛠️ Personalização das Configurações

A estrutura modular facilita a personalização. Você pode editar os seguintes arquivos:

- **`zsh/aliases.zsh`**: Adicione seus próprios atalhos de linha de comando.
- **`zsh/functions.zsh`**: Crie funções de shell mais complexas.
- **`zsh/path.zsh`**: Modifique o `$PATH` e outras variáveis de ambiente.
- **`zsh/languages.zsh`**: Configure as ferramentas para suas linguagens de programação.
- **`.zshrc.local`**: Crie este arquivo no seu `$HOME` para adicionar configurações **privadas** que não devem ir para o repositório (como chaves de API).
- **`os/linux/symlinks.conf`**: Arquivo de manifesto que define quais arquivos do repositório devem ser linkados para o seu `$HOME` no Linux/WSL.

### 🔗 Gerenciando Links Simbólicos com `os/<plataforma>/symlinks.conf`

**Formato do arquivo:**

Cada plataforma possui seu próprio arquivo de symlinks dentro da pasta `os/`: `os/linux/symlinks.conf`, `os/windows/symlinks.conf`, `os/macos/symlinks.conf`. O script `restore.sh` detecta o OS automaticamente e usa o arquivo correto.

Cada linha representa um link simbólico e segue o formato:

```text
# Formato: <arquivo_no_repo> <destino_no_home>
zsh/.zshrc      .zshrc
zsh/.p10k.zsh   .p10k.zsh
git/.gitconfig  .gitconfig
```

Você pode adicionar outros arquivos seguindo esse padrão. Comentários (linhas iniciadas com `#`) são permitidos.

**Exemplo Prático: Adicionando seu `.gitconfig`**

1. **Crie o arquivo** dentro do seu repositório. Por exemplo, você pode criar uma pasta `git` e colocar seu arquivo de configuração lá: `~/.dotfiles/git/.gitconfig`.
2. **Adicione a entrada** no `os/linux/symlinks.conf`:

   ```text
   zsh/.zshrc .zshrc
   zsh/.p10k.zsh .p10k.zsh
   git/.gitconfig .gitconfig
   ```

3. **Execute a atualização**:

   ```shell
   dotfiles_update
   ```

   O script irá criar automaticamente o link simbólico de `~/.gitconfig` para `~/.dotfiles/git/.gitconfig`.

4. **Execute o comando para recarregar as configurações**:

```shell
dotfiles_reload
```

---

## 🧪 Testando com Docker

Para garantir que os scripts de instalação funcionem corretamente em um ambiente limpo e isolado, você pode usar o `Dockerfile` incluído no projeto. O sistema executa automaticamente a instalação completa e valida se tudo está funcionando.

**O que é validado:**

- ✅ **Links simbólicos**: Verifica se todos os .dotfiles estão corretamente linkados para o diretório `$HOME`
- ✅ **Carregamento do Zsh**: Testa se o shell Zsh consegue carregar todas as configurações sem erros
- ✅ **Plugins instalados**: Confirma que os plugins `zsh-autosuggestions` e `zsh-syntax-highlighting` estão presentes

- **Construa a imagem Docker:**
  Na raiz do projeto, execute o comando para criar a imagem de teste.

  ```shell
  docker build -t dotfiles-test .
  ```

- **Execute os testes automatizados:**
  Este comando sobrescreve o CMD padrão e executa apenas a instalação e validação automatizada, saindo após os testes:

  ```shell
  docker run --rm dotfiles-test /bin/bash -c "chmod +x .dotfiles/scripts/install.sh .dotfiles/scripts/test.sh && .dotfiles/scripts/install.sh && .dotfiles/scripts/test.sh"
  ```

- **Teste interativo (opcional):**
  Este comando usa o CMD padrão do container, que executa instalação, testes E abre um shell Zsh interativo para exploração manual:

  ```shell
  docker run -it --rm dotfiles-test
  ```

---

## 🧪 Testando Instalação com Um Comando

Para testes em branch (antes de mergear na `main`), use a mesma branch na URL e na variável `DOTFILES_REF`:

```bash
DOTFILES_REF=feature/sua-branch bash -c "$(curl -fsSL https://raw.githubusercontent.com/paulofachini/.dotfiles/feature/sua-branch/scripts/install.sh)"
```

Isso evita ambiguidade e garante que o instalador baixe os scripts auxiliares da mesma branch.

---

## 📂 Estrutura do Projeto

```text
.dotfiles/
├── git/
│   └── .gitconfig               → Configurações do Git (ex: nome de usuário, e-mail, aliases).
├── os/
│   ├── linux/                   → Configurações específicas do Linux/WSL.
│   │   ├── .wslconfig_desktop   → Configurações do WSL do Desktop.
│   │   ├── .wslconfig_note      → Configurações do WSL do Notebook.
│   │   └── symlinks.conf        → Symlinks do Linux/WSL.
│   ├── windows/                 → Configurações específicas do Windows (Git Bash).
│   │   └── symlinks.conf        → Symlinks do Windows.
│   └── macos/                   → Configurações específicas do macOS (Fase 3).
│       └── symlinks.conf        → Symlinks do macOS (Fase 3).
├── scripts/
│   ├── banner.sh                → Exibe uma mensagem de boas-vindas personalizada.
│   ├── install.sh               → Script principal de instalação (detecta o OS automaticamente).
│   ├── install-zsh-gitbash.sh   → Instala zsh via pacotes MSYS2 no Git Bash (Windows).
│   ├── messages.sh              → Mensagens auxiliares exibidas ao final da instalação.
│   ├── restore.sh               → Script para restaurar e criar os symlinks no diretório `$HOME`.
│   ├── select-theme.sh          → Script para selecionar o tema do Powerlevel10k.
│   ├── test.sh                  → Testes automatizados para validar a instalação.
│   └── utils.sh                 → Funções utilitárias compartilhadas (detect_os, is_wsl, etc.).
├── zsh/
│   ├── .p10k-clean.zsh          → Tema Powerlevel10k (visual limpo).
│   ├── .p10k-darkest.zsh        → Tema Powerlevel10k (visual escuro).
│   ├── .p10k-rainbow.zsh        → Tema Powerlevel10k (visual colorido).
│   ├── .zshrc                   → Ponto de entrada que carrega todos os outros módulos.
│   ├── aliases.zsh              → Aliases para Git, Docker, Node/NPM.
│   ├── functions.zsh            → Funções customizadas (como `dotupdate`).
│   ├── languages.zsh            → Node/NVM, Python/pyenv, Go.
│   ├── path.zsh                 → Variáveis de ambiente e PATH.
│   ├── plugins.zsh              → Oh My Zsh + plugins externos.
│   ├── setup.zsh                → Configurações do Powerlevel10k, histórico e autocompletion.
│   └── theme.zsh                → Define e carrega o tema Powerlevel10k.
├── Dockerfile                   → Dockerfile para testes automatizados em ambiente isolado.
├── LICENSE                      → Licença do projeto.
├── README.en.md                 → Este arquivo em Inglês.
└── README.md                    → Este arquivo em Português.
```

## 🖼️ Imagens

### Temas (🧼 Clean / 🌑 Darkest / 🌈 Rainbow)

![dotfiles_theme](images/dotfiles-theme.png)

### Atualização

![dotfiles_update](images/dotfiles-update.png)

### VS Code Terminal

![VS Code Terminal](images/vscode-terminal.png)

### Windows Terminal

![Windows Terminal](images/windows-terminal.png)

## ©️ Licença

Este repositório é de uso pessoal, mas sinta-se à vontade para se inspirar.
Ele está licenciado sob a licença MIT. Veja o arquivo [LICENSE](./LICENSE) para mais detalhes.
