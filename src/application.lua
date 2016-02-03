require 'game'
require 'gui'

Application = Application or {}

gengine.stateMachine(Application)

function Application.onStateEnter:menu()
end

function Application.onStateUpdate:menu(dt)
    if gengine.input.keyboard:isJustUp(41) then
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

    if kb:isJustUp(26) then
        Game:changeState("winning")
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

function Application:addShopItem(type, name, level)
    local item = Game:getItem(type, name, level)
    gengine.gui.executeScript("shop.addItem('" .. type .. "', '" .. name .. "', " .. level .. ", '" .. name .. "', " .. item.price .. ")")
end

function Application:showConfirmDialog(title, yes_code, no_code)
    gengine.gui.executeScript("showConfirmDialog('" .. title .. "', '" .. yes_code .. "', '" .. no_code .. "');")
end

function Application:closeConfirmDialog()
    gengine.gui.executeScript("closeConfirmDialog()")
end
