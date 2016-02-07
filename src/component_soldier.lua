ComponentSoldier = {}

local playerExtent = {x=256, y=512}

function ComponentSoldier:init()
    self.speed = self.speed or 150
    self.vy = 0
    self.def = {
        extent = vector2(64, 64)
    }
end

function ComponentSoldier:insert()
    table.insert(Game.enemies, self.entity)
end

function ComponentSoldier:update(dt)
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

    if Game.player.player.life > 0 and gengine.math.doRectanglesIntersect(p, self.def.extent, Game.player.position, playerExtent) then
        Game.player.player:hit(10)
        self:hit(10)
    end

    if p.x < Game.player.position.x - 512 then
        self:removeFromGame()
    end
end

function ComponentSoldier:remove()
end

function ComponentSoldier:removeFromGame()
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

function ComponentSoldier:hit(dmg)
    Game.player.player:hit(10)
    local e = Factory:createEffect("blood")
    e:insert()
    e.position:set(self.entity.position)

    self:removeFromGame()

    Game:addScore(10)
end
