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
    self.entity:setParent(Game.player)
end

function ComponentArm:update(dt)
    local self_position = self.entity.position

    local bonePosition = Game.player.sprite:GetBonePosition(2)
    self_position.x = bonePosition.x
    self_position.y = bonePosition.y

    local mousePosition = gengine.input.getMousePosition() / Vector2(1280, 800)
    local worldPosition = Map.cameraEntity.camera:ScreenToWorldPoint(Vector3(mousePosition.x,mousePosition.y,0))

 --[[
    local delta = world_position - self_position
    local angle = Atan2(delta.x, delta.y)

    local length = gengine.math.getDistance(world_position, self_position)

    if not Game.running then
        angle = 0
        length = 0
    end

    if length > 95 then
        local angle2 = math.acos(95 / length)
        local angle3 = angle2 - angle
        local final_angle = 3.1415/2 - angle3

        self.entity.rotation = final_angle
        self.currentAngle = final_angle
    end

    self.timeSinceLastBullet = self.timeSinceLastBullet + dt

    if (Game.running and gengine.input.mouse:isDown(1)) or self.forcedShot then
        self.entity.sprite.timeFactor = 1

        if self.timeSinceLastBullet > self.weapon.interval then
            if Game.player.player.generator.currentValue >= self.weapon.powerCost then
                local bulletOffset = gengine.math.getRotated(Vector2(0, bullet_offset_y), angle)
                local armDirection = gengine.math.getRotated(Vector2(1,0), self.currentAngle)
                local firePosition = self_position + armDirection * bullet_offset_x + bulletOffset

                if self.weapon.yOffsetRange then
                    firePosition.y = firePosition.y + (math.random() - 0.5) * self.weapon.yOffsetRange
                end

                for k, v in ipairs(self.weapon.directions) do
                    local direction = gengine.math.getRotated(v, self.currentAngle)
                    direction = gengine.math.getNormalized(direction)
                    local e = Factory:createBullet(direction * self.weapon.bulletSpeed, self.weapon)

                    e.position = Vector3(firePosition.x, firePosition.y)
                    e:insert()
                end

                self.timeSinceLastBullet = 0

                local e = Factory:createEffect(self.weapon.effects.fire, self.forcedShot)
                e.position = firePosition
                e:insert()

                Game.player.player.generator.currentValue = Game.player.player.generator.currentValue - self.weapon.powerCost
            end
        end
    else
        self.entity.sprite.timeFactor = 0
    end

    ]]
end

function ComponentArm:remove()
end
