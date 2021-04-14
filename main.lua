
function _init()
    stars = {}
    goto_level(1)
end

function _update()
    printh(stat(7))
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
end

function _draw()
    cls(0)

    -- draw stars
    for s in all(stars) do
        if s.o > 0 then
            s.o -= 1
        end
        if s.o == 0 then
            s.f -= 1
        end
        if s.f == 0 then
            s.f = flr(rnd() * 340) + 30
        else
            circfill(s.x, s.y, s.r, 7)
        end
    end

    map(0, 0, 0, 0, 128, 32, 2)
    local p
    for obj in all(objects) do
        if obj.base == player then 
            p = obj
        else
            obj:draw()
        end
    end
    if (p) p:draw() 
end

function approach(val, target, max_delta)
    return val > target and max(val - max_delta, target) or min(val + max_delta, target)
end
