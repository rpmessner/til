---
published: true
---

# Use clip.exe for WSL2 to Windows Clipboard

WSL2 can access the Windows clipboard using `/mnt/c/Windows/system32/clip.exe`. Combine this with platform detection for cross-platform configs:

```bash
# Platform detection
if uname -r | grep -qi microsoft; then
  # WSL2
  alias clip='clip.exe'
else
  # macOS
  alias clip='pbcopy'
fi
```

For tmux copy-mode integration:

```tmux
# WSL2: copy to Windows clipboard
if-shell "uname -r | grep -i microsoft" \
  "bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'clip.exe'"

# macOS: copy to system clipboard
if-shell "uname | grep -q Darwin" \
  "bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'"
```

Note: `clip.exe` is write-only. For reading from Windows clipboard, use PowerShell:
```bash
powershell.exe -command "Get-Clipboard"
```
