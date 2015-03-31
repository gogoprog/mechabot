ComponentBullet = {}

local bulletRadius = 10
local boxExtent = {x=32, y=32}
local enemyExtent = {x=32, y=32}

function ComponentBullet:init()
end

function ComponentBullet:insert()
end

function ComponentBullet:update(dt)
    local self_position = self.entity.position
    local velocity = self.velocity

    self_position.x = self_position.x + dt * velocity.x
    self_position.y = self_position.y + dt * velocity.y

    for k, v in ipairs(Map.boxes) do
        local p = v.position
        if gengine.math.doesCircleIntersectRectangle(self_position, bulletRadius, p, boxExtent) then
            self.entity:remove()
            gengine.entity.destroy(self.entity)

            local e = Factory:createBoxExplosion()

            e:insert()
            e.particles:reset()

            e.position = v.position

            Map:removeBox(k, v)
            return
        end
    end

    for k, v in ipairs(Game.enemies) do
        local p = v.position
        if gengine.math.doesCircleIntersectRectangle(self_position, bulletRadius, p, boxExtent) then

            self.entity:remove()
            gengine.entity.destroy(self.entity)

            local e = Factory:createBlood()

            e:insert()
            e.particles:reset()

            e.position = v.position

            v:remove()
            return
        end
    end
end

function ComponentBullet:remove()
end

