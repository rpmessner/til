# Claude Code Stores Session History in JSONL Files

Claude Code writes comprehensive session history to `~/.claude/projects/` in JSONL format, regardless of where it's used (terminal, Neovim, etc.).

Location pattern:
```
~/.claude/projects/-home-username-path-to-project/
├── uuid.jsonl           # Main session
├── agent-uuid.jsonl     # Sub-agent sessions
```

The directory name is the project path with `/` replaced by `-`:
- `/home/rpmessner/dev/myproject/`
- Becomes: `-home-rpmessner-dev-myproject`

JSONL format (one JSON object per line):
```json
{"type":"user","message":{"role":"user","content":[...]}}
{"type":"assistant","message":{"role":"assistant","content":[{"type":"tool_use","name":"Bash","input":{"command":"ls"}}]}}
{"type":"user","message":{"role":"user","content":[{"type":"tool_result","tool_use_id":"...","content":"..."}]}}
```

Key fields:
- `type`: "user", "assistant", "tool_result", "file-history-snapshot"
- `message.content[]`: Array of content items
- Tool uses have: `type: "tool_use"`, `name: "Bash|Edit|Write|Read|..."`, `input: {...}`
- `timestamp`: ISO-8601 format
- `sessionId`, `cwd`, `gitBranch`: Context metadata

This is useful for building tools that analyze or display Claude Code history.
