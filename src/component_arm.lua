ComponentArm = {}


local offset_x = - 50
local offset_y = 182
local bullet_offset_x = 90
local bullet_offset_y = -60


function ComponentArm:init()
    self.bulletSpeed = 1000
    self.bulletInterval = 0.1
    self.timeSinceLastBullet = 0

    self.shootSound = gengine.audio.sound.create("data/shoot.wav")
end

function ComponentArm:insert()
    self.entity.position.y = Game.player.position.y + offset_y
end

function ComponentArm:update(dt)
    local self_position = self.entity.position
    self_position.x = Game.player.position.x + offset_x

    local mouse_position = gengine.input.mouse:getPosition()
    local world_position = Map.cameraEntity.camera:getWorldPosition(mouse_position)

    local angle = gengine.math.getAngle(self_position, world_position)

    self.entity.rotation = angle

    self.timeSinceLastBullet = self.timeSinceLastBullet + dt

    if gengine.input.mouse:isDown(1) then
        if self.timeSinceLastBullet > self.bulletInterval then
            local direction = world_position - self_position

            direction = gengine.math.getNormalized(direction)

            local e = Factory:createBullet(direction * self.bulletSpeed)

            local bulletOffset = gengine.math.getRotated(vector2(0, bullet_offset_y), angle)

            e.position = self_position + direction * bullet_offset_x + bulletOffset
            e:insert()

            self.timeSinceLastBullet = 0

            self.entity.sprite:removeAnimations()
            self.entity.sprite:pushAnimation(Factory.armIdleAnimation)
            self.entity.sprite:pushAnimation(Factory.armFireAnimation)

            gengine.audio.playSound(self.shootSound, 0.6)
        end
    end
end

function ComponentArm:remove()
end

