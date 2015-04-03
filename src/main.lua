require 'game'

function init()
    gengine.application.setName("Mechabot")
    gengine.application.setExtent(800, 600)
    gengine.application.setFullscreen(false)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(0.0,0.0,0.1,1)
    Game:init()

    gengine.gui.loadFile("gui/menu.html")
end

function update(dt)
    Game:update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
