ComponentArm = {}

function ComponentArm:init()
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
end

function ComponentArm:remove()
end

