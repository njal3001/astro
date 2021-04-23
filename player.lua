player = new_type(1)
player.hit_x = 1
player.hit_w = 5
player.hit_h = 6
player.hit_y = 2
player.t_jump_grace = 0
player.t_var_jump = 0
player.jumping = false
player.can_switch = true
player.t_bounce = 0

player.state = 0

--[[
	hazard types:
		1 - general hazard
		2 - up-spike
		3 - down-spike
		4 - right-spike
		5 - left-spike
]]

player.hazard_table = {
    [1] = function(self) return true end,
    [2] = function(self) return self.speed_y >= 0 end,
    [3] = function(self) return self.speed_y <= 0 end,
    [4] = function(self) return self.speed_x <= 0 end,
    [5] = function(self) return self.speed_x >= 0 end,
}

function player:hazard_check(ox, oy)
    local ox = ox or 0
    local oy = oy or 0

    for o in all(objects) do
        if o.hazard and self:overlaps(o, ox, oy) and self.hazard_table[o.hazard](self) then
            return true
        end
    end

    return false
end

function player:correction_check(ox, oy)
    return not self:hazard_check(ox, oy)
end

function player:on_collide_x(dir)
    if dir == input_x and self:corner_correct(dir, 0, 2 * g_dir, -1) then
        return false
    end

    return object.on_collide_x(self, dir)
end

function player:on_collide_y(dir)
    if dir * g_dir < 0 and input_jump and self:corner_correct(0, -g_dir, 2, input_x) then
        return true
    end

    return object.on_collide_y(self, dir)
end

function player:jump()
    consume_jump_press()
    self.jumping = true
    self.speed_y = -6.2 * g_dir
    self.remainder_y = 0
    self.speed_x += 0.32 * input_x
    self.remainder_x = 0
    self.t_jump_grace = 0
    self:move_y(self.jump_grace_y - self.y)
    sfx(8)
end

function player:bounce_check(obj)
    return self.speed_y * g_dir >= 0 and abs(obj.speed_y) < 1 and 
        ((g_dir == 1 and self.y - self.speed_y < obj.y + obj.speed_y - 7) or
        (g_dir == -1 and self.y - self.speed_y > obj.y + obj.speed_y + 7))
end

function player:spring()
    self.jumping = true
    self.t_jump_grace = 0
    self.springboard:spring(self)
    self:leave_springboard()
    if input_jump then sfx(24)
    else sfx(25) end
end

function player:leave_springboard()
    self.state = 0
    self.springboard.spr = 42
    self.springboard = nil
end

function player:switch()
    consume_switch_press()
    g_dir *= -1
    self.hit_y = max(0, g_dir * 2)
    self.can_switch = false
    self.t_jump_grace = 0
    sfx(9)
end

function player:die()
    sfx(12)
    level_load = 30
end

function player:init()
    set_camera_target(self.x)
    snap_camera()
end

--[[
    player states:
        0 - normal
        1 - springboard bounce
        2 - finished
]]

function player:update()
    local on_ground = self.speed_y == 0 and self:check_solid(0, g_dir)
    if on_ground then 
        self.t_jump_grace = 4
        self.jump_grace_y = self.y
        if not self.was_on_ground and not self.can_switch then
            self.can_switch = true
        end
    else
        self.t_jump_grace = max(self.t_jump_grace - 1)
    end

    if self.state == 0 then
        -- normal state

        -- running
        local accel = 0.1
        if on_ground then
            accel = 0.45
        elseif input_x != 0 then
            accel = 0.35
        end


        self.speed_x = approach(self.speed_x, 2.1 * input_x , accel)

        -- facing 
        if input_x != 0 then
            self.facing = input_x
        end

        -- gravity
        if not on_ground then
            local gravity = self.speed_y * g_dir < 0 and 0.72 or 0.54
            self.speed_y = approach(self.speed_y, 5.4 * g_dir, gravity)
        end

        -- variable jumping
        if self.jumping then
            if self.speed_y * g_dir >= 0 then
                self.jumping = false
            elseif not input_jump then
                self.speed_y *= 0.5
                self.jumping = false
            end
        end

        -- jumping
        if input_jump_pressed > 0 then
            if self.t_jump_grace > 0 then
                self:jump()
            end
        end
    elseif self.state == 1 then
         -- springboard bounce state 
        self.t_bounce += 1
        self.springboard.spr = 43
        if self.t_bounce < 6 then
            local at_y = approach(self.y, self.springboard.y - 2 * g_dir, 1.5)
            self:move_y(at_y - self.y)
        elseif self.t_bounce == 8 then
            self:spring()
        end
    elseif self.state == 2 then
        self.delay -= 1
        if self.delay == 0 then
            goto_level(level_index + 1)
            music(-1)
            sfx(14)
        end
        return
    end

    -- switch gravity
    if self.can_switch and input_switch_pressed > 0 then
        self:switch()
    end

    -- apply 
    self:move_x(self.speed_x)
    self:move_y(self.speed_y)

    -- object interactions
    for o in all(objects) do
        if o.base == crumble and not o.breaking then
            -- crumble
            if self:overlaps(o, 0, g_dir) then
                o.breaking = true
                sfx(10)
            end
        elseif o.base == springboard and self:overlaps(o) and self.state != 1 and self:bounce_check(o) then
            -- springboard
            self.speed_x = 0
            self.speed_y = 0
            self.springboard = o
            self.t_bounce = 0
            self.state = 1
            self:move_y(o.y - 8 * g_dir - self.y)
            self.can_switch = true
        elseif o.base == smasher and self:overlaps(o) then
            -- smasher
            self:die()
            return
        elseif o.base == mover then
            -- mover
            if self:overlaps(o, 0, g_dir) then
                if self.speed_y == 0 and self.mover != o then
                    o.state = 1
                    self.mover = o
                    o.player = self
                end
            elseif self.mover == o then
                self.mover.player = nil
                self.mover = nil
            end
        elseif o.base == checkpoint and o.id != level_checkpoint and self:overlaps(o) then
            -- checkpoint
            level_checkpoint = o.id
            sfx(11)
        end
    end

    -- death
    if (self.y + self.hit_y - 16 > level_top() * 8 and g_dir == 1) or 
            (self.y + self.hit_y + self.hit_h - 1 + 16 < level_bottom() * 8 and g_dir == -1) or
                self:hazard_check() then
        self:die()
        return
    end

    -- bounds
    if self.x + self.hit_x < 0 then
        self.x = -self.hit_x
        object.on_collide_x(self)
    elseif self.x + 1 > 1024 then
        self.state = 2
        self.delay = 5
    end

    self.was_on_ground = on_ground
         
    -- camera
    set_camera_target(self.x)

    -- animation
    if not on_ground and self.state != 1 then
        self.spr = 2
    elseif input_x != 0 then
        self.spr += 0.25
        if self.spr >= 3 then
            self.spr = 1
        end
    else
        self.spr = 1
    end 
end

function player:draw()
    spr(self.spr, self.x, self.y, 1, 1, self.facing != 1, g_dir != 1)
end