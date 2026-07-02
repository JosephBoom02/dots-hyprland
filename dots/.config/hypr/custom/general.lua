hl.config({
  misc = {
    animate_manual_resizes = true,
    animate_mouse_windowdragging = true,
    enable_swallow = true,
    swallow_regex = "^(kitty|Alacritty|foot)$",
  },
  input = {
    kb_layout = "us", -- or your layout, e.g., "it", "fr", etc.
    kb_options = "compose:ralt"
  }
})

hl.device({
        name = "logitech-k400-plus",
        natural_scroll = false
})

for i = 1, 10 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor   = (i % 2 == 1) and "DP-2" or "DP-1",  -- odd → DP-2, even → DP-1
    default   = (i == 1 or i == 2),                 -- default ws per monitor
  })
end

