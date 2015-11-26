require 'game'

function init()
    gengine.application.setName("Mechabot")
    gengine.application.setExtent(960, 540)
    --gengine.application.setUpdateFactor(20)
    --gengine.application.setFullscreen(true)
end

function start()
    gengine.graphics.setClearColor(0.0,0.0,0.1,1)
    Game:init()

    gengine.gui.loadFile("gui/main.html")
end

function update(dt)
    Game:update(dt)

    -- debug keys

    local kb = gengine.input.keyboard

    if kb:isJustUp(26) then
        print("oui")
        Game:changeState("winning")
    end
end

function stop()
end
