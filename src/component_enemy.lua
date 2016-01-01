ComponentEnemy = {}

local enemyExtent = {x=64, y=64}
local playerExtent = {x=256, y=512}

function ComponentEnemy:init()
    self.speed = self.speed or 150
    self.vy = 0
end

function ComponentEnemy:insert()
    table.insert(Game.enemies, self.entity)
end

function ComponentEnemy:update(dt)
    if not Game.running then
        return
    end

    local p = self.entity.position

    p.x = p.x - self.speed * dt
    p.y = p.y + self.vy * dt

    local testPosition = p - vector2(0, 0)

    if p.y > 0 then
        for k, v in ipairs(Map.boxes) do
            if not v.spawner and gengine.math.doesCircleIntersectRectangle(testPosition, 1, v.position, v.sprite.extent) then
                self.vy = 0
                p.y = v.position.y + v.sprite.extent.y * 0.5
            end
        end

        self.vy = self.vy - 1000 * dt
    else
        self.vy = 0
    end

    if Game.player.player.life > 0 and gengine.math.doRectanglesIntersect(p, enemyExtent, Game.player.position, playerExtent) then
        Game.player.player:hit(10)
        local e = Factory:createBlood()
        e:insert()
        e.position:set(p)

        self:removeFromGame()
        gengine.audio.playSound(Factory.hitSound, 0.6)

        Game:addKills(1)
    end
end

function ComponentEnemy:remove()
end

function ComponentEnemy:removeFromGame()
    local e = self.entity
    local enemies = Game.enemies
    e:remove()
    for k = #enemies, 1, -1 do
        if enemies[k] == e then
            table.remove(enemies, k)
            return
        end
    end
end
