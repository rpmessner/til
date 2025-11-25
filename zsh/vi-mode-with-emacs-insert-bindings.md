---
published: true
---

# ZSH Vi-Mode with Emacs Insert Keybindings

Get the best of both worlds: vim-style navigation in normal mode (hjkl, w, b) while keeping familiar emacs keybindings in insert mode (Ctrl+A, Ctrl+E, Ctrl+R).

```zsh
# Enable vi mode
bindkey -v

# Keep emacs bindings in insert mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history

# Fast escape to normal mode (reduce timeout)
export KEYTIMEOUT=1
```

The `-M viins` flag targets vi insert mode specifically, leaving normal mode (vicmd) with standard vim bindings.

Benefits:
- Muscle memory from emacs mode preserved
- Full vim navigation when you want it
- Press Escape for normal mode, hjkl to navigate, then i to insert
