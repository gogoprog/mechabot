ComponentArm = {}

local offset_x = -20
local offset_y = 440
local bullet_offset_x = 180
local bullet_offset_y = -130

function ComponentArm:init()
    self.timeSinceLastBullet = 0
    self.currentAngle = 0
end

function ComponentArm:insert()
    self.entity.position.y = Game.player.position.y + offset_y
end

function ComponentArm:update(dt)
    local self_position = self.entity.position
    self_position.x = Game.player.position.x + offset_x
    self_position.y = Game.player.position.y + offset_y

    local mouse_position = gengine.input.mouse:getPosition()
    local world_position = Map.cameraEntity.camera:getWorldPosition(mouse_position)

    local angle = gengine.math.getAngle(self_position, world_position)

    local length = gengine.math.getDistance(world_position, self_position)

    if length > 95 then
        local angle2 = math.acos(95 / length)
        local angle3 = angle2 - angle
        local final_angle = 3.1415/2 - angle3

        self.entity.rotation = final_angle
        self.currentAngle = final_angle
    end

    self.timeSinceLastBullet = self.timeSinceLastBullet + dt

    if gengine.input.mouse:isDown(1) then
        self.entity.sprite.timeFactor = 1

        if self.timeSinceLastBullet > self.weapon.interval then
            if Game.player.player.generator.currentValue >= self.weapon.powerCost then
                local direction = gengine.math.getRotated(vector2(1,0), self.currentAngle)

                direction = gengine.math.getNormalized(direction)

                local e = Factory:createBullet(direction * self.weapon.bulletSpeed, self.weapon)

                local bulletOffset = gengine.math.getRotated(vector2(0, bullet_offset_y), angle)

                e.position = self_position + direction * bullet_offset_x + bulletOffset
                e:insert()

                self.timeSinceLastBullet = 0


                gengine.audio.playSound(self.bulletSound, 0.3)
                Game.player.player.generator.currentValue = Game.player.player.generator.currentValue - self.weapon.powerCost
            end
        end
    else
        self.entity.sprite.timeFactor = 0
    end
end

function ComponentArm:remove()
end
