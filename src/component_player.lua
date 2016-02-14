ComponentPlayer = {}

local input

gengine.stateMachine(ComponentPlayer)

local mmax = math.max
local mmin = math.min
local mabs = math.abs

function ComponentPlayer:init()
    input = gengine.input
end

function ComponentPlayer:insert()
    self.def = dofile('data/defs/player.lua')
    self.life = self.def.initialLife
    self.extent = self.def.extent
    self.lastGenUpdate = 0
    self.entity.sprite.animation = gengine.graphics.spriter.get("mecha-walk")
    gengine.gui.executeScript("updateLife(" .. self.life / self.def.initialLife .. ")")
    self.velocity = vector2(0, 0)

    self.collidePosition = self.entity.position + vector2(0, self.extent.y / 2)

    self:changeState("idling")
end

function ComponentPlayer:update(dt)
    local position = self.entity.position
    local velocity = self.velocity
    self.collidePosition = position + vector2(0, self.extent.y / 2)

    if (self.life > 0 and Game.running) or Game.state == "shop" then
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
                s.currentValue = mmin(s.currentValue + s.regenerationPerSecond * dt, s.capacity)
            end
        end

        self.lastGenUpdate = self.lastGenUpdate + dt

        if self.lastGenUpdate > 0.05 then
            gengine.gui.executeScript("updateGenerator(" .. g.currentValue / g.capacity .. ")")
            gengine.gui.executeScript("updateShield(" .. s.currentValue / s.capacity .. ")")

            self.lastGenUpdate = 0
        end
    end

    if self.life > 0 and Game.running then
        local x_move = self:getXMove()
        self.xMove = x_move

        if x_move then

            if velocity.x * x_move < 0 then
                velocity.x = velocity.x + (self.def.acceleration+self.def.deceleration) * x_move * dt
            else
                velocity.x = velocity.x + self.def.acceleration * x_move * dt
            end

            if x_move > 0 then
                velocity.x = mmin(velocity.x, self.def.maxSpeed)
            elseif x_move < 0 then
                velocity.x = mmax(velocity.x, -self.def.maxSpeed)
            end
        end
    end

    self:updateState(dt)
end

function ComponentPlayer:remove()

end

function ComponentPlayer:hit(dmg)
    if Game.running then
        local shield_dmg = mmin(dmg * self.shield.absorption, self.shield.currentValue)
        local real_dmg = dmg - shield_dmg
        self.shield.currentValue = self.shield.currentValue - shield_dmg
        self.life = self.life - real_dmg
        self.entity.blink:blink()
        Game.arm.blink:blink()

        if self.life <= 0 then
            Game:changeState("dying")
            self:changeState("dying")
        end

        gengine.gui.executeScript("updateLife(" .. self.life / self.def.initialLife .. ")")
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

    if input.keyboard:isDown(4) or input.keyboard:isDown(80) then
        return -1
    end

    return false
end

function ComponentPlayer.onStateEnter:idling()
end

function ComponentPlayer.onStateUpdate:idling(dt)
end

function ComponentPlayer.onStateExit:idling()
end

function ComponentPlayer.onStateEnter:walking()
    self.velocity.y = 0
end

function ComponentPlayer.onStateUpdate:walking(dt)
    local position = self.entity.position
    local velocity = self.velocity

    if input.keyboard:isDown(26) or input.keyboard:isDown(82) then
        self:changeState("jumping")
        return
    end

    if not self.xMove then
        if velocity.x > 0 then
            velocity.x = mmax(velocity.x - self.def.deceleration * dt, 0)
        elseif velocity.x < 0 then
            velocity.x = mmin(velocity.x + self.def.deceleration * dt, 0)
        end
    end

    local r = Map:movePlayer(position, self.collidePosition, self.extent, velocity, dt)

    Game.player.sprite.timeFactor = mabs(velocity.x) / 120

    if r == 0 then
        self:changeState("falling")
    elseif r == 2 then
        velocity.x = 0
    end
end

function ComponentPlayer.onStateExit:walking()
    Game.player.sprite.timeFactor = 0
end

function ComponentPlayer.onStateEnter:jumping()
    self.velocity.y = self.def.jumpImpulse
end

function ComponentPlayer.onStateUpdate:jumping(dt)
    local position = self.entity.position
    local velocity = self.velocity

    velocity.y = velocity.y + self.def.gravity * dt

    if velocity.y < 0 then
        self:changeState("falling")
        return
    end

    local r = Map:movePlayer(position, self.collidePosition, self.extent, velocity, dt, 5, 0)
    if r == 1 then
        self:changeState("falling")
    elseif r == 2 then
        position.y = position.y + velocity.y * dt
    end
end

function ComponentPlayer.onStateExit:jumping()
end

function ComponentPlayer.onStateEnter:falling()
    self.velocity.y = 0
end

function ComponentPlayer.onStateUpdate:falling(dt)
    local position = self.entity.position
    local velocity = self.velocity

    velocity.y = velocity.y + self.def.gravity * dt

    local r = Map:movePlayer(position, self.collidePosition, self.extent, velocity, dt)

    if r ~= 0 then
        self:changeState("walking")
    end
end

function ComponentPlayer.onStateExit:falling()
    if self.velocity.y < -600 then
        Map.cameraEntity.shaker:shake(0.3, 10)
    end

    for x = -self.extent.x/2, self.extent.x/2, 32 do
        local e = Factory:createEffect("largeSmoke")
        e.position:set(self.entity.position)
        e.position.x = e.position.x + x
        e:insert()
    end

    Map:crushUnderPlayer(self.collidePosition, self.extent, -self.velocity.y / 10)
end

function ComponentPlayer.onStateEnter:dying()
    Game.player.sprite.timeFactor = 1
    self.entity.sprite.animation = gengine.graphics.spriter.get("mecha-death"..math.random(1,2))
end

function ComponentPlayer.onStateUpdate:dying(dt)
    local position = self.entity.position
    local velocity = self.velocity

    velocity.y = velocity.y + self.def.gravity * dt

    local r = Map:movePlayer(position, self.collidePosition, self.extent, velocity, dt)

end
