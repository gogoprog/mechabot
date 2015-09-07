ComponentSpawner = {}

function ComponentSpawner:init()
    self.timeLeft = 1
end

function ComponentSpawner:insert()
end

function ComponentSpawner:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft <= 0 then
        local position = self.entity.position
        local e = Factory:createEnemy()
        e.position:set(position)
        e.position.y = e.position.y - self.entity.sprite.extent.y * 0.5
        e:insert()
        self.timeLeft = 1
    end
end

function ComponentSpawner:remove()
end
