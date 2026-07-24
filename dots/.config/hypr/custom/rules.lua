-- Blur
hl.window_rule({
  name = "blurForAll",
  match= {class = ".*" },
  opacity = "0.95 override 0.95 override",
  no_blur = false
})

hl.window_rule({match = {class = "^librewolf$" },                      opacity = "0.95 override 0.95 override"})
hl.window_rule({match = {class = "^opentubex$" },                      opacity = "1 override 1 override"})
