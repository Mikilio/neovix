# opencode.nvim: Server GC before heartbeat timer fires

## Error

```
vim.schedule callback: ...mPackages/opt/opencode.nvim/lua/opencode/server/init.lua:368: attempt to index local 'self' (a nil value)
stack traceback:
    ...mPackages/opt/opencode.nvim/lua/opencode/server/init.lua:368: in function 'fn'
    [string "vim/_core/editor"]:273: in function <[string "vim/_core/editor"]:272>
```

## Cause

In `Server:connect()`, a `uv_timer_t` is created that captures `self` via closure:

```lua
self.heartbeat_timer:start(
  OPENCODE_HEARTBEAT_INTERVAL_MS + 1000,
  0,
  vim.schedule_wrap(function()
    self:disconnect()
  end)
)
```

Lua's GC does not consider `uv_timer_t` handles as references to the enclosing table.
If no other live reference keeps the Server alive, GC can collect it before the timer
fires, making `self` nil inside the scheduled callback.

## Fix

Either guard against nil:

```lua
vim.schedule_wrap(function()
  if self then
    self:disconnect()
  end
end)
```

Or prevent GC with a strong reference table:

```lua
local ref = { server = self }
-- in timer callback:
vim.schedule_wrap(function()
  ref.server:disconnect()
end)
```

## Notes

- Unrelated to statusline integration; happens regardless.
- `Server.connected` may already be nil by the time the timer fires if the server
  disconnected between the timer being set and the callback executing.
