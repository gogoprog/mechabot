require 'factory'
require 'map'

Game = Game or {
    enemies = {}
}

function Game:init()
    gengine.graphics.texture.createFromDirectory("data/")
    Factory:init()

    self.player = Factory:createPlayer()
    self.player:insert()
    self.arm = Factory:createArm()
    self.arm:insert()

    Map:init()
end

function Game:start()
    for i = 1, 100 do
        local e = Factory:createEnemy()
        table.insert(self.enemies, e)

        e.position:set(math.random(500, 20000), 16)
        e:insert()
    end

    Map:start()
end

function Game:update(dt)
    Map:update(dt)
end
