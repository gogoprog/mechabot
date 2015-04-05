ComponentRemover = {}

function ComponentRemover:init()
end

function ComponentRemover:insert()
    self.timeLeft = 1
end

function ComponentRemover:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        self.entity:remove()
    end
end

function ComponentRemover:remove()
end
