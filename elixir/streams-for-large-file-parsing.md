---
published: true
---

# Elixir Streams for Large File Parsing

Use `File.stream!` with `Enum.reduce` for efficient stateful processing of large files:

```elixir
defmodule LogParser do
  def parse_encounters(log_path) do
    log_path
    |> File.stream!()
    |> Enum.reduce(initial_state(), &process_line/2)
    |> finalize()
  end

  defp initial_state do
    %{
      encounters: [],
      current_encounter: nil,
      current_events: []
    }
  end

  defp process_line(line, state) do
    cond do
      line =~ "ENCOUNTER_START" ->
        %{state | current_encounter: parse_encounter_start(line), current_events: []}

      line =~ "ENCOUNTER_END" ->
        encounter = %{
          state.current_encounter |
          events: Enum.reverse(state.current_events)
        }
        %{state | encounters: [encounter | state.encounters], current_encounter: nil}

      state.current_encounter != nil ->
        %{state | current_events: [parse_event(line) | state.current_events]}

      true ->
        state
    end
  end

  defp finalize(state) do
    Enum.reverse(state.encounters)
  end
end
```

Benefits:
- Memory efficient: processes one line at a time
- Stateful: accumulate encounters as we go
- Pattern matching makes event handling clean
- Works with 600MB+ files without issues

Key patterns:
- Prepend to lists during accumulation (O(1))
- Reverse at the end for chronological order
- State machine approach for nested structures (encounter start/end)
