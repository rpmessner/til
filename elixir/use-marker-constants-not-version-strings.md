---
published: true
---

# Use Marker Constants Instead of Version-Dependent Strings

When detecting events from external processes by parsing their output, don't rely on version-specific strings that could change:

```elixir
# BAD: Will break if external system changes message format
cond do
  line =~ "SuperCollider 3 server ready" -> handle_ready()
  line =~ "SuperDirt: listening to Tidal on port" -> handle_superdirt()
end
```

Instead, emit your own custom markers that you control:

```elixir
# Define markers in one place
@marker_server_ready "WAVEFORM_SERVER_READY"
@marker_superdirt_ready "WAVEFORM_SUPERDIRT_READY"

# Public accessors for other modules
def marker_server_ready, do: @marker_server_ready
def marker_superdirt_ready, do: @marker_superdirt_ready

# Detection is now version-independent
cond do
  line =~ @marker_server_ready -> handle_ready()
  line =~ @marker_superdirt_ready -> handle_superdirt()
end
```

Then emit these markers from the external system:

```supercollider
Server.default.waitForBoot({
  "WAVEFORM_SERVER_READY".postln;
});
```

Keep fallback detection for backwards compatibility:

```elixir
cond do
  # Primary: our controlled markers
  line =~ @marker_server_ready -> handle_ready()
  # Fallback: original messages (backwards compatibility)
  line =~ "SuperCollider 3 server ready" -> handle_ready()
end
```
