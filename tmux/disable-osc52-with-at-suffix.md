---
published: false
---

# Disable tmux Terminal Features with @ Suffix

Disable specific tmux terminal features using the `@` suffix. This prevents conflicts when using platform-specific tools (like clip.exe for WSL2 clipboard).

```tmux
# Disable OSC 52 clipboard for xterm-compatible terminals
set -as terminal-features 'xterm*:clipboard@'
```

The `@` suffix explicitly disables the feature. Use `set -as` (append to server option) rather than indexed assignment to avoid pollution on config reload.

Common features to disable:
- `clipboard@` - OSC 52 clipboard (when using platform-specific clipboard tools)
- `hyperlinks@` - OSC 8 hyperlinks
- `title@` - Window title setting

To see current terminal features:
```bash
tmux show -s terminal-features
```
