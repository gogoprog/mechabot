ComponentPlayer = {}

local input

function ComponentPlayer:init()
    input = gengine.input
end

function ComponentPlayer:insert()
    self.maxLife = 100
    self.life = self.maxLife
    self.extent = vector2(300, 1024)
    self.lastGenUpdate = 0
    self.entity.sprite.animation = gengine.graphics.spriter.get("mecha-walk")
    gengine.gui.executeScript("updateLife(" .. self.life / self.maxLife .. ")")
    self.velocity = vector2(0, 0)
end

local mmax = math.max
local mmin = math.min
local mabs = math.abs

function ComponentPlayer:update(dt)
    local position = self.entity.position
    local velocity = self.velocity

    if self.life > 0 then
        local g = self.generator
        local s = self.shield

        g.currentValue = g.currentValue + g.powerPerSecond * dt

        if g.currentValue > g.capacity then
            g.currentValue = g.capacity
        end

        if s.currentValue < s.capacity then
            local v = s.powerCostPerSecond * dt
            if g.currentValue > v then
                g.currentValue = g.currentValue - v
                s.currentValue = math.min(s.currentValue + s.regenerationPerSecond * dt, s.capacity)
            end
        end

        self.lastGenUpdate = self.lastGenUpdate + dt

        if self.lastGenUpdate > 0.05 then
            gengine.gui.executeScript("updateGenerator(" .. g.currentValue / g.capacity .. ")")
            gengine.gui.executeScript("updateShield(" .. s.currentValue / s.capacity .. ")")

            self.lastGenUpdate = 0
        end

        local x_move = self:getXMove()

        if x_move then
            velocity.x = 150 * x_move
        else
            if velocity.x > 0 then
                velocity.x = math.max(velocity.x - 100 * dt, 0)
            elseif velocity.x < 0 then
                velocity.x = math.min(velocity.x + 100 * dt, 0)
            end
        end

        if position.y == 0 and input.keyboard:isDown(26) then
            velocity.y = velocity.y + 1024
        end
    end

    if position.y < 0 then
        position.y = 0
        velocity.y = 0
        Map.cameraEntity.shaker:shake(0.3, 10)
    elseif position.y > 0 then
        velocity.y = velocity.y - 1500 * dt
    end

    if position.y == 0 then
        Game.player.sprite.timeFactor = mabs(velocity.x) / 120
    else
        Game.player.sprite.timeFactor = 0
    end

    self.entity.position = position + velocity * dt
end

function ComponentPlayer:remove()

end

function ComponentPlayer:hit(dmg)
    if Game.running then
        local shield_dmg = math.min(dmg * self.shield.absorption, self.shield.currentValue)
        local real_dmg = dmg - shield_dmg
        self.shield.currentValue = self.shield.currentValue - shield_dmg
        self.life = self.life - real_dmg
        self.entity.blink:blink()
        Game.arm.blink:blink()

        if self.life <= 0 then
            Game.player.sprite.timeFactor = 1
            self.entity.sprite.animation = gengine.graphics.spriter.get("mecha-death"..math.random(1,2))
            Game:changeState("dying")
        end

        gengine.gui.executeScript("updateLife(" .. self.life / self.maxLife .. ")")
    end
end

function ComponentPlayer:setWeapon(name, level)
    local w = Game:getWeapon(name, level)
    self.weapon = w
    Game.arm.arm.weapon = w
end

function ComponentPlayer:setGenerator(name, level)
    self.generator = Game:getGenerator(name, level)
    self.generator.currentValue = self.generator.capacity
end

function ComponentPlayer:setShield(name, level)
    self.shield = Game:getShield(name, level)
    self.shield.currentValue = self.shield.capacity
end

function ComponentPlayer:getXMove()
    if input.keyboard:isDown(7) or input.keyboard:isDown(79) then
        return 1
    end

    if input.keyboard:isDown(4) or input.keyboard:isDown(81) then
        return -1
    end

    return false
end
