ComponentEnemy = {}

local playerExtent = {x=256, y=512}

function ComponentEnemy:init()
    self.speed = self.def.speed or 150
end

function ComponentEnemy:insert()
    local p = self.entity.position
    self.initialPosition = vector2(p.x, p.y)
    table.insert(Game.enemies, self.entity)
    self.currentTargetPositionIndex = nil
end

function ComponentEnemy:update(dt)
    if not Game.running then
        return
    end

    local positions = self.positions
    if positions then
        if not self.currentTargetPositionIndex or self.time > self.duration then
            local initial_p = self.initialPosition
            self.currentTargetPositionIndex = (self.currentTargetPositionIndex or 1) + 1
            if self.currentTargetPositionIndex > #positions then
                self.entity.position = initial_p + positions[#positions]
                self.positions = nil
            else
                self.fromPosition = initial_p + positions[self.currentTargetPositionIndex - 1]
                self.toPosition = initial_p + positions[self.currentTargetPositionIndex]
                local length = gengine.math.getDistance(self.fromPosition, self.toPosition)
                self.duration = length / self.speed
                self.time = 0
            end
        end

        self.time = self.time + dt
        self.entity.position = self.fromPosition + (self.toPosition - self.fromPosition) * (self.time / self.duration)
    end

    local p = self.entity.position

    if Game.player.player.life > 0 and gengine.math.doRectanglesIntersect(p, self.def.extent, Game.player.position, playerExtent) then
        Game.player.player:hit(10)
        local e = Factory:createBlood()
        e:insert()
        e.position:set(p)

        self:removeFromGame()
        gengine.audio.playSound(Factory.hitSound, 0.6)

        Game:addScore(100)
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
