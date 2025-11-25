# Use LiveView Routes Instead of Controllers for Interactive Pages

For interactive pages, use `live` routes directly instead of routing through a controller:

```elixir
# router.ex
scope "/", MyAppWeb do
  pipe_through :browser

  # Before: Static controller
  # get "/", PageController, :home

  # After: LiveView for interactivity
  live "/", HomeLive
end
```

Create the LiveView:
```elixir
# lib/my_app_web/live/home_live.ex
defmodule MyAppWeb.HomeLive do
  use MyAppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def render(assigns) do
    ~H\"\"\"
    <div class="container mx-auto p-4">
      <h1 class="text-2xl font-bold">Welcome</h1>
      <button phx-click="increment">Count: <%= @count %></button>
    </div>
    \"\"\"
  end

  def handle_event("increment", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end
```

Benefits:
- All state managed in LiveView assigns (no database needed)
- Real-time updates without page refreshes
- Consistent pattern for all interactive pages
- Better foundation for features like WebSocket communication
