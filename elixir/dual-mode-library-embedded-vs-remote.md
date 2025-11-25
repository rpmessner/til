---
published: true
---

# Dual-Mode Library: Embedded vs Remote

Design libraries to support both embedded mode (same BEAM VM) and remote mode (separate process) with a single codebase:

```elixir
# config/config.exs
config :my_server,
  mode: :embedded,  # or :remote
  rpc_port: 8420

# lib/my_server/application.ex
def start(_type, _args) do
  mode = Application.get_env(:my_server, :mode, :embedded)

  children = case mode do
    :embedded -> [Scheduler]
    :remote -> [Scheduler, RPC.Server]
  end

  Supervisor.start_link(children, strategy: :one_for_one)
end
```

Use cases for each mode:

**Embedded mode** (library, same VM):
- Livebook cells calling your library
- Phoenix app with integrated functionality
- Low-latency in-process access

**Remote mode** (daemon, separate process):
- Neovim plugin connecting via TCP
- Language-agnostic RPC access
- Process isolation

Benefits:
- Single codebase to maintain
- No runtime overhead in embedded mode (RPC server not started)
- Test both modes easily
- Users choose based on their needs

```elixir
# Embedded usage (direct function call)
MyServer.do_thing()

# Remote usage (JSON-RPC over TCP)
{"method": "do_thing", "params": {}}
```
