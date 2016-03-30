ComponentBox = {}

function ComponentBox:init()
    self.life = self.life or 10
    self.extent = Vector2(32, 32) -- :todo:
end

function ComponentBox:insert()
end

function ComponentBox:update(dt)

end

function ComponentBox:remove()

end

function ComponentBox:hit(dmg, boxIndex)
    self.life = self.life - dmg

    self.entity.blink:blink()

    if self.life <= 0 then
        local e = Factory:createEffect("explosion")
        e:insert()
        e.position = Vector3(self.entity.position)

        Map:removeBox(boxIndex, self.entity)

        Map.cameraEntity.shaker:shake(0.1)

        Game:addScore(10)
    end
end
