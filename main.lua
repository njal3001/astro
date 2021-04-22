level_index = 0
level_load = 0
start_song = false

function _init()
    stars = {}
    goto_level(3)
end

function _update()
    if stat(7) != 30 and level_load == 0 then
        printh("frames dropped")
    end

    if c_create_stars and costatus(c_create_stars) != "dead" then
        coresume(c_create_stars)
    else
        c_create_stars = nil
    end

    if level_load > 0 then
        level_load -= 1
        if level_load == 0 then
            restart_level()
            if start_song then
                music(0)
                start_song = false
            end
        end
    else
        update_input()
        for obj in all(objects) do
            if obj.freeze > 0 then
                obj.freeze -= 1
            else
                obj:update()
            end

            if obj.destroyed then
                del(objects, obj)
            end
        end

        camera_x = approach(camera_x, camera_target_x, 3)
        camera(camera_x, level_bottom() * 8)
    end
end

function _draw()
    cls(0)

    if level_load > 0 then
        camera(0, 0)
        print("level "..level_index, 50, 60, 7)
    else
        -- draw stars
        for s in all(stars) do
            s.f -= 1
            if s.f == 0 then
                s.f = flr(rnd() * 340) + 30
            else
                circfill(s.x, s.y, s.r, 7)
            end
        end

        map(0, 0, 0, 0, 128, 64, 2)

        for obj in all(objects) do
            if obj.base == spike_h or obj.base == spike_v then 
                obj:draw()
            end
        end

        local p
        for obj in all(objects) do
            if obj.base == player then 
                p = obj
            elseif obj.base != spike_h and obj.base != spike_v then
                obj:draw()
            end
        end
        if (p) p:draw()
    end
end

function approach(val, target, max_delta)
    return val > target and max(val - max_delta, target) or min(val + max_delta, target)
end
