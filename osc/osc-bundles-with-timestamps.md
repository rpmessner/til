---
published: true
---

# OSC Bundles with Timestamps for Precise Audio Scheduling

OSC (Open Sound Control) bundles allow you to schedule messages with precise timestamps, which is essential for audio applications:

```elixir
# Regular OSC message - executes immediately
message = {"/dirt/play", [{"s", "bd"}, {"gain", 0.8}]}
encoded = :osc.encode(message)
:gen_udp.send(socket, host, port, encoded)

# OSC bundle with timestamp - executes at specified time
latency = 0.02  # 20ms lookahead
time = :osc.now() + latency
encoded = :osc.pack_ts(time, message)
:gen_udp.send(socket, host, port, encoded)
```

Bundle format:
```
"#bundle\0"    (8 bytes - header)
<timestamp>    (8 bytes - NTP time)
<size>         (4 bytes - message size)
<message>      (variable - encoded OSC message)
```

Useful OSC library functions (from erlang-osc):
- `:osc.now()` - Current time as float (seconds since epoch)
- `:osc.pack_ts(time, message)` - Create bundle with timestamp
- `:osc.encode_time(time)` - Convert to NTP timestamp format
- `:osc.decode(bundle)` - Decode for testing/verification

Choose latency based on use case:
- 10ms - Responsive, risk of jitter
- 20ms - Balanced (good default)
- 50ms+ - Very stable, higher perceived latency
