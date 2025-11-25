---
published: true
---

# Use s.sync Before Emitting Ready Markers in SuperCollider

When emitting "ready" markers from SuperCollider, always use `s.sync` first to ensure the server has actually finished processing:

```supercollider
// BAD: Marker might emit before SuperDirt is actually ready
fork {
  ~dirt = SuperDirt(2, s);
  ~dirt.loadSoundFiles("samples/*");
  ~dirt.start(57120, [0, 0]);
  "SUPERDIRT_READY".postln;  // May fire too early!
};

// GOOD: s.sync ensures server has processed everything
fork {
  ~dirt = SuperDirt(2, s);
  ~dirt.loadSoundFiles("samples/*");
  ~dirt.start(57120, [0, 0]);
  s.sync;  // Wait for server to finish processing
  "SUPERDIRT_READY".postln;  // Now it's actually ready
};
```

`s.sync` blocks execution until all pending server commands have completed. Without it, your marker may emit while samples are still loading or synths are still being allocated.

This is critical when you have external code (like an Elixir app) waiting to detect the ready marker before sending audio commands.
