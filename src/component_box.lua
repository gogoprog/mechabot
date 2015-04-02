ComponentBox = {}

function ComponentBox:init()
end

function ComponentBox:insert()
end

function ComponentBox:update(dt)

end

function ComponentBox:remove()
    Map.cameraEntity.shaker:shake(0.1)
    gengine.audio.playSound(Factory.explosionSound, 0.6)
end

function ComponentBox:setPosition(i, j)
    self.entity.position:set(i * 32, j * 32 - 16)
end
