ComponentPlayer = {}

function ComponentPlayer:init()
    self.life = 1000
    self.extent = vector2(300, 1024)
    self.lastGenUpdate = 0
end

function ComponentPlayer:insert()
end

function ComponentPlayer:update(dt)
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

    if self.lastGenUpdate > 0.15 then
        gengine.gui.executeScript("updateGenerator(" .. g.currentValue / g.capacity .. ")")
        gengine.gui.executeScript("updateShield(" .. s.currentValue / s.capacity .. ")")

        self.lastGenUpdate = 0
    end
end

function ComponentPlayer:remove()

end

function ComponentPlayer:hit(dmg)
    local shield_dmg = math.min(dmg * self.shield.absorption, self.shield.currentValue)
    local real_dmg = dmg - shield_dmg
    self.shield.currentValue = self.shield.currentValue - shield_dmg
    self.life = self.life - real_dmg
    self.entity.blink:blink()

    if self.life < 0 then
        print("Game is lost. Humanity has won.")
    end

    gengine.gui.executeScript("updateLife(" .. self.life / 1000 .. ")")
end

function ComponentPlayer:initWeapon(name, level)
    local w = Game:getWeapon(name, level)
    Game.arm.arm.bulletSound = gengine.audio.sound.get(w.sound)
    self.weapon = w
end

function ComponentPlayer:initGenerator(name)
    self.generator = Game:getGenerator(name)
    self.generator.currentValue = self.generator.capacity
end

function ComponentPlayer:initShield(name)
    self.shield = Game:getShield(name)
    self.shield.currentValue = self.shield.capacity
end
