ComponentShooter = {}

function ComponentShooter:init()
end

function ComponentShooter:insert()
    self.interval = self.interval or 1
    self.timeLeft = self.interval
    self.weapon = Game:getWeapon(self.weaponName or "rocket", self.weaponLevel or 1)
    self.direction = self.direction or Vector2(-1, 0)
    self.direction = gengine.math.getNormalized(self.direction)
    self.bulletSpeedFactor = self.bulletSpeedFactor or 1
end

function ComponentShooter:update(dt)
    if not Game.running then
        return
    end

    self.timeLeft = self.timeLeft - dt

    if self.timeLeft <= 0 then
        local position = self.entity.position
        local e = Factory:createBullet(self.direction * self.weapon.bulletSpeed * self.bulletSpeedFactor, self.weapon, true)
        e.position:set(position)
        e:insert()
        self.timeLeft = self.interval
        if self.weapon.sound then
            gengine.audio.playSound(gengine.audio.sound.get(self.weapon.sound), 0.3)
        end
    end
end

function ComponentShooter:remove()
end
