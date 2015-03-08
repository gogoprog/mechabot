require 'factory'
require 'map'

Game = Game or {}

function Game:init()
    gengine.graphics.texture.createFromDirectory("data/")
    Map:init()
end

function Game:start()
    Map:start()
end

function Game:update(dt)
    Map:update(dt)
end
