
Map = Map or {
    parallaxes = {},
    boxes = {},
    futureBoxes = {},
    x = 0
}

local playerExtent = {x=128, y=256}
local boxExtent = {x=32, y=32}

function Map:init()
    local p

    p = Factory:createParallax(128, 48, 1/4096, "ground", 960/4096, 1)
    table.insert(self.parallaxes, p)

    p = Factory:createParallax(512, 220, 0.0001, "hills_1", 960/4096)
    table.insert(self.parallaxes, p)

    p = Factory:createParallax(512, 220, 0.00005, "hills_2", 960/4096)
    table.insert(self.parallaxes, p)

    p = Factory:createParallax(512, 220, 0.00002, "buildings", 960/4096)
    table.insert(self.parallaxes, p)

    p = Factory:createParallax(512, 270, 0, "sky_colours", 960/4096 * 2)
    table.insert(self.parallaxes, p)

    self.cameraEntity = Factory:createCamera()
    self.cameraEntity:insert()
end

function Map:start(map)
    self:loadFile("data/" .. map .. ".lua")

    for k, v in ipairs(self.parallaxes) do
        v:insert()
    end

    self.x = 0
    self.cameraEntity.position:set(0, 256)
    Game.player.position:set(self.x - 256, 120)
end

function Map:stop()
    for k, v in ipairs(self.parallaxes) do
        v:remove()
    end

    for k, v in ipairs(self.boxes) do
        v:remove()
        gengine.entity.destroy(v)
    end

    self.boxes = {}

    for k, v in ipairs(self.futureBoxes) do
        gengine.entity.destroy(v)
    end

    self.futureBoxes = {}
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
        if gengine.math.doRectanglesIntersect(player_position, playerExtent, p, boxExtent) then
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

function Map:removeBox(k, v)
    self.boxes[k] = self.boxes[#self.boxes]
    self.boxes[#self.boxes] = nil

    v:remove()
    gengine.entity.destroy(v)
end

function Map:loadFile(filename)
    self.futureBoxes = gengine.tiled.createEntities(filename)
end
