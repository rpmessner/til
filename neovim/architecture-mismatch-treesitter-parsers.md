---
published: true
---

# Rebuild Treesitter Parsers After Architecture Change

Treesitter parsers are compiled binaries specific to CPU architecture. When migrating between Intel and Apple Silicon Macs (or running under Rosetta), parsers will fail with cryptic errors.

Symptoms:
- `:TSInstall` hangs or errors
- Syntax highlighting stops working
- Errors about "wrong architecture" or "bad CPU type"

Fix:

```bash
# Delete existing parsers
rm -rf ~/.local/share/nvim/site/parser/

# Rebuild all parsers for current architecture
nvim -c "TSInstall! all" -c "qa"
```

Or from within Neovim:
```vim
:TSInstall! all
```

The `!` forces reinstallation even if parsers exist. This rebuilds every parser for your current CPU architecture.

This also applies when:
- Switching between native and Rosetta terminal
- Moving nvim config between different machines
- Updating to a new major Neovim version
