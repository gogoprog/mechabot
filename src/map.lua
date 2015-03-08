
Map = Map or {
    parallaxes = {},
    boxes = {},
    futureBoxes = {},
    x = 0
}

function Map:init()
    local p

    p = Factory:createParallax(256, -128, 1 / 800, "ground")
    table.insert(self.parallaxes, p)

    p = Factory:createParallax(128, 64, 0.0002, "mountains")
    table.insert(self.parallaxes, p)

    p = Factory:createParallax(600, 256, 0, "stars")
    table.insert(self.parallaxes, p)

    self.cameraEntity = gengine.entity.create()
    self.cameraEntity:addComponent(ComponentCamera(), { extent = vector2(800, 600) }, "camera")
    self.cameraEntity.position.y = 256
    self.cameraEntity:insert()

    for i = 1, 100 do
        local b = Factory:createBox(math.random(1, 100), math.random(1, 10))
        table.insert(self.futureBoxes, b)
    end

    Game.player.position.x = self.x - 256
    Game.player.position.y = 128
end

function Map:start()
    for k, v in ipairs(self.parallaxes) do
        v:insert()
    end
end

function Map:update(dt)
    if not self:isPlayerBlocked(dt) then
        self.x = self.x + dt * 100
        self.cameraEntity.position.x = self.x

        for k, v in ipairs(self.parallaxes) do
            v.position.x = self.x
        end

        Game.player.position.x = self.x - 256
    end

    self:handleFutureBoxes()
    self:handleBoxes()
end

function Map:isPlayerBlocked(dt)
    local player_position = Game.player.position
    player_position.x = player_position.x + dt * 100
    for k, v in ipairs(self.boxes) do
        local p = v.position
        if not(player_position.x + 64 < p.x - 16 or p.x + 16 < player_position.x - 64 or player_position.y + 128 < p.y - 16 or p.y + 16 < player_position.y - 128) then
            player_position.x = player_position.x - dt * 100
            return true
        end
    end

    return false
end

function Map:handleFutureBoxes()
    for k, v in ipairs(self.futureBoxes) do
        if v.position.x < self.x + 600 then
            self.futureBoxes[k] = self.futureBoxes[#self.futureBoxes]
            self.futureBoxes[#self.futureBoxes] = nil

            table.insert(self.boxes, v)
            v:insert()
            return
        end
    end
end

function Map:handleBoxes()
    for k, v in ipairs(self.boxes) do
        if v.position.x < self.x - 600 then
            self.boxes[k] = self.boxes[#self.boxes]
            self.boxes[#self.boxes] = nil

            v:remove()
            gengine.entity.destroy(v)
            return
        end
    end
end
