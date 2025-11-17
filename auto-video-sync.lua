--[[
    This file is part of mpv-auto-video-sync
    https://github.com/ExiledEye/mpv-auto-video-sync

    auto_video_sync.lua
    Author: Exiled Eye
    Version: 1.0
    Description: Switches video-sync profile based on fullscreen state.

    Copyright (c) 2025 Exiled Eye
    Licensed under the MIT License. Refer to the LICENSE file for details.
]]

local function apply_sync_profile()
    local fullscreen = mp.get_property_native("fullscreen")
    if fullscreen then
        mp.commandv("apply-profile", "fullscreen-sync-display")
    else
        mp.commandv("apply-profile", "windowed-sync-audio")
    end
end

-- Apply profile on startup
apply_sync_profile()

-- Observe fullscreen changes
mp.observe_property("fullscreen", "bool", function(_, is_fullscreen)
    if is_fullscreen ~= nil then
        apply_sync_profile()
    end
end)
