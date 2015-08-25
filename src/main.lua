require 'game'

function init()
    gengine.application.setName("Mechabot")
    gengine.application.setExtent(960, 540)
    --gengine.application.setExtent(1920, 1080)
    gengine.application.setFullscreen(false)
end

function start()
    gengine.graphics.setClearColor(0.0,0.0,0.1,1)
    Game:init()

    gengine.gui.loadFile("gui/main.html")
end

function update(dt)
    Game:update(dt)
end

function stop()

end
