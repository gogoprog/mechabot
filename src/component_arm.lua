ComponentArm = {}

function ComponentArm:init()
    self.bulletSpeed = 1000
    self.bulletInterval = 0.1
    self.timeSinceLastBullet = 0
end

function ComponentArm:insert()
    self.entity.position.y = Game.player.position.y + 160
end

function ComponentArm:update(dt)
    local self_position = self.entity.position
    self_position.x = Game.player.position.x - 32

    local x,y = gengine.input.mouse:getPosition()
    local wx, wy = Map.cameraEntity.camera:getWorldPosition(x,y)

    local angle = math.atan2(wy-self_position.y, wx-self_position.x)

    self.entity.rotation = angle

    self.timeSinceLastBullet = self.timeSinceLastBullet + dt

    if gengine.input.mouse:isDown(1) then
        if self.timeSinceLastBullet > self.bulletInterval then
            local v = vector2(wx-self_position.x, wy-self_position.y)
            local l = gengine.math.getDistance(self_position, vector2(wx, wy))
            v = v / l
            local e = Factory:createBullet(v * self.bulletSpeed)
            e.position.x = self_position.x + v.x * 128
            e.position.y = self_position.y + v.y * 128
            e:insert()

            self.timeSinceLastBullet = 0
        end
    end
end

function ComponentArm:remove()
end

