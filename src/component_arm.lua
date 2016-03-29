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

    local mousePosition = gengine.input.getMousePosition() / Vector2(960, 540)
    local worldPosition = Map.cameraEntity.camera:ScreenToWorldPoint(Vector3(mousePosition.x,mousePosition.y,0))

    local delta = worldPosition - self_position
    local angle = Atan2(delta.y, delta.x)

    local length = (Vector3(worldPosition) - Vector3(self_position)):Length()

    if not Game.running then
        angle = 0
        length = 0
    end

    if length > 95 then
        local angle2 = Acos(95 / length)
        local final_angle = (angle - angle2) + 90

        self.entity.rotation = final_angle
        self.currentAngle = final_angle
    end

    self.timeSinceLastBullet = self.timeSinceLastBullet + dt

    if (Game.running and gengine.input.isMouseButtonDown(1)) or self.forcedShot then
        self.entity.sprite.timeFactor = 1

        if self.timeSinceLastBullet > self.weapon.interval then
            if Game.player.player.generator.currentValue >= self.weapon.powerCost then
                local bulletOffset = gengine.math.getRotated(Vector2(0, bullet_offset_y), angle/(180/3.1415))
                local armDirection = gengine.math.getRotated(Vector2(1,0), self.currentAngle/(180/3.1415))
                local firePosition = Game.player.position + self_position + armDirection * bullet_offset_x + bulletOffset

                if self.weapon.yOffsetRange then
                    firePosition.y = firePosition.y + (math.random() - 0.5) * self.weapon.yOffsetRange
                end

                for k, v in ipairs(self.weapon.directions) do
                    local direction = gengine.math.getRotated(v, self.currentAngle/(180/3.1415))
                    direction = direction:Normalized()
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
end

function ComponentArm:remove()
end
