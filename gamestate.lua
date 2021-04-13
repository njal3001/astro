levels = {
    {
        x = 0, 
        y = 0,
        width = 128,
        height = 16
    }
}

function level_clamp_x(x)
    return mid(level.x, x, level.x + level.width - 1)
end

function level_clamp_y(y)
    return mid(level.y, y, level.y + level.height - 1)
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

    for i = 0, level.width - 1 do
        for j = 0, level.height - 1 do
            local t = types[mget(i, j)]
            if t then
                local new = t:new(i * 8, j * 8)
                if t == smasher then
                    local off = 1
                    while mget(i + off, j) != 46 do
                        off += 1 
                    end
                    new.width = 1 + off
                    new.hit_w = 8 * new.width
                end
            end
        end
    end
end



