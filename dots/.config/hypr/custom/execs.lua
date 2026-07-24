hl.on("hyprland.start", function ()

    -- OpenRGB Default
    hl.exec_cmd("openrgb -p Default")

    -- Qbittorrent
    hl.exec_cmd("qbittorrent")

    -- Reset white point
    hl.exec_cmd("hyprctl hyprsunset identity")
end)
