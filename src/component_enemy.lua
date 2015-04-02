ComponentEnemy = {}

local boxExtent = {x=32, y=32}

function ComponentEnemy:init()
    self.speed = self.speed or 100
    self.vy = 0
end

function ComponentEnemy:insert()
    table.insert(Game.enemies, self.entity)
end

function ComponentEnemy:update(dt)
    local p = self.entity.position

    p.x = p.x - self.speed * dt

    p.y = p.y + self.vy * dt

    local testPosition = p - vector2(0, 16)

    if p.y > 16 then

        for k, v in ipairs(Map.boxes) do
            if gengine.math.doesCircleIntersectRectangle(testPosition, 1, v.position, boxExtent) then
                self.vy = 0
            end
        end

        self.vy = self.vy - 1000 * dt
    else
        self.vy = 0
    end
end

function ComponentEnemy:remove()
    gengine.audio.playSound(Factory.hitSound, 0.6)

    local e = self.entity
    for k, v in ipairs(Game.enemies) do
        if v == e then
            table.remove(Game.enemies, k)
            return
        end
    end
end
