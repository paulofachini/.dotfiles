# Copilot Instructions for this Repository

These instructions apply to all AI-assisted edits in this repository.

## Source of truth

- Follow the header standard in `.github/instructions/header-style.instructions.md`.

## Mandatory behavior

- When creating a new file in the covered paths, include the standardized header.
- When editing an existing file in the covered paths:
  - Keep the existing header block.
  - If missing required fields, add only the missing fields.
  - Do not remove meaningful summary lines.
- Keep changes minimal and focused; avoid unrelated reformatting.

## Exceptions

- Do not overwrite auto-generated headers in Powerlevel10k generated files:
  - `zsh/.p10k-clean.zsh`
  - `zsh/.p10k-darkest.zsh`
  - `zsh/.p10k-rainbow.zsh`

## Language

- Prefer Portuguese (pt-BR) in comments and commit messages, unless the target file is clearly English-first.
