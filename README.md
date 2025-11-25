# TIL

> Today I Learned

A collection of concise write-ups on small things I learn day to day across a variety of languages and technologies. Inspired by [jbranchaud/til](https://github.com/jbranchaud/til).

_20 TILs and counting..._

---

### Categories

- [C/C++](#c-cpp)
- [CMake](#cmake)
- [Ecto](#ecto)
- [Elixir](#elixir)
- [Lua](#lua)
- [Neovim](#neovim)
- [OSC](#osc)
- [Phoenix](#phoenix)
- [SuperCollider](#supercollider)
- [Vulkan](#vulkan)
- [WoW](#wow)

---

### C-Cpp

- [Data-Oriented Design Over OOP](c-cpp/data-oriented-over-oop.md)

### CMake

- [Cross-Compile Windows Executables from Linux with MinGW](cmake/cross-compile-windows-from-linux-with-mingw.md)
- [Symlink compile_commands.json for LSP Support](cmake/symlink-compile-commands-for-lsp.md)

### Ecto

- [Fix Race Conditions with Atomic Updates](ecto/fix-race-condition-with-atomic-update.md)

### Elixir

- [CSV Parsing with Quoted Strings Using Regex](elixir/csv-parsing-with-quoted-strings.md)
- [Dual-Mode Library: Embedded vs Remote](elixir/dual-mode-library-embedded-vs-remote.md)
- [Event-Driven Waiting Pattern in GenServers](elixir/event-driven-waiting-pattern.md)
- [Pattern Namespacing with Atoms](elixir/pattern-namespacing-with-atoms.md)
- [Streams for Large File Parsing](elixir/streams-for-large-file-parsing.md)
- [Use Marker Constants Instead of Version-Dependent Strings](elixir/use-marker-constants-not-version-strings.md)

### Lua

- [WoW Addon Drag-and-Drop Widget System](lua/wow-addon-drag-drop-widgets.md)
- [Make WoW Minimap Square with SetMaskTexture](lua/wow-minimap-square-mask.md)

### Neovim

- [Claude Code Stores Session History in JSONL Files](neovim/claude-code-stores-history-in-jsonl.md)

### OSC

- [OSC Bundles with Timestamps for Precise Audio Scheduling](osc/osc-bundles-with-timestamps.md)

### Phoenix

- [Disable Ecto Repo for Non-Database Apps](phoenix/disable-ecto-repo-for-non-database-apps.md)
- [Use LiveView Routes Instead of Controllers](phoenix/liveview-route-instead-of-controller.md)

### SuperCollider

- [SuperDirt is Not a Pattern Parser](supercollider/superdirt-is-not-a-pattern-parser.md)
- [Use s.sync Before Emitting Ready Markers](supercollider/use-s-sync-before-ready-markers.md)

### Vulkan

- [Simple C-Style Vulkan Initialization](vulkan/simple-c-style-vulkan-init.md)

### WoW

- [Combat Log Variable Field Positions](wow/combat-log-variable-field-positions.md)

---

## About

These TILs are mined from development session notes across various projects. Each entry focuses on a single, practical learning that can be applied immediately.

## Usage

```bash
# Create a new unpublished TIL
make new CATEGORY=elixir NAME=my-new-til

# List unpublished TILs
make publish

# Count published vs unpublished
make count

# Scan session docs for TIL ideas
make scrub
```

New TILs are created with `published: false` in the frontmatter. Change to `published: true` when ready to publish to GitHub Pages.

## License

MIT
