# Session: Mining Dotfiles Sessions for TILs

**Date:** 2025-11-24

## Summary

Mined `~/.dotfiles/docs/sessions/` for TIL-worthy content and created 7 new TILs. Also updated the Makefile scrub task to call Claude Code directly and save output to timestamped files.

## New TILs Created

### tmux (2)
- `tmux/dual-prefix-prevents-accidental-suspend.md` - Use prefix2 for Ctrl+Z to prevent accidental process suspension
- `tmux/disable-osc52-with-at-suffix.md` - Disable terminal features with @ suffix in terminal-features

### zsh (3)
- `zsh/stty-requires-tty-check.md` - Guard stty commands with `[[ -t 0 ]]` TTY check
- `zsh/fzf-tab-crlf-handling.md` - Strip `\r` characters in WSL2 shell completions
- `zsh/vi-mode-with-emacs-insert-bindings.md` - Combine vim navigation with emacs insert keybindings

### wsl2 (1)
- `wsl2/clip-exe-for-clipboard.md` - Use clip.exe for WSL2 to Windows clipboard integration

### neovim (1)
- `neovim/architecture-mismatch-treesitter-parsers.md` - Rebuild parsers after Intel/Apple Silicon migration

## Makefile Updates

Updated `make scrub` to:
1. Call Claude Code directly with `--print --output-file`
2. Save output to `docs/scrubs/scrub-YYYYMMDD-HHMMSS.md`

## Source Sessions Analyzed

From `~/.dotfiles/docs/sessions/`:
- 2025-11-21-tmux-escape-sequences-ssh-context.md
- 2025-11-22-zsh-stty-ctrl-z-fixes.md
- 2025-11-22-fzf-tab-ssh-completion-wsl2-fix.md
- 2025-11-23-wsl2-clipboard-integration.md
- 2025-11-24-zsh-vi-mode-implementation.md
- 2025-11-21-erlang-lsp-neovim-architecture-fix.md
- And others...

## Commits

1. Add tmux TILs: dual prefix and disable terminal features
2. Add zsh TILs: stty check, CRLF handling, vi-mode bindings
3. Add WSL2 TIL: clip.exe for clipboard
4. Add neovim TIL: rebuild treesitter after architecture change
5. Update README with new categories and TILs

## Stats

- TILs before: 20
- TILs after: 27
- New categories: tmux, wsl2, zsh
