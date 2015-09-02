ComponentShooter = {}

function ComponentShooter:init()
    self.interval = self.interval or 1
    self.timeLeft = self.interval
    self.weapon = Game:getWeapon("rocket", 1)
end

function ComponentShooter:insert()
end

function ComponentShooter:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft <= 0 then
        local position = self.entity.position
        local e = Factory:createBullet(vector2(-200,0), self.weapon, true)
        e.position:set(position)
        e:insert()
        self.timeLeft = self.interval
    end
end

function ComponentShooter:remove()
end
