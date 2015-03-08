ComponentParallax = {}

function ComponentParallax:init()
end

function ComponentParallax:insert()
end

function ComponentParallax:update(dt)
    local e = self.entity

    e.sprite.uvOffset = vector2(Map.x * self.speed, 0)
end

function ComponentParallax:remove()
end