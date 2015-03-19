ComponentBullet = {}

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
        if not(self_position.x + 8 < p.x - 16 or p.x + 16 < self_position.x - 8 or self_position.y + 8 < p.y - 16 or p.y + 16 < self_position.y - 8) then
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
end

function ComponentBullet:remove()
end

