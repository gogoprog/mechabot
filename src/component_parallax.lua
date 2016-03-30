ComponentParallax = {}

function ComponentParallax:init()
end

function ComponentParallax:insert()
end

function ComponentParallax:update(dt)
    local e = self.entity
    local offset = Map.parallaxOffset * self.speed
    e.sprite.textureRect = Rect(Vector2(offset, 1), Vector2(1 + offset, 0))
end

function ComponentParallax:remove()
end
