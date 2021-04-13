spike_v = new_type(10)

function spike_v:init()
    if not self:check_solid(0, 1) then
        self.flip_y = true
        self.hazard = 3
    else
        self.hit_y = 5
        self.hazard = 2
    end

    self.hit_h = 3   
end

spike_h = new_type(11)

function spike_h:init()
    if not self:check_solid(1, 0) then
        self.flip_x = true
        self.hazard = 4
    else
        self.hit_x = 5
        self.hazard = 5
    end

    self.hit_w = 3  
end

crumble = new_type(26)
crumble.solid = true

function crumble:init()
    self.time = 0
    self.breaking = false
end

function crumble:update()        
    if self.breaking then
        self.time += 1
        if self.time == 10 then
            self.solid = false
            if (self.springboard) self.springboard.collideable = false
        elseif self.time >= 90 then
            local can_respawn = true

            for o in all(objects) do
                if self:overlaps(o) then can_respawn = false break end
            end

            if can_respawn then
                self.breaking = false
                self.solid = true
                self.time = 0
                if (self.springboard) self.springboard.collideable = true
            end
        end
    end
end

function crumble:draw()
    if self.solid then
        object.draw(self)
    end
end

springboard = new_type(42)

function springboard:init()
    self.has_checked = false
    self.time = 0
end

function springboard:spring(obj)
    obj.speed_x = 0
    obj:move_y(self.y - 8 * g_dir - obj.y)

    obj.speed_y = -7.9 * g_dir
    
    obj.t_jump_grace = 0
    obj.remainder_y = 0
    
    if self.crumble then
        self.crumble.breaking = true
    end
end

function springboard:update()
    if not self.has_checked then
        if not self:check_solid(0, 1) then
            self.flip_y = true
        end
        for o in all(objects) do 
            if o.base == crumble and (self:overlaps(o, 0, 1) or self:overlaps(o, 0, -1)) then
                o.springboard = self
                self.crumble = o
            end
        end
        self.has_checked = true
    end
end

function springboard:draw()
    if self.collideable then
        object.draw(self)
    end
end

smasher = new_type(44)

function smasher:update()
    -- gravity
    if not self:check_solid(0, g_dir) then
        self.speed_y = approach(self.speed_y, g_dir * 5.1, 0.12)
    end

    -- apply
    self:move_y(self.speed_y)

    self.destroyed = 
    (self.y > (level.height + level.y) * 8 + 24 and g_dir == 1) or 
    (self.y < level.y * 8 - 32 and g_dir == -1)
end

function smasher:draw()
    spr(44, self.x, self.y, 1, 1)
    for i = 1, self.width - 2 do
        spr(45, self.x + i * 8, self.y, 1, 1)
    end
    spr(46, self.x + (self.width - 1) * 8, self.y, 1, 1)
end

mover = new_type(58)
mover.solid = true
mover.state = 0
mover.col_solid = false
mover.hit_w = 24
mover.hit_h = 4

function mover:solid_check(o, ox, oy)
    return o.base == player and 
        ((g_dir == 1 and o.y + o.hit_y + o.hit_h - 1 - o.speed_y < self.y) or
        (g_dir == -1 and o.y + o.hit_y - o.speed_y > self.y + 3))

end

--[[
    states:
        0 - still
        1 - moving
]]

function mover:update()
    if self.state == 1 then
        self.speed_x = approach(self.speed_x, 1, 0.2)
        self:move_x(self.speed_x)
        if self.player then
            self.player:move_x(self.speed_x)
        end
    end
end

function mover:draw()
    spr(self.spr, self.x, self.y, 3, 1)
end

