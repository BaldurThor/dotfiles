hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
    },
    decoration = {
        rounding = 0,
        blur = {
            enabled = true,
            size = 8,
            passes = 2,
        },
    },
})

hl.on("hyprland.start", function ()
    hl.exec_cmd("swaybg -i ~/dotfiles/wallpaper.jpg -m fill")
    
    hl.exec_cmd("ghostty --title=\"Secure Terminal Enclave\"")
end)

hl.window_rule({
    name = "auto-maximize-apps",
    match = { class = ".*" },
    maximize = true
})

hl.bind("SUPER + Q", function()
    local w = hl.get_active_window()
    if w ~= nil and w.title == "Secure Terminal Enclave" then
        return
    else
        hl.dispatch(hl.dsp.window.close())
    end
end)
