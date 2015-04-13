require 'factory'
require 'map'

Game = Game or {
    enemies = {}
}

gengine.stateMachine(Game)

function Game:init()
    gengine.graphics.texture.createFromDirectory("data/")
    Factory:init()

    self.player = Factory:createPlayer()
    self.arm = Factory:createArm()

    Map:init()

    self:changeState("idle");
end

function Game:start()
    self.kills = 0
    self:addKills(0)
    Map:start()
    self.player:insert()
    self.arm:insert()
    gengine.gui.executeScript("switchToHud();")
    self:changeState("inGame");
end

function Game:update(dt)
    self:updateState(dt)
end

function Game.onStateUpdate:idle(dt)
    if gengine.input.mouse:isJustUp(1) then
        self:start();
    end
end

function Game.onStateUpdate:inGame(dt)
    Map:update(dt)
end

function Game:addKills(v)
    self.kills = self.kills + v
    gengine.gui.executeScript("updateKills(" .. self.kills .. ")")
end