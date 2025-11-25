---
published: true
---

# Debugging WoW Addons with SavedVariables

WoW addons run in a sandboxed Lua environment and cannot write arbitrary files to disk. However, they can save data to SavedVariables, which get written when you `/reload` or log out.

## The Workflow

1. Add a debug SavedVariable to your `.toc` file:
   ```
   ## SavedVariables: MyAddonDB, MyAddonDebug
   ```

2. Create a function that dumps frame/API info to the SavedVariable:
   ```lua
   function MyAddon:DumpDebugInfo()
       MyAddonDebug = {
           timestamp = date("%Y-%m-%d %H:%M:%S"),
           -- collect whatever data you need
       }
       print("Debug info saved. Do /reload to write SavedVariables.")
   end
   ```

3. Trigger the dump via slash command, then `/reload` to flush to disk

4. Read the SavedVariables file from outside the game:
   ```
   WTF/Account/<ACCOUNT>/SavedVariables/MyAddon.lua
   ```

## Example: Discovering Frame Structure

```lua
function MyAddon:InvestigateFrame(frameName)
    local frame = _G[frameName]
    if not frame then return end

    MyAddonDebug = {
        regions = {},
        children = {},
    }

    -- Get regions (textures, fontstrings)
    for i, region in ipairs({frame:GetRegions()}) do
        table.insert(MyAddonDebug.regions, {
            type = region:GetObjectType(),
            name = region:GetName() or "unnamed",
            shown = region:IsShown(),
        })
    end

    -- Get children (frames)
    for i, child in ipairs({frame:GetChildren()}) do
        table.insert(MyAddonDebug.children, {
            type = child:GetObjectType(),
            name = child:GetName() or "unnamed",
            shown = child:IsShown(),
        })
    end
end
```

## Reading Errors with BugSack/BugGrabber

If you have BugSack installed, Lua errors are captured in `!BugGrabber.lua`:
```
WTF/Account/<ACCOUNT>/SavedVariables/!BugGrabber.lua
```

After hitting errors, `/reload` and read this file for full stacktraces.

## Why This Matters

This workflow enables an external tool (like Claude Code) to:
- Request specific frame investigations
- Read the dumped data after reload
- Iterate on fixes without manual copy/paste of error messages
