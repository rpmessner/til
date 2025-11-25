---
published: true
---

# Parse CSV with Quoted Strings Using Regex

When parsing CSV data that contains quoted strings with commas inside them, a simple `String.split(",")` won't work:

```elixir
# BAD: Breaks on quoted strings containing commas
"name,\"Smith, John\",age" |> String.split(",")
# => ["name", "\"Smith", " John\"", "age"]  # Wrong!
```

Use a regex that respects quoted strings:

```elixir
# GOOD: Handles quoted strings correctly
~r/,(?=(?:[^"]*"[^"]*")*[^"]*$)/
|> Regex.split("name,\"Smith, John\",age")
# => ["name", "\"Smith, John\"", "age"]  # Correct!
```

The regex `(?=(?:[^"]*"[^"]*")*[^"]*$)` is a lookahead that only matches commas when there's an even number of quotes after them (meaning we're outside quotes).

For production code, consider using the `NimbleCSV` library instead, but this regex works well for quick parsing tasks.
