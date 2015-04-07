
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

    p = Factory:createParallax(64, -32, 10 / 800, "ground", 10, 1)
    table.insert(self.parallaxes, p)

    p = Factory:createParallax(500, 220, 0.0002, "mountains")
    table.insert(self.parallaxes, p)

    p = Factory:createParallax(nil, 240, 0, "stars")
    table.insert(self.parallaxes, p)

    self.cameraEntity = Factory:createCamera()
    self.cameraEntity.position.y = 256
    self.cameraEntity:insert()

    self:loadFile("data/map00.lua")

    Game.player.position.x = self.x - 256
    Game.player.position.y = 120
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
    local map = dofile(filename)
    local w = map.width
    local h = map.height
    local data = map.layers[1].data
    local tilesets = map.tilesets

    local indexToTileSet = {}

    for k, v in ipairs(tilesets) do
        local count
        if #v.tiles == 0 then
            count = (v.imagewidth / v.tilewidth) * (v.imageheight / v.tileheight)
        else
            count = #v.tiles
        end

        for i=1,count do
            table.insert(indexToTileSet, k)
        end
    end


    for k, v in ipairs(data) do
        if v ~= 0 then
            local x = k % w
            local y = h - math.floor(k/w)
            local b

            local ts = tilesets[indexToTileSet[v]]
            local ts_index = v - ts.firstgid + 1

            b = Factory:createBox(x, y, indexToTileSet[v], ts_index, ts.tiles[ts_index] and ts.tiles[ts_index].image or nil)

            --if b then
                table.insert(self.futureBoxes, b)
            --end
        end
    end
end