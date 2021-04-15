levels = {
    {
        x = 0, 
        y = 0,
        width = 128,
        height = 16
    },
    {
        x = 0, 
        y = 16,
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
    camera_target_y = level.y * 8
end

function snap_camera()
    camera_x = camera_target_x
    camera_y = camera_target_y 
    camera(camera_x, camera_y)
end

function goto_level(index)
    level_index = index
    level = levels[index]
    level_checkpoint = nil
    c_create_stars = cocreate(create_stars)
    level_load = 30
end

c_create_stars = nil

function create_stars()
    stars = {}

    add(stars, create_star())

    for i = 0, 198 do
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
        
        if (i % 10 == 0) yield()
    end
end

function create_star()
    return {
        x = level.x * 8 + rnd() * 1023,
        y = level.y * 8 + rnd() * 127,
        r = rnd(1.3),
        f = flr(rnd() * 340) + 30,
        o = flr(rnd() * 60)
    }
end


function restart_level()
    camera_x = 0
    camera_y = 0
    camera_target_x = 0
    camera_target_y = 0
    g_dir = 1
    objects = {}

    for i = level.x, level.x + level.width - 1 do
        for j = level.y, level.y + level.height - 1 do
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



