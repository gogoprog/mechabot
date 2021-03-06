ComponentSpawner = {}

function ComponentSpawner:init()
    self.timeLeft = 1
end

function ComponentSpawner:insert()
end

function ComponentSpawner:update(dt)
    if not Game.running then
        return
    end

    self.timeLeft = self.timeLeft - dt

    if self.timeLeft <= 0 then
        local position = self.entity.position
        local e = Factory:createSoldier()
        e.position = Vector3(position)
        e.position.y = e.position.y - self.entity.sprite.extent.y * 0.5
        e:insert()
        self.timeLeft = 1
    end
end

function ComponentSpawner:remove()
end
