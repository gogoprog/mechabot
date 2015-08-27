
Map = Map or {
    parallaxes = {},
    boxes = {},
    futureBoxes = {},
    x = 0
}

local playerExtent = {x=512, y=1024}
local boxExtent = {x=32, y=32}

function Map:init()
    self.cameraEntity = Factory:createCamera()
    self.cameraEntity:insert()
    self.definitions = dofile("maps.lua")
end

function Map:start(index)
    local map = self.definitions[index]

    self:loadFile(map.filename)

    for k, v in ipairs(map.parallaxes) do
        local p = Factory:createParallax(v.y, v.speed, v.texture)
        table.insert(self.parallaxes, p)
        p:insert()
    end

    self.x = 0
    self.cameraEntity.position:set(0, 512)
    Game.player.position:set(self.x - 650, 0)

    gengine.audio.playMusic(map.music, 0.5, true)
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
    self.parallaxes = {}
end

function Map:update(dt)
    if not self:isPlayerBlocked(dt) then
        self.x = self.x + dt * 150
        self.cameraEntity.position.x = self.x

        for k, v in ipairs(self.parallaxes) do
            v.position.x = self.x
        end

        Game.player.position.x = self.x - 650
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
        if v.position.x < self.x + 1200 then
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
    self.futureBoxes = gengine.tiled.createEntities(filename,vector2(0,-32))
end
