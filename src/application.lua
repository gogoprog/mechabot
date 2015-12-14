require 'game'

Application = Application or {}

gengine.stateMachine(Application)

function Application.onStateEnter:menu()
end

function Application.onStateUpdate:menu(dt)
end

function Application.onStateExit:menu()
end

function Application.onStateEnter:shop()
    Game:changeState("shop")
    gengine.gui.executeScript("shop.updateMoney(" .. Session.money .. ")")
    self:fillShop()
end

function Application.onStateUpdate:shop(dt)
    if gengine.input.keyboard:isJustUp(41) then
        Game:changeState("idle")
        gengine.gui.executeScript("showPage(mainPages, 'menu', 300)")
    end
end

function Application.onStateExit:shop()
end

function Application.onStateEnter:inGame()
    Game:start(1)
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

function Application:fillShop()
    gengine.gui.executeScript("shop.clear()")

    self:addSomeItems("weapon", 3)
    self:addSomeItems("generator", 3)
    self:addSomeItems("shield", 3)

    gengine.gui.executeScript("shop.postFill()")
end

function Application:addSomeItems(type, count)
    for k, v in pairs(Game[type .. 's']) do
        for i=1,count do
            local item = Game:getItem(type, k, i)
            self:addShopItem(type, k, i, k, item.price)
        end
    end
end

function Application:addShopItem(type, name, level, title, price)
    gengine.gui.executeScript("shop.addItem('" .. type .. "', '" .. name .. "', " .. level .. ", '" .. title .. "', " .. price .. ")")
end
