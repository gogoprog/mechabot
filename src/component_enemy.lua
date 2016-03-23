ComponentEnemy = {}

function ComponentEnemy:init()
end

function ComponentEnemy:insert()
    local p = self.entity.position
    self.initialPosition = Vector2(p.x, p.y)
    table.insert(Game.enemies, self.entity)
    self.currentTargetPositionIndex = nil
    self.life = self.def.life or 10
    self.speed = self.def.speed or 150
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

    local player = Game.player
    if player.player.life > 0 then
        if gengine.math.doRectanglesIntersect(self.entity.position, self.def.extent, player.position, player.player.extent) then
            player.player:hit(self.life)
            self:hit(500)
        end
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

function ComponentEnemy:hit(dmg)
    self.life = self.life - dmg

    self.entity.blink:blink()

    if self.life <= 0 then
        local e = Factory:createEffect("explosion")
        e:insert()
        e.position = Vector3(self.entity.position)
        self:removeFromGame()
    end
end
