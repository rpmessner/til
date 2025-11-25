---
published: false
---

> **Warning:** This TIL was generated from a Claude session and contains inaccurate information. Do not trust session-generated content without verification against official documentation.

# WoW Combat Log Variable Field Positions

WoW's combat log format has variable field positions when Advanced Combat Logging is enabled. Don't assume fixed positions:

```
Standard format:
timestamp,EVENT_TYPE,sourceGUID,sourceName,...,spellID,spellName,damage,...

Advanced logging adds fields:
timestamp,EVENT_TYPE,sourceGUID,sourceName,...,HP,position,itemLevel,...,spellID,spellName,damage,...
```

The damage amount shifts position based on:
- Whether Advanced Combat Logging is enabled
- The event type (SPELL_DAMAGE vs SPELL_PERIODIC_DAMAGE)
- Version of WoW

Solution: Search from the END of the data array:

```elixir
defp find_damage_amount(fields) do
  # Damage suffix is consistently at end, work backwards
  fields
  |> Enum.reverse()
  |> Enum.take(10)  # Damage suffix fields
  |> find_first_valid_damage()
end

defp find_first_valid_damage(reversed_suffix) do
  Enum.find(reversed_suffix, fn field ->
    case Integer.parse(field) do
      {num, ""} when num > 0 and num < 50_000_000 -> true
      _ -> false
    end
  end)
end
```

This approach is more robust than hardcoded field indices and handles both standard and advanced logging formats.
