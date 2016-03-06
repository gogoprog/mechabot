ComponentShaker = {}

function ComponentShaker:init()
    self.timeLeft = 0
end

function ComponentShaker:insert()
    local p = self.entity.position
    self.basePosition = vector2(p.x, p.y)

    self.offset = vector2(0, 0)
end

function ComponentShaker:update(dt)
    if self.timeLeft > 0 then
        self.timeLeft = self.timeLeft - dt

        self.time = self.time + dt

        if self.time > 0.02 then
            local p = self.entity.position
            local d = vector2(math.random(-self.intensity, self.intensity), math.random(-self.intensity, self.intensity))
            self.offset = self.offset + d
            p.x = p.x + d.x
            p.y = p.y + d.y
            self.time = 0
        end

        if self.timeLeft <= 0 then
            local p = self.entity.position
            p.x = p.x - self.offset.x
            p.y = p.y - self.offset.y
            self.offset = vector2(0, 0)
        end
    end
end

function ComponentShaker:remove()
end

function ComponentShaker:shake(duration, intensity)
    self.timeLeft = duration
    self.time = 0
    self.intensity = intensity or 3
end
