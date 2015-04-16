ComponentEnemy = {}

local boxExtent = {x=32, y=32}
local enemyExtent = {x=32, y=32}
local playerExtent = {x=128, y=256}

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

    if gengine.math.doRectanglesIntersect(p, enemyExtent, Game.player.position, playerExtent) then
        Game.player.player:hit(10)
        local e = Factory:createBlood()
        e:insert()
        e.position:set(p)

        self.entity:remove()

        Game:addKills(1)
    end
end

function ComponentEnemy:remove()
    gengine.audio.playSound(Factory.hitSound, 0.6)

    local e = self.entity
    local enemies = Game.enemies
    for k = #enemies, 1, -1 do
        if enemies[k] == e then
            table.remove(enemies, k)
            return
        end
    end
end
