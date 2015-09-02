ComponentPlayer = {}

local generators = dofile("generators.lua")

function ComponentPlayer:init()
    self.life = 1000
    self.extent = vector2(300, 1024)
    self.lastGenUpdate = 0
end

function ComponentPlayer:insert()
end

function ComponentPlayer:update(dt)
    local g = self.generator

    g.currentValue = g.currentValue + g.powerPerSecond * dt

    if g.currentValue > g.capacity then
        g.currentValue = g.capacity
    end

    self.lastGenUpdate = self.lastGenUpdate + dt

    if self.lastGenUpdate > 0.15 then
        local v = g.currentValue / g.capacity

        gengine.gui.executeScript("updateGenerator(" .. v .. ")")

        self.lastGenUpdate = 0
    end
end

function ComponentPlayer:remove()

end

function ComponentPlayer:hit(dmg)
    self.life = self.life - dmg
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
    local def = generators[name]
    self.generator = {}

    for k, v in pairs(def) do
        self.generator[k] = v
    end

    self.generator.currentValue = self.generator.capacity
end
