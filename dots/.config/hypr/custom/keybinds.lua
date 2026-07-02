hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit user keybinds"} )

hl.bind("SUPER + Z", hl.dsp.window.float({ action = "toggle" }), { description = "Window: Float/Tile" })

hl.bind("CTRL + Escape", hl.dsp.global("quickshell:barToggle"), { description = "Shell: Toggle bar" })

hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { description = "Window: Toggle Split" })

hl.bind("SUPER + Y", hl.dsp.exec_cmd("opentubex"), { description = "App: OpenTubeX" })

hl.bind("SUPER + Page_Up", hl.dsp.exec_cmd("qs -c $qsConfig ipc call brightness increment || brightnessctl s 5%+"), {repeating = true} ) 
hl.bind("SUPER + Page_Down", hl.dsp.exec_cmd("qs -c $qsConfig ipc call brightness decrement || brightnessctl s 5%-"), {repeating = true} )

hl.bind("SUPER + ALT + G", function ()
    local game_mode = (hl.get_config("animations.enabled") == false)

    if game_mode then
        hl.exec_cmd("hyprctl reload")
        return
    end
    
    hl.config({
        general = {
            gaps_in = 0, gaps_out = 0, -- Disable gaps  
            border_size = 0,
        },

        animations = {
            enabled = false, -- Disable animations
        },
        
        -- Disable blur, shadow and window rounding
        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            rounding = 0,
        }
    })
end)

hl.bind("SUPER + BACKSPACE", hl.dsp.exec_cmd("systemctl suspend"))


