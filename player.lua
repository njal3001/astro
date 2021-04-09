player = new_type(1)
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
end

function player:bounce_check(obj)
    return self.speed_y * g_dir >= 0 and
        ((g_dir == 1 and self.y - self.speed_y < obj.y + obj.speed_y - 7) or
        (g_dir == -1 and self.y - self.speed_y > obj.y + obj.speed_y + 7))
end

function player:spring(failed)
    if failed then
        self.speed_y = -4.1 * g_dir
    else
        self.speed_y = -7.9 * g_dir
        self.jumping = true
    end
    
    self.t_jump_grace = 0
    self.remainder_y = 0

    self:leave_springboard()
end

function player:leave_springboard()
    self.state = 0
    self.springboard.player = nil
    self.springboard.spr = 42

    for o in all(objects) do
        if o.base == crumble and not o.breaking and self.springboard:overlaps(o, 0, g_dir * 4) then
            o.breaking = true
        end
    end 

    self.springboard = nil
end

function player:switch()
    consume_switch_press()
    g_dir *= -1
    self.can_switch = false
end

function player:die()
    restart_level()
end

--[[
    player states:
        0 - normal
        1 - springboard bounce
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

    -- running 
    local accel = 0.1
    if on_ground then
        accel = 0.45
    elseif input_x != 0 then
        accel = 0.35
    end

    if (self.springboard) accel *= 0.5

    self.speed_x = approach(self.speed_x, 2.1 * input_x , accel)

    if self.state == 0 then
        -- normal state

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

        -- switch gravity
        if self.can_switch and input_switch_pressed > 0 then
            self:switch()
        end

    elseif self.state == 1 then
        -- springboard bounce state 
        if not self:overlaps(self.springboard, 0, g_dir) then
            self:leave_springboard()
        else
            self.t_bounce += 1

            if self.t_bounce > 8 then
                self:spring(true)
            else
                if self.t_bounce < 4 then
                    local at_y = approach(self.y, self.springboard.y + 4 * g_dir, 1.8)
                    self:move_y(at_y - self.y)
                    if self.t_bounce == 2 then 
                        self.springboard.spr = 43
                        self.springboard.flip_y = g_dir == -1
                    end
                else
                    if (input_jump) self:spring(false)
                end
            end
        end
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
            end
        elseif o.base == springboard and self.state != 1 and self:overlaps(o) and self:bounce_check(o) then
            -- springboard
            self.state = 1
            self.speed_x = 0
            object.on_collide_y(self)
            self.springboard = o
            self.t_bounce = 0
            o.player = self
            self:move_y(o.y - 8 * g_dir - self.y)
        elseif o.base == smasher and self:overlaps(o) then
            -- smasher
            self:die()
            return
        end
    end

    -- death
    if (self.y + self.hit_y - 16 > (level.height + level.y) * 8 and g_dir == 1) or 
            (self.y + self.hit_y + self.hit_h - 1 + 16 < level.y * 8 and g_dir == -1) or
                self:hazard_check() then
        self:die()
    end

    -- bounds
    if self.x + self.hit_x < 0 then
        self.x = self.hit_x
        object.on_collide_x(self)
    elseif self.x + self.hit_x + self.hit_w - 1 > level.width * 8 then
        self.x = level.width * 8 - (self.hit_x + self.hit_w - 1)
        object.on_collide_x(self)
    end

    self.was_on_ground = on_ground
         
    --camera
    update_camera_target(self.x, self.y)
    camera_x = approach(camera_x, camera_target_x, 5)
    camera_y = approach(camera_y, camera_target_y, 5)
    camera(camera_x, camera_y)
end