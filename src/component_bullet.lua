ComponentBullet = {}

local bulletRadius = 10
local boxExtent = {x=32, y=32}
local enemyExtent = {x=32, y=32}

function ComponentBullet:init()
    self.damage = 50
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
        if gengine.math.doesCircleIntersectRectangle(self_position, bulletRadius, p, v.sprite.extent) then
            self.entity:remove()
            v.box:hit(self.damage, k)
            return
        end
    end

    local e = self.entity
    local enemies = Game.enemies
    for k = #enemies, 1, -1 do
        local p = enemies[k].position
        if gengine.math.doesCircleIntersectRectangle(self_position, bulletRadius, p, boxExtent) then

            self.entity:remove()

            local e = Factory:createBlood()
            e:insert()
            e.position:set(enemies[k].position)

            Game:addKills(1)

            enemies[k]:remove()
            return
        end
    end
end

function ComponentBullet:remove()
end
