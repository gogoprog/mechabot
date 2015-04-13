ComponentPlayer = {}

local weapons = dofile("weapons.lua")

function ComponentPlayer:init()
    self.life = 1000
end

function ComponentPlayer:insert()
end

function ComponentPlayer:update(dt)

end

function ComponentPlayer:remove()

end

function ComponentPlayer:hit(dmg)
    self.life = self.life - dmg
    self.entity.blink:blink()

    if self.life < 0 then
        print("Game is lost. Humaniy has won.")
    end

    gengine.gui.executeScript("updateLife(" .. self.life / 1000 .. ")")
end

function ComponentPlayer:initWeapon(name, level)
    local def = weapons[name]
    self.weapon = {}
    local w = self.weapon

    for k, v in pairs(def) do
        w[k] = v(level)
    end
end