require 'application'

function init()
    gengine.application.setName("Mechabot")
    gengine.application.setExtent(960, 540)
    --gengine.application.setUpdateFactor(3)
    --gengine.application.setFullscreen(true)
end

function start()
    gengine.graphics.setClearColor(Color(0.1,0.1,0.1,1))
    --Game:init()

    gengine.gui.loadFile("gui/ui.html")
end

function update(dt)
    Application:updateState(dt)

    local input = gengine.input

    if input.isKeyJustDown(58) then
        print(math.floor(1/dt) .. "fps | " .. gengine.entity.getCount())
    end
end

function stop()
end
