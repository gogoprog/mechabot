ComponentBox = {}

function ComponentBox:init()
    self.life = self.life or 10
end

function ComponentBox:insert()
end

function ComponentBox:update(dt)

end

function ComponentBox:remove()

end

function ComponentBox:setPosition(i, j)
    self.entity.position:set(i * 32 + self.definition.extent.x / 2 - 16, j * 32 + self.definition.extent.y / 2 - 16 - 16)
end

function ComponentBox:hit(dmg, boxIndex)
    self.life = self.life - dmg

    self.entity.blink:blink()

    if self.life <= 0 then
        local e = Factory:createBoxExplosion(self.definition)

        e:insert()
        e.particles:reset()

        e.position = self.entity.position

        Map:removeBox(boxIndex, self.entity)

        Map.cameraEntity.shaker:shake(0.1)
        gengine.audio.playSound(Factory.explosionSound, 0.6)
    end
end
