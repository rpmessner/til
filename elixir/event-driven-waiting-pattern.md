# Event-Driven Waiting Pattern in Elixir GenServers

Instead of polling with `Process.sleep` in a loop, use a subscriber pattern with GenServer:

```elixir
defmodule MyServer do
  use GenServer

  defstruct ready: false, subscribers: []

  # Client API - blocks until ready
  def wait_for_ready(opts \\ []) do
    timeout = Keyword.get(opts, :timeout, 30_000)
    GenServer.call(__MODULE__, :wait_for_ready, timeout)
  end

  # Server callbacks
  def handle_call(:wait_for_ready, from, %{ready: true} = state) do
    {:reply, :ok, state}
  end

  def handle_call(:wait_for_ready, from, state) do
    # Don't reply yet - add to subscribers list
    {:noreply, %{state | subscribers: [from | state.subscribers]}}
  end

  def handle_info(:became_ready, state) do
    # Notify all waiting subscribers
    Enum.each(state.subscribers, fn from ->
      GenServer.reply(from, :ok)
    end)
    {:noreply, %{state | ready: true, subscribers: []}}
  end
end
```

Benefits:
- No CPU-wasting polling loops
- Instant notification when ready
- Timeout handled by GenServer.call
- Multiple callers can wait simultaneously
