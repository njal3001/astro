player = new_type(1)
player.t_jump_grace = 0
player.t_var_jump = 0
player.jumping = false
player.can_switch = true

function player:init()
    player_inst = self
end

function player:on_collide_x(dir)
    if dir == input_x and self:corner_correct(dir, 0, 2 * g_dir, -1) then
        return false
    end

    return object.on_collide_x(self, dir)
end

function player:on_collide_y(dir)
    if dir < 0 and input_jump and self:corner_correct(0, -g_dir, 2, input_x) then
        return true
    end

    return object.on_collide_y(self, dir)
end

function player:jump()
    consume_jump_press()
    self.jumping = true
    self.speed_y = -6.2 * g_dir
    self.speed_x += 0.32 * input_x
    self.t_jump_grace = 0
    self:move_y(self.jump_grace_y - self.y)
end

function player:switch()
    consume_switch_press()
    g_dir *= -1
    self.can_switch = false
end

function player:die()
    restart_level()
end

function player:update()
    -- facing 
    if input_x != 0 then
        self.facing = input_x
    end
    
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

    -- gravity
    if not on_ground then
        local gravity = self.speed_y * g_dir < 0 and 0.72 or 0.54
        self.speed_y = approach(self.speed_y, 5.4 * g_dir, gravity)
    end

    -- running 
    local accel = 0.1
    if on_ground then
        accel = 0.45
    elseif input_x != 0 then
        accel = 0.35
    end

    self.speed_x = approach(self.speed_x, 2.1 * input_x , accel)

    -- variable jumping
    if self.jumping then
        if self.speed_y >= 0 then
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

    if self.can_switch and input_switch_pressed > 0 then
        self:switch()
    end

    -- apply 
    self:move_x(self.speed_x)
    self:move_y(self.speed_y)

    -- check bounds
    if (self.y + self.hit_y - 16 > (level.height + level.y) * 8 and g_dir == 1) or 
            (self.y + self.hit_y + self.hit_h - 1 + 16 < level.y * 8 and g_dir == -1) then
        self:die()
    end

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