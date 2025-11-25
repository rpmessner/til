---
published: true
---

# Use Dual Prefix to Prevent Accidental Ctrl+Z Suspend

Accidentally hitting Ctrl+Z in a tmux pane suspends the foreground process, which is rarely what you want. Instead of trying to rebind or disable Ctrl+Z at the application level, intercept it at the tmux level as a secondary prefix key.

```tmux
set -g prefix C-s
set -g prefix2 C-z
bind C-s send-prefix
bind C-z send-prefix -2
```

Now Ctrl+Z becomes a harmless prefix key waiting for a second keystroke. If you hit it by accident, nothing happens until you press another key (or it times out).

Benefits:
- Prevents accidental process suspension
- Ctrl+Z still works as prefix for tmux commands
- No need to modify shell or application settings
- Easy to remember: both prefixes work identically
