---
published: true
---

# Skip Comments in NimbleParsec Parsers

When building parsers with NimbleParsec, use `repeat` with `choice` to skip both whitespace and comments before significant tokens:

```elixir
import NimbleParsec

line_comment =
  string("//")
  |> repeat(utf8_char(not: ?\n))
  |> optional(utf8_char([?\n]))

block_comment =
  string("/*")
  |> repeat(
    lookahead_not(string("*/"))
    |> utf8_char([])
  )
  |> string("*/")

skip_ws_and_comments =
  repeat(
    choice([
      ascii_string([?\s, ?\t, ?\n, ?\r], min: 1),
      line_comment,
      block_comment
    ])
  )

# Use before parsing significant tokens
pattern =
  skip_ws_and_comments
  |> concat(your_token_parser)
  |> concat(skip_ws_and_comments)
```

Key insight: use `lookahead_not(string("*/"))` before consuming each character in block comments to properly detect the closing delimiter.
