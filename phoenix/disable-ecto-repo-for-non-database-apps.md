# Disable Ecto Repo for Non-Database Phoenix Apps

If your Phoenix app doesn't need a database (e.g., a visualization tool, calculator, or API proxy), you can disable Ecto to avoid database connection errors:

Comment out the Repo from the application supervision tree:

```elixir
# lib/my_app/application.ex
def start(_type, _args) do
  children = [
    MyAppWeb.Telemetry,
    # MyApp.Repo,  # Comment this out
    {DNSCluster, query: Application.get_env(:my_app, :dns_cluster_query) || :ignore},
    {Phoenix.PubSub, name: MyApp.PubSub},
    MyAppWeb.Endpoint
  ]

  opts = [strategy: :one_for_one, name: MyApp.Supervisor]
  Supervisor.start_link(children, opts)
end
```

The Repo module can remain in the codebase - it just won't start. This makes it easy to re-enable later if you need database features like user accounts or persistence.

Benefits:
- No PostgreSQL connection errors on startup
- Faster application boot
- Can still use all other Phoenix features (LiveView, PubSub, etc.)
- Easy to re-enable when needed
