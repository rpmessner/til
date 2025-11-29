---
published: false
---

# CodeMirror 6 Keymap Priority

CodeMirror 6's `defaultKeymap` includes `Mod-Enter` mapped to `insertBlankLine`. On Linux, `Mod` resolves to `Ctrl`, so Ctrl+Enter gets consumed before custom keymaps can handle it.

The fix: place custom keymaps FIRST in the extensions array. Extensions are processed in order, and the first matching keymap wins.

```javascript
// Wrong - defaultKeymap consumes Ctrl+Enter first
const extensions = [
  lineNumbers(),
  keymap.of([...defaultKeymap, ...historyKeymap]),
  createEvalKeymap(),  // Never sees Ctrl+Enter
];

// Right - custom keymap gets first chance
const extensions = [
  createEvalKeymap(),  // Handles Ctrl+Enter
  lineNumbers(),
  keymap.of([...defaultKeymap, ...historyKeymap]),
];
```

This applies to any keybinding conflict with defaultKeymap - check what's bound before wondering why your custom handler isn't firing.
