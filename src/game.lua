require 'factory'
require 'session'
require 'map'

Game = Game or {
    enemies = {},
    bullets = {}
}

gengine.stateMachine(Game)

function Game:init()
    Factory:init()
    Session:init()

    self.weapons = dofile("data/defs/weapons.lua")
    self.generators = dofile("data/defs/generators.lua")
    self.shields = dofile("data/defs/shields.lua")

    self.player = Factory:createPlayer()
    self.arm = Factory:createArm()

    self:resetItems()

    Map:init()

    self:changeState("idle")

    local e = Factory:createRedLight()
    self.redLight = e
end

function Game:start(map)
    self:resetItems()

    for k,v in ipairs(self.enemies) do
        v:remove()
    end
    for k,v in ipairs(self.bullets) do
        v:remove()
    end

    self.bullets = {}
    self.enemies = {}

    self.score = 0
    self:addScore(0)
    Map:start(map)

    self.player.position:set(128, 2000)
    self.player:insert()
    self.arm:insert()
    self:changeState("inGameIntro")

    self.redLight.position.x = Map.length
    self.redLight:insert()
end

function Game:stop()
    self.running = false

    for k,v in ipairs(self.enemies) do
        v:remove()
    end
    for k,v in ipairs(self.bullets) do
        v:remove()
    end

    self.bullets = {}
    self.enemies = {}

    self.player:remove()
    self.arm:remove()
    Map:stop()
    gengine.gui.showPage('shop', 'fade', 400)
end

function Game:update(dt)
    self:updateState(dt)
end

function Game.onStateUpdate:idle(dt)
end

function Game.onStateEnter:inGameIntro()
    self.running = true
    self.player.player:changeState("falling")

    self.introDuration = 5
    self.timeLeft = self.introDuration
    local e = Factory:createRedLight()
    e.position:set(128, 0)
    e:insert()
    self.introRedLight = e

    self.player.sprite.timeFactor = 0
end

function Game.onStateUpdate:inGameIntro(dt)
    Map:update(dt)

    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        self:changeState("inGame")
    end

    if gengine.input.keyboard:isJustUp(41) then
        self:changeState("pausing")
    end
end

function Game.onStateExit:inGameIntro()
    self.player.sprite.timeFactor = 1
    self.player.sprite.alpha = 1
    self.arm.sprite.alpha = 1
    self.introRedLight:remove()
    gengine.entity.destroy(self.introRedLight)
end

function Game.onStateEnter:inGame()
    self.running = true
end

function Game.onStateUpdate:inGame(dt)
    Map:update(dt)

    if gengine.input.keyboard:isJustUp(41) then
        self:changeState("pausing")
    end

    if Game.player.position.x > Map.length then
        self:changeState("winning")
    end
end

function Game.onStateExit:inGame()
    self.running = false
end

function Game.onStateEnter:pausing()
    self.running = false
    Application:showConfirmDialog("Leave game?", "Game:stop()", "Game:changeState(\"inGame\")")
end

function Game.onStateUpdate:pausing(dt)
    if gengine.input.keyboard:isJustUp(41) then
        Application:closeConfirmDialog()
        self:changeState("inGame")
    end
end

function Game.onStateExit:pausing()
end

function Game.onStateEnter:dying()
    self.running = true
    self.arm:remove()
end

function Game.onStateUpdate:dying(dt)
    if gengine.input.keyboard:isJustUp(41) then
        self:stop()
    end
end

function Game.onStateExit:dying()
end

function Game.onStateEnter:winning()
    self.player.sprite.timeFactor = 100
    self.player.player:changeState('jumping')
    self.player.player.velocity.y = 5000
end

function Game.onStateUpdate:winning(dt)
    if self.player.position.y > 1400 then
        self:stop()
        self:changeState("none")
        Session:onLevelWon(self.score)
    end
end

function Game.onStateExit:winning()
    self.player.sprite.timeFactor = 1
    self.player.sprite.alpha = 1
    self.arm.sprite.alpha = 1
end

function Game.onStateEnter:shop()
    Map.cameraEntity.position:set(0, 0)
    self.player:insert()
    self.arm:insert()

    self.arm.arm.forcedShot = true
    self.arm.arm.currentAngle = 0
    self.arm.rotation = 0

    self.player.position.x = 250
    self.player.position.y = 0
    self.player.sprite.timeFactor = 0
end

function Game.onStateUpdate:shop(dt)

end

function Game.onStateExit:shop()
    self.arm.arm.forcedShot = false
    self.player.sprite.timeFactor = 1
end

function Game:addScore(v)
    self.score = self.score + v
    gengine.gui.executeScript("updateLevelScore(" .. self.score .. ");")
end

function Game:interState()

end

function Game:getWeapon(name, level)
    local def = self.weapons[name]
    return self:getComputedItem(def, level)
end

function Game:getGenerator(name, level)
    local def = self.generators[name]
    return self:getComputedItem(def, level)
end

function Game:getShield(name, level)
    local def = self.shields[name]
    return self:getComputedItem(def, level)
end

function Game:getItem(_type, name, level)
    local def = self[_type .. 's'][name]
    return self:getComputedItem(def, level)
end

function Game:getComputedItem(def, level)
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

function Game:resetItems()
    local player = self.player.player
    player:setWeapon(Session.weapon.name, Session.weapon.level)
    player:setGenerator(Session.generator.name, Session.generator.level)
    player:setShield(Session.shield.name, Session.shield.level)
end
