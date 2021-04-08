objects = {}
solids = {}
types = {}
lookup = {}

function lookup:__index(i) 
    return self.base[i]
end

object = {}
object.speed_x = 0
object.speed_y = 0
object.remainder_x = 0
object.remainder_y = 0
object.hit_x = 0
object.hit_y = 0
object.hit_w = 8
object.hit_h = 8
object.facing = 1
object.freeze = 0
object.col_solid = true

function object:move_x(amount)
    self.remainder_x += amount
    local pixel_amount = flr(self.remainder_x + 0.5)
    self.remainder_x -= pixel_amount

    if self.col_solid then
        local step = sgn(pixel_amount)
        while pixel_amount != 0 do
            if self:check_solid(step) and self:on_collide_x(step) then
                return true
            end
            self.x += step
            pixel_amount -= step 
        end
    else
        self.x += pixel_amount
    end
    return false
end

function object:on_collide_x(dir)
    self.speed_x = 0
    self.remainder_x = 0
    return true
end

function object:move_y(amount)
    self.remainder_y += amount
    local pixel_amount = flr(self.remainder_y + 0.5)
    self.remainder_y -= pixel_amount

    if self.col_solid then
        while pixel_amount != 0 do
            local step = sgn(pixel_amount)
            if self:check_solid(0, step) and self:on_collide_y(step) then
                return true
            end
            self.y += step
            pixel_amount -= step
        end
    else
        self.y += pixel_amount
    end
    return false
end

function object:on_collide_y(dir)
    self.speed_y = 0
    self.remainder_y = 0
    return true
end

function object:corner_correct(dir_x, dir_y, side_dist, only_sign)
    only_sign = only_sign or 0
    if dir_x != 0 then
        for i = 1, side_dist do
            for s = 1, -1, -2 do 
                if s != -only_sign and not self:check_solid(dir_x, i * s) and 
                        self:correction_check(dir_x, i * s) then
                    self.y += i * s
                    return true
                end
            end
        end
    elseif dir_y != 0 then
        for i = 1, side_dist do
            for s = 1, -1, -2 do
                if s != -only_sign and not self:check_solid(i * s, dir_y) and 
                        self:correction_check(i * s, dir_y) then
                    self.x += i * s
                    return true
                end
            end
        end
    end

    return false
end

function object:correction_check(offset_x, offset_y) 
    return true
end

function object:overlaps(other, offset_x, offset_y)
    if self == other then return false end
    local ox = offset_x or 0
    local oy = offset_y or 0

    return overlaps(self.x + self.hit_x + ox, self.y + self.hit_y + oy, self.hit_w, self.hit_h,
             other.x + other.hit_x, other.y + other.hit_y, other.hit_w, other.hit_h)
end

function object:check_solid(offset_x, offset_y)
    local ox = offset_x or 0
    local oy = offset_y or 0

    return overlaps_solid(self.x + self.hit_x + ox, self.y + self.hit_y + oy, self.hit_w, self.hit_h)
end

function overlaps(x0, y0, w0, h0, x1, y1, w1, h1)
    return 
        x0 < x1 + w1 and
        y0 < y1 + h1 and
        x0 + w0 > x1 and
        y0 + h0 > y1
end

function overlaps_solid(x, y, w, h)
    for i = level_clamp_x(flr(x / 8)), level_clamp_x(flr((x + w - 1) / 8)) do
        for j = level_clamp_y(flr(y / 8)), level_clamp_y(flr((y + h - 1) / 8)) do
            if fget(mget(i, j), 0) then
                return true
            end
        end
    end

    for s in all(solids) do
        if overlaps(x, y, w, h, s.x + s.hit_x, s.y + s.hit_y, s.hit_w, s.hit_h) then
            return true
        end
    end
end


function object:init() end

function object:update() end

function object:draw()
    if self.spr then
        spr(self.spr, self.x, self.y, 1, 1, self.flip_x, self.flip_y)
    end
end

function object:new(x, y)
    local obj = {}
    obj.base = self
    obj.x = x
    obj.y = y
    setmetatable(obj, lookup)
    add(objects, obj)
    if (obj.vel) add(objects_with.vel, obj)
    if (obj.timer) add(objects_with.timer, obj)
    obj:init()
    return obj
end

function new_type(spr, base)
    local obj = {}
    obj.spr = spr
    obj.base = base or object
    setmetatable(obj, lookup)
    if spr then
        types[spr] = obj 
    end
    return obj
end

