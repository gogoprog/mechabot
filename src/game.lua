require 'factory'
require 'map'

Game = Game or {}

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
    Map:start()
end

function Game:update(dt)
    Map:update(dt)
end
