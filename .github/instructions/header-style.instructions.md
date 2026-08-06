---
description: Header standard for scripts and config files
applyTo: "scripts/*.sh,zsh/*.zsh,zsh/.zshrc,os/*/symlinks.conf,os/linux/.wslconfig_*,git/.gitconfig,.gitattributes"
---

Use the following header standard when creating or updating files covered by `applyTo`.

## Required fields

- Separator line (top and bottom): `# =====================================================================================`
- Title line: `# <icon> <file-name> - <short description>`
- `# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>`
- `# Data: <Mes Ano>` or `# Data: <Mes Ano> | Atualizado: <Mes Ano>`
- `# Versão: <x.y.z>`
- `# Licença: MIT`

## Optional fields by file type

- Scripts (`scripts/*.sh`): include `# Uso:` and usually `# Dependências:`.
- Main installer (`scripts/install.sh`): include `# Plataformas:`.
- Manifest/config files (`os/*/symlinks.conf`, `.wslconfig_*`): include format/note lines when useful.
- Zsh modules: `# Dependências:` is optional and recommended when external tools are expected.

## Header template

For shell scripts, keep shebang on line 1 and place header next:

```sh
#!/bin/bash
# =====================================================================================
# <icon> <file-name> - <short description>
#
# <1-3 lines of purpose>
# - <optional bullet>
# - <optional bullet>
#
# Uso: <how to run/use>                          # optional depending on file type
# Dependências: <list>                           # optional depending on file type
# Plataformas: <list>                            # optional depending on file type
# Formato: <specification>                       # optional depending on file type
# Nota: <important note>                         # optional depending on file type
#
# Autor: Paulo Luiz Fachini <paulofachini@gmail.com>
# Data: <Mes Ano> | Atualizado: <Mes Ano>
# Versão: <x.y.z>
# Licença: MIT
# =====================================================================================
```

For non-shell files that already use `#` comments, use the same block without shebang.

## Update rules

- Preserve existing meaningful summary text.
- Add only missing required fields.
- Do not change generated headers in Powerlevel10k files (`zsh/.p10k-*.zsh`).
- Preserve emojis and correct Portuguese accentuation in headers.
