require 'factory'
require 'map'

Game = Game or {
    enemies = {},
    bullets = {}
}

gengine.stateMachine(Game)

function Game:init()
    Factory:init()

    self.weapons = dofile("weapons.lua")
    self.generators = dofile("generators.lua")
    self.shields = dofile("shields.lua")

    self.player = Factory:createPlayer()
    self.arm = Factory:createArm()

    Map:init()

    self:changeState("idle");
end

function Game:start(map)
    self.player.player:initWeapon("plasma", 1)
    self.player.player:initGenerator("small")
    self.player.player:initShield("small")
    self.kills = 0
    self:addKills(0)
    Map:start(map)
    self.player:insert()
    self.arm:insert()
    self.arm.arm.weapon = self.player.player.weapon
    self:changeState("inGameIntro")
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
    gengine.gui.executeScript("showPage(mainPages, 'menu', 300)")
end

function Game:update(dt)
    self:updateState(dt)
end

function Game.onStateUpdate:idle(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function Game.onStateEnter:inGameIntro()
    self.introDuration = 1
    self.timeLeft = self.introDuration
    local e = Factory:createRedLight()
    e.position = self.player.position
    e:insert()
    self.redLight = e

    self.player.sprite.timeFactor = 100
end

function Game.onStateUpdate:inGameIntro(dt)
    local alpha = 1 - (self.timeLeft / self.introDuration)
    self.player.sprite.alpha = alpha
    self.arm.sprite.alpha = alpha
    self.timeLeft = self.timeLeft - dt

    local y = 0 + (self.timeLeft / self.introDuration) * 500
    self.player.position.y = y

    Map:handleFutureBoxes()

    if self.timeLeft < 0 then
        self:changeState("inGame")
    end
end

function Game.onStateExit:inGameIntro()
    self.player.sprite.timeFactor = 1
    self.player.sprite.alpha = 1
    self.arm.sprite.alpha = 1
    self.redLight:remove()
    gengine.entity.destroy(self.redLight)
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

function Game:onGuiLoaded()
    for k, v in ipairs(Map.definitions) do
        gengine.gui.executeScript("addMap(" .. k .. ",'" .. v.title .. "');")
    end
end

function Game:getWeapon(name, level)
    local def = self.weapons[name]
    return self:getItem(def, level)
end

function Game:getGenerator(name, level)
    local def = self.generators[name]
    return self:getItem(def, level)
end

function Game:getShield(name, level)
    local def = self.shields[name]
    return self:getItem(def, level)
end

function Game:getItem(def, level)
    local w = {}
    for k, v in pairs(def) do
        if type(v) == "function" then
            w[k] = v(level)
        else
            w[k] = v
        end
    end

    return w
end
