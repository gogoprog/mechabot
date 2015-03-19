ComponentBoxExplosion = {}

function ComponentBoxExplosion:init()
end

function ComponentBoxExplosion:insert()
    self.timeLeft = 1
end

function ComponentBoxExplosion:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        self.entity:remove()
    end
end

function ComponentBoxExplosion:remove()
    table.insert(Factory.boxExplosions, self.entity)
end

function ComponentBoxExplosion:setPosition(i, j)
end
