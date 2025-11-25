---
published: true
---

# Strip CRLF Line Endings in WSL2 Shell Completions

WSL2 files often have CRLF line endings from Windows editors. When parsing files for shell completion, carriage returns pollute the completion list with escape characters.

```zsh
# BAD: CRLF causes ^M characters in completions
h=(${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})

# GOOD: Strip \r with parameter expansion
h=(${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*[*?]*}//$'\r'/})
zstyle ':completion:*:ssh:*' hosts $h
```

The `//$'\r'/` at the end removes all carriage return characters.

This pattern applies anywhere you're parsing text files for completion in WSL2:
- SSH config hosts
- Known hosts
- Custom completion sources from config files
