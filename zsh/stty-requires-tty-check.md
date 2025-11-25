---
published: true
---

# Check for TTY Before Running stty Commands

Commands like `stty` that modify terminal settings fail in non-interactive contexts (shell spawning, piped commands, scripts). Always check if stdin is a TTY first:

```zsh
# BAD: Fails when shell is spawned non-interactively
stty -ixon

# GOOD: Only runs when stdin is a TTY
if [[ -t 0 ]]; then
  stty -ixon  # Disable flow control
fi
```

The `[[ -t 0 ]]` test checks if file descriptor 0 (stdin) is connected to a terminal.

Common stty settings that need this guard:
- `stty -ixon` - Disable Ctrl+S/Ctrl+Q flow control
- `stty erase ^?` - Set backspace behavior
- `stty susp undef` - Disable Ctrl+Z suspend
