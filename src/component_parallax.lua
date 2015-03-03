ComponentParallax = {}

function ComponentParallax:init()
    self.total = 0
end

function ComponentParallax:insert()
end

function ComponentParallax:update(dt)
    local e = self.entity
    self.total = self.total + dt * self.speed

    e.sprite.uvOffset = vector2(self.total, 0)
end

function ComponentParallax:remove()
end