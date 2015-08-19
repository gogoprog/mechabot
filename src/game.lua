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

function Game:start(map)
    self.player.player:initWeapon("plasma", 1)
    self.player.player:initGenerator("tank")
    self.kills = 0
    self:addKills(0)
    Map:start(map)
    self.player:insert()
    self.arm:insert()
    self.arm.arm.weapon = self.player.player.weapon
    self:changeState("inGame")
end

function Game:stop()
    for k,v in ipairs(self.enemies) do
        v:remove()
    end

    self.enemies = {}

    self.player:remove()
    self.arm:remove()
    Map:stop()
    self:changeState("idle")
    gengine.gui.executeScript("showPage('menu', 700)")
end

function Game:update(dt)
    self:updateState(dt)
end

function Game.onStateUpdate:idle(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function Game.onStateEnter:inGame()
    self.running = true
end

function Game.onStateUpdate:inGame(dt)
    Map:update(dt)

    if gengine.input.keyboard:isJustUp(41) then
        self:stop()
    end
end

function Game.onStateExit:inGame()
    self.running = false
end

function Game:addKills(v)
    self.kills = self.kills + v
    gengine.gui.executeScript("updateKills(" .. self.kills .. ");")
end

function Game:interState()

end
