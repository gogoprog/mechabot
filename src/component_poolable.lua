ComponentPoolable = {}

function ComponentPoolable:init()
end

function ComponentPoolable:insert()
    self.timeLeft = 1
end

function ComponentPoolable:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        self.entity:remove()
    end
end

function ComponentPoolable:remove()
    table.insert(self.pool, self.entity)
end
