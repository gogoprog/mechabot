
Map = Map or {
    parallaxes = {},
    boxes = {},
    futureBoxes = {},
    x = 0,
    stuckTime = 0,
    futureEnemies = {}
}

function Map:init()
    self.cameraEntity = Factory:createCamera()
    self.cameraEntity:insert()
    self.definitions = dofile("data/defs/maps.lua")
end

function Map:start(index)
    local map = self.definitions[index]
    local parallaxesDefs = dofile("data/defs/parallaxes.lua")

    self:loadFile(map.filename)

    for k, v in ipairs(parallaxesDefs[map.parallaxes]) do
        local p = Factory:createParallax(v.y, v.speed, v.texture)
        table.insert(self.parallaxes, p)
        p:insert()
    end

    self.x = 0
    self.parallaxOffset = 0
    self.cameraEntity.position = Vector3(0, 512, 0)

    gengine.audio.playMusic(map.music, 0.8, true)
    self.definition = map
end

function Map:stop()
    for k, v in ipairs(self.parallaxes) do
        gengine.entity.destroy(v)
    end

    for k, v in ipairs(self.boxes) do
        gengine.entity.destroy(v)
    end

    for k, v in ipairs(self.futureBoxes) do
        gengine.entity.destroy(v)
    end

    for k, v in ipairs(self.futureEnemies) do
        gengine.entity.destroy(v)
    end

    self.boxes = {}
    self.futureBoxes = {}
    self.parallaxes = {}
    self.futureEnemies = {}

    gengine.audio.stopMusic()
end

function Map:update(dt)
    if self.x < self.length - 500 then
        self.x = Game.player.position.x + 650
        self.parallaxOffset = self.x
        for k, v in ipairs(self.parallaxes) do
            v.position.x = self.x
        end
    else
        self.x = self.length - 500
    end

    self.cameraEntity.position.x = self.x

    self:handleFutureBoxes()
    self:handleFutureEnemies()
    self:handleBoxes()
end

function Map:crushUnderPlayer(collide_position, extent, force)
    local boxes = self.boxes
    for k = #boxes, 1, -1 do
        local e = boxes[k]
        if gengine.math.doRectanglesIntersect(collide_position + Vector2(0, -16), extent, e.position, Vector2(32, 32)) then
            e.box:hit(force, k)
        end
    end
end

function Map:collides(collide_position, extent)
    for k, v in ipairs(self.boxes) do
        local p = v.position
        if gengine.math.doRectanglesIntersect(collide_position, extent, p, Vector2(32, 32)) then
            return true
        end
    end

    if collide_position.y - extent.y/2 < 0 then
        return true
    end

    return false
end

function Map:movePlayer(player_position, collide_position, extent, velocity, dt, up, down)
    local movement = velocity * dt
    up = up or 5
    down = down or 6

    if self:collides(collide_position + Vector2(0, up), extent) then
        return 1
    end

    player_position.y = player_position.y + up
    collide_position.y = collide_position.y + up

    if self:collides(collide_position + movement, extent) then
        player_position.y = player_position.y - up
        collide_position.y = collide_position.y - up
        return 2
    end

    player_position.x = player_position.x + movement.x
    player_position.y = player_position.y + movement.y

    collide_position.x = collide_position.x + movement.x
    collide_position.y = collide_position.y + movement.y

    if self:collides(collide_position + Vector2(0, -down), extent) then
        player_position.y = player_position.y - up
        collide_position.y = collide_position.y - up
        return 3
    end

    player_position.y = player_position.y - up
    collide_position.y = collide_position.y - up

    return 0
end

function Map:handleFutureBoxes()
    local futureBoxes = self.futureBoxes
    for k = #futureBoxes, 1, -1 do
        local v = futureBoxes[k]
        if v.position.x < self.x + 1200 then
            futureBoxes[k] = futureBoxes[#futureBoxes]
            futureBoxes[#futureBoxes] = nil

            table.insert(self.boxes, v)
            v:insert()
        end
    end
end

function Map:handleFutureEnemies()
    for k, v in ipairs(self.futureEnemies) do
        if v.position.x < self.x + 1200 then
            self.futureEnemies[k] = self.futureEnemies[#self.futureEnemies]
            self.futureEnemies[#self.futureEnemies] = nil
            v:insert()
            return
        end
    end
end

function Map:handleBoxes()
    for k, v in ipairs(self.boxes) do
        if v.position.x < self.x - 1200 then
            self.boxes[k] = self.boxes[#self.boxes]
            self.boxes[#self.boxes] = nil

            v:remove()
            gengine.entity.destroy(v)
            return
        end
    end
end

function Map:removeBox(k, v)
    self.boxes[k] = self.boxes[#self.boxes]
    self.boxes[#self.boxes] = nil

    v:remove()
    gengine.entity.destroy(v)
end

function Map:loadFile(filename)
    self.futureBoxes = gengine.tiled.createEntities(filename, Vector2(0,-32))

    local info = self.futureBoxes[1].tileMap.info
    self.length = info.tileWidth * info.width
end
