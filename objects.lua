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
        end

        if self.time >= 90 then
            local can_respawn = true

            for o in all(objects) do
                if self:overlaps(o) then can_respawn = false break end
            end

            if can_respawn then
                self.breaking = false
                self.solid = true
                self.time = 0
            end
        end
    end
end

function crumble:draw()
    if self.time < 10 then
        object.draw(self)
    end
end

springboard = new_type(42)

function springboard:update()
    -- gravity
    if not self:check_solid(0, g_dir) then
        self.speed_y = approach(self.speed_y, g_dir * 4.2, 0.27)
    end

    -- apply
    self:move_y(self.speed_y)

    if self.player then
        self.player:move_y(self.speed_y)
    end
end

function springboard:on_collide_y()
    if abs(self.speed_y) >= 2.1 then
        self.speed_y *= -0.21
    else
        self.speed_y = 0
    end

    self.remainder_y = 0
    return true
end