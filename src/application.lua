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
