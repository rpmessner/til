# WoW Addon Drag-and-Drop Widget System

Create draggable widgets in WoW addons using Button frames with drag handlers:

```lua
local function CreateWidget(module)
    local widget = CreateFrame("Button", "MyAddon_" .. module.name, UIParent, "BackdropTemplate")
    widget:SetSize(80, 20)
    widget:SetMovable(true)
    widget:EnableMouse(true)
    widget:RegisterForDrag("LeftButton")

    -- Drag handlers
    widget:SetScript("OnDragStart", function(self)
        if not db.locked then
            self:StartMoving()
            self.isMoving = true
        end
    end)

    widget:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        if self.isMoving then
            self.isMoving = false
            -- Find nearest anchor and snap to it
            local nearestAnchor = FindNearestAnchor(self)
            SnapToAnchor(self, nearestAnchor)
            SavePosition(self)
        end
    end)

    return widget
end
```

Find nearest anchor by calculating distance:
```lua
local function FindNearestAnchor(widget)
    local wx, wy = widget:GetCenter()
    local nearest, minDist = nil, math.huge

    for name, anchor in pairs(anchorPoints) do
        local ax, ay = anchor:GetCenter()
        local dist = math.sqrt((wx-ax)^2 + (wy-ay)^2)
        if dist < minDist then
            minDist = dist
            nearest = name
        end
    end
    return nearest
end
```

Register anchor points from host addons:
```lua
function MyAddon:RegisterAnchorPoint(name, frame)
    anchorPoints[name] = frame
end
```

This pattern gives more flexibility than fixed slot systems - users can freely organize modules across all available anchors.
