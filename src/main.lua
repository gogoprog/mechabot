require 'game'

function init()
    gengine.application.setName("Mechabot")
    gengine.application.setExtent(800, 600)
end

local logoEntity

function start()
    gengine.graphics.setClearColor(0.1,0.1,0.1,1)
    Game:init()
    Game:start()
end

function update(dt)
    Game:update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
