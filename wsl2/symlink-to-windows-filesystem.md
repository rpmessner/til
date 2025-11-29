---
published: false
---

# Symlink from WSL2 to Windows Filesystem

WSL2 can create symlinks pointing to files on the Windows filesystem via `/mnt/c/`. This enables workflows where tools on Windows (like Obsidian) manage files that WSL2 projects reference.

```bash
# Create/edit file on Windows filesystem from WSL
echo "# Project Context" > /mnt/c/Users/yourname/ObsidianVault/project-context.md

# Symlink from WSL project to Windows file
ln -s /mnt/c/Users/yourname/ObsidianVault/project-context.md ~/dev/myproject/CLAUDE.md

# Reading through symlink works
cat ~/dev/myproject/CLAUDE.md  # Shows content from Windows file

# Edits in Obsidian (Windows) are immediately visible in WSL
```

Useful for:
- Obsidian vault as source of truth for project documentation
- Sharing config between Windows and WSL environments
- Keeping context files in sync across platforms
