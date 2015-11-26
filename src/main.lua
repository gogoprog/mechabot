require 'application'

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
    Application:updateState(dt)
end

function stop()
end
