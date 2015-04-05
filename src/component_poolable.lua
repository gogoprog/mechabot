ComponentPoolable = {}

function ComponentPoolable:init()
end

function ComponentPoolable:insert()
end

function ComponentPoolable:update(dt)
end

function ComponentPoolable:remove()
    table.insert(self.pool, self.entity)
end
