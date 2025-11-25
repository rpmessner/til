---
published: true
---

# Make WoW Minimap Square with SetMaskTexture

Transform the circular WoW minimap into a square using `SetMaskTexture`:

```lua
-- Use the chat frame background as a square mask
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

-- Add a backdrop for the border
Minimap:SetBackdrop({
    bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
})
Minimap:SetBackdropColor(0, 0, 0, 0.5)
Minimap:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
```

This works in:
- Retail WoW (verified in 12.0.0 Midnight beta)
- Classic WoW variants

The `Interface\\ChatFrame\\ChatFrameBackground` texture is a solid square, perfect for masking.

Note: `SetMaskTexture()` isn't restricted by protected API rules since it's just cosmetic UI modification, not related to combat or secure actions.
