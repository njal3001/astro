
function _init()
   goto_level(1)
end

function _update()
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
    map(0, 0, 0, 0, 128, 32, 2)
    for obj in all(objects) do
        obj:draw()
    end
end

function approach(val, target, max_delta)
    return val > target and max(val - max_delta, target) or min(val + max_delta, target)
end
