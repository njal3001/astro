levels = {
    {
        x = 0, 
        y = 0,
        width = 128,
        height = 16
    }
}

function level_clamp_x(x)
    return mid(level.x, x, (level.width - 1) * 8)
end

function level_clamp_y(y)
    return mid(level.y, y, (level.height - 1) * 8)
end

-- temporary
function update_camera_target(px, py)
    camera_target_x = max(min(128 * 7, px - 56))
    camera_target_y = 0
end

function goto_level(index)
    level = levels[index]
    restart_level()
end

function restart_level()
    camera_x = 0
    camera_y = 0
    camera_target_x = 0
    camera_target_y = 0
    g_dir = 1
    objects = {}
    solids = {}

    for i = 0, level.width - 1 do
        for j = 0, level.height - 1 do
            local t = types[mget(i, j)]
            if t then
                t:new(i * 8, j * 8)
            end
        end
    end
end



