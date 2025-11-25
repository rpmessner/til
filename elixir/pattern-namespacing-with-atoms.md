---
published: true
---

# Pattern Namespacing with Atoms

When building systems that handle multiple concurrent clients (Discord guilds, Livebook cells, Neovim buffers), use atom-based pattern IDs for isolation:

```elixir
# Discord bot - per-guild isolation
pattern_id = :"#{guild_id}:drums"
Scheduler.schedule_pattern(pattern_id, events)

# Livebook - per-cell patterns
pattern_id = :"livebook_#{cell_id}"
Scheduler.schedule_pattern(pattern_id, events)

# Neovim - per-buffer patterns
pattern_id = :"nvim_buffer_#{buffer_id}"
Scheduler.schedule_pattern(pattern_id, events)
```

Benefits of atom pattern IDs:
- Fast lookup in ETS/Maps (atoms are interned)
- Clear namespacing prevents collisions
- Easy debugging (pattern IDs are readable)
- Works naturally with GenServer registry

Store patterns in state:
```elixir
defmodule Scheduler do
  defstruct patterns: %{}

  def handle_call({:schedule, pattern_id, events}, _from, state) do
    patterns = Map.put(state.patterns, pattern_id, events)
    {:reply, :ok, %{state | patterns: patterns}}
  end

  def handle_call({:stop, pattern_id}, _from, state) do
    patterns = Map.delete(state.patterns, pattern_id)
    {:reply, :ok, %{state | patterns: patterns}}
  end
end
```

Note: Atoms aren't garbage collected, but in practice the number of unique guild/cell/buffer IDs is bounded, so this is fine.
