ComponentFlyingEnemy = {}

local enemyExtent = {x=64, y=64}
local playerExtent = {x=256, y=512}

function ComponentFlyingEnemy:init()
    self.speed = self.speed or 150
    self.vy = 0
end

function ComponentFlyingEnemy:insert()
    local p = self.entity.position
    self.initialPosition = vector2(p.x, p.y)
    print(p.x)
    table.insert(Game.enemies, self.entity)
end

function ComponentFlyingEnemy:update(dt)
    if not Game.running then
        return
    end

    if self.positions then
        if not self.currentTargetPositionIndex or self.time > self.duration then
            local initial_p = self.initialPosition

            self.currentTargetPositionIndex = (self.currentTargetPositionIndex or 1) + 1

            print(self.currentTargetPositionIndex)
            self.fromPosition = vector2(initial_p.x + self.positions[self.currentTargetPositionIndex - 1].x, initial_p.y + self.positions[self.currentTargetPositionIndex - 1].y)
            self.toPosition = vector2(initial_p.x + self.positions[self.currentTargetPositionIndex].x, initial_p.y + self.positions[self.currentTargetPositionIndex].y)
            local length = gengine.math.getDistance(self.fromPosition, self.toPosition)
            self.duration = length / self.speed
            print("from " .. self.fromPosition.x)
            print("to " .. self.toPosition.x)

            self.time = self.time or 0

            while self.time > self.duration do
                self.time = self.time - self.duration
            end
        end

        self.time = self.time + dt

        self.entity.position = self.fromPosition + (self.toPosition - self.fromPosition) * (self.time / self.duration)
    end

    local p = self.entity.position

    if Game.player.player.life > 0 and gengine.math.doRectanglesIntersect(p, enemyExtent, Game.player.position, playerExtent) then
        Game.player.player:hit(10)
        local e = Factory:createBlood()
        e:insert()
        e.position:set(p)

        self:removeFromGame()
        gengine.audio.playSound(Factory.hitSound, 0.6)

        Game:addScore(100)
    end
end

function ComponentFlyingEnemy:remove()
end

function ComponentFlyingEnemy:removeFromGame()
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
