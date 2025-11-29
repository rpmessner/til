---
published: true
---

# Bjorklund's Algorithm for Euclidean Rhythms

Bjorklund's algorithm distributes k hits evenly across n steps, creating Euclidean rhythms used in TidalCycles/Strudel patterns like `bd(3,8)` (3 kicks over 8 steps).

The algorithm works by repeatedly combining groups until no remainder exists:

```elixir
def euclidean(k, n) when k >= n, do: List.duplicate(1, n)
def euclidean(k, n) do
  left = List.duplicate([1], k)
  right = List.duplicate([0], n - k)
  iterate(left, right) |> List.flatten()
end

defp iterate(left, []), do: left
defp iterate(left, right) when length(right) <= 1, do: left ++ right
defp iterate(left, right) do
  min_len = min(length(left), length(right))
  {left_take, left_rest} = Enum.split(left, min_len)
  {right_take, right_rest} = Enum.split(right, min_len)
  combined = Enum.zip_with(left_take, right_take, &(&1 ++ &2))
  iterate(combined, left_rest ++ right_rest)
end
```

Example: `euclidean(3, 8)` produces `[1, 0, 0, 1, 0, 0, 1, 0]` - hits on beats 1, 4, and 7.

Add rotation for offset: `euclidean(3, 8, 2)` rotates the pattern left by 2 positions.
