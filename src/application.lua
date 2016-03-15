require 'game'
require 'gui'

Application = Application or {}

gengine.stateMachine(Application)

function Application.onStateEnter:menu()
end

function Application.onStateUpdate:menu(dt)
    if gengine.input.isKeyJustDown(41) then
        gengine.application.quit()
    end
end

function Application.onStateExit:menu()
end

function Application.onStateEnter:shop()
    Game:changeState("shop")
    gengine.gui.executeScript("shop.updateMoney(" .. Session.money .. ")")
    gengine.gui.executeScript("shop.updateLevelName('" .. Session.currentLevel .. ". " .. Session.currentLevelDef.title .. "')")
end

function Application.onStateUpdate:shop(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.audio.playSound(gengine.audio.sound.get("back"), 0.5)
        gengine.gui.showPage('menu', 'slide', 300)
    end
end

function Application.onStateExit:shop()

end

function Application.onStateEnter:inGame()
    Game:start(Session.currentLevel)
end

function Application.onStateUpdate:inGame(dt)
    Game:update(dt)

    -- debug keys

    local kb = gengine.input.keyboard

    if kb:isJustUp(59) then
        Game:changeState("winning")
    end

    if kb:isDown(60) then
        Game.player.player.life = 100
        gengine.application.setUpdateFactor(5)
    else
        gengine.application.setUpdateFactor(1)
    end
end

function Application.onStateExit:inGame()
end

function Application:clearShop()
    gengine.gui.executeScript("shop.clear()")
end

function Application:shopPostFill()
    gengine.gui.executeScript("shop.postFill()")
end

local function round(val, decimal)
    return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
end

function Application:addShopItem(type, name, level)
    local item = Game:getItem(type, name, level)
    local infos = {"", "", ""}

    if type == 'weapon' then
        infos[1] = math.floor(item.damage / item.interval)
        infos[2] = math.floor(item.bulletSpeed / 100)
        infos[3] = math.floor(item.powerCost / item.interval)
    elseif type == 'generator' then
        infos[1] = math.floor(item.powerPerSecond)
        infos[2] = math.floor(item.capacity)
    elseif type == 'shield' then
        infos[1] = math.floor(item.capacity) .. " / " .. math.floor(item.absorption * 100) .. "%"
        infos[2] = round(item.regenerationPerSecond, 2)
        infos[3] = round(item.powerCostPerSecond, 2)
    end

    gengine.gui.executeScript(
        "shop.addItem('" .. type .. "', '" .. name .. "', " .. level .. ", '" .. name .. "', " .. item.price .. ", '" .. infos[1] .. "', '" .. infos[2] .. "', '" .. infos[3] .. "')"
        )
end

function Application:showConfirmDialog(title, yes_code, no_code)
    gengine.gui.executeScript("showConfirmDialog('" .. title .. "', '" .. yes_code .. "', '" .. no_code .. "');")
end

function Application:closeConfirmDialog()
    gengine.gui.executeScript("closeConfirmDialog()")
end
