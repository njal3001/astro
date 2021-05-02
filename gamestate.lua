function level_clamp_x(x)
    return mid(0, x, 127)
end

function level_clamp_y(y)
    return mid(level_bottom(), y, level_top())
end

function level_bottom()
    return (level_index - 1) * 16
end

function level_top()
    return level_bottom() + 15
end

function set_camera_target(x)
    camera_target_x = max(min(128 * 7, x - 56))
end

function snap_camera()
    camera_x = camera_target_x
    camera(camera_x, level_bottom() * 8)
end

function goto_level(index)
    level_index = index
    if level_index == 4 then
        music(9)
        create_stars()
    else
        level_checkpoint = nil
        c_create_stars = cocreate(create_stars)
        level_load = 30
        start_song = true
    end
end

c_create_stars = nil

function create_stars()
    stars = {}

    add(stars, create_star())

    local n = level_index == 4 and 30 or 198
    for i = 0, n do
        local max_sdist = 0
        local max_sample
        for j = 0, 9 do
            local sample = create_star()
            local min_sdist = 32767
            for star in all(stars) do
                local dx = abs(star.x - sample.x)
                local dy = abs(star.y - sample.y)
                local sdist = dx^2 + dy^2
                if sdist > 0 and sdist < min_sdist then
                    min_sdist = sdist
                end
            end
            if min_sdist > max_sdist then
                max_sdist = min_sdist
                max_sample = sample
            end

        end

        if (max_sample) add(stars, max_sample)
        
        if (i % 10 == 0 and level_index != 4) yield()
    end
end

function create_star()
    local final = level_index == 4
    local x = rnd() * (final and 127 or 1023)
    local y = rnd() * 127 + (final and 0 or level_bottom() * 8)
    return {
        x = x,
        y = y,
        r = rnd(1.3),
        f = flr(rnd() * 340) + 30
    }
end


function restart_level()
    g_dir = 1
    camera_x = 0
    camera_target_x = 0
    objects = {}

    for i = 0, 127 do
        for j = level_bottom(), level_top() do
            local t = types[mget(i, j)]
            if t and (not level_checkpoint or t != player) then
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



