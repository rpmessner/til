# SuperDirt is Not a Pattern Parser

A common misconception: SuperDirt is NOT a pattern language parser. It's only a sample playback engine.

**SuperDirt does:**
- Receive individual OSC events (`/dirt/play`)
- Play samples from its library
- Apply effects (reverb, delay, filters)
- Manage orbits (independent audio tracks)

**SuperDirt does NOT:**
- Parse pattern strings (e.g., `"bd cp sn cp"`)
- Understand mini-notation
- Schedule future events
- Handle pattern transformations

**TidalCycles does:**
- Parse pattern languages
- Evaluate patterns over time
- Send pre-computed events to SuperDirt

The `s:` parameter is simply the sample folder name:
```
SuperDirt-samples/
├── bd/           ← s: "bd"
├── cp/           ← s: "cp"
├── sn/           ← s: "sn"
```

The `n:` parameter selects which variant in that folder:
```elixir
SuperDirt.play(s: "bd", n: 0)  # bd/BD0000.wav
SuperDirt.play(s: "bd", n: 1)  # bd/BD0001.wav
```

If you want TidalCycles-style pattern scheduling, you need to build or use a pattern scheduler that:
1. Parses pattern notation
2. Evaluates patterns over time
3. Sends individual events to SuperDirt via OSC
