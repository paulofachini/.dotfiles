---
description: Keep README.pt-BR and README.en synchronized
applyTo: "README.md,README.en.md"
---

Always keep `README.md` (PT-BR) and `README.en.md` (EN) semantically synchronized.

## Mandatory sync rules

- Any change to installation flow in one README must be mirrored in the other in the same commit.
- Any change to prerequisites in one README must be mirrored in the other in the same commit.
- Any change to one-command install examples in one README must be mirrored in the other in the same commit.
- Any change to platform-specific guidance (Linux/WSL, Windows, macOS) in one README must be mirrored in the other in the same commit.

## Allowed differences

- Natural language translation differences are allowed.
- Section titles may differ by language.
- Do not translate commands, paths, flags, environment variables, URLs, or JSON keys.

## Practical checklist before finishing edits

- Verify both files contain equivalent prerequisites.
- Verify both files contain equivalent installation steps.
- Verify both files contain equivalent Windows Terminal profile guidance when applicable.
- Verify shell commands are exactly the same in both files.

## Update policy

- If only one README was edited in a way that changes behavior or instructions, update the other README immediately.
- Do not leave README synchronization for a later commit.
