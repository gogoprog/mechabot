ComponentBullet = {}

local bulletRadius = 20

function ComponentBullet:init()
    self.damage = 50
end

function ComponentBullet:insert()
    table.insert(Game.bullets, self.entity)
    self.totalTime = 0

    self.entity.rotation = gengine.math.getPolarAngle(self.velocity)
end

function ComponentBullet:update(dt)
    if not (Game.running or Game.state == "shop") then
        return
    end

    local self_position = self.entity.position
    local velocity = self.velocity
    self.totalTime = self.totalTime + dt
    self_position.x = self_position.x + dt * velocity.x
    self_position.y = self_position.y + dt * velocity.y

    if not self.itIsEnemy then
        for k, v in ipairs(Map.boxes) do
            local p = v.position
            if gengine.math.doesCircleIntersectRectangle(self_position, self.radius, p, v.sprite.extent) then
                self:explode()
                v.box:hit(self.damage, k)
                return
            end
        end

        local enemies = Game.enemies
        for k = #enemies, 1, -1 do
            local p = enemies[k].position
            local offset = vector2(0, 32)
            if gengine.math.doesCircleIntersectRectangle(self_position, self.radius, p + offset, enemies[k].enemy.def.extent) then
                self:explode()
                enemies[k].enemy:hit(self.damage)
                return
            end
        end

        for k, v in ipairs(Game.bullets) do
            local p = v.position
            if v.bullet.itIsEnemy and gengine.math.doCirclesIntersect(self_position, self.radius, p, v.bullet.radius) then
                self:explode()
                v.bullet:explode()
                return
            end
        end
    else
        local player = Game.player
        if player.player.life > 0 then
            if gengine.math.doesCircleIntersectRectangle(self_position, self.radius, player.position, player.player.extent) then
                player.player:hit(self.damage)
                self:explode()
            end
        end
    end

    if self_position.y < self.radius / 2 then
        self:explode()
    end

    if self.totalTime > 5 then
        self:removeFromGame()
    end
end

function ComponentBullet:remove()
end

function ComponentBullet:removeFromGame()
    local e = self.entity
    local bullets = Game.bullets
    e:remove()
    for k = #bullets, 1, -1 do
        if bullets[k] == e then
            table.remove(bullets, k)
            return
        end
    end
end

function ComponentBullet:explode()
    self:removeFromGame()
    if self.weapon.debris then
        local e = Factory:createEffect("explosion")
        e:insert()
        e.position = self.entity.position
    end
    if self.weapon.explosionSound then
        gengine.audio.playSound(gengine.audio.sound.get(self.weapon.explosionSound), 0.6)
    end
end
