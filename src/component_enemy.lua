ComponentEnemy = {}

function ComponentEnemy:init()
end

function ComponentEnemy:insert()
end

function ComponentEnemy:update(dt)
    local p = self.entity.position

    p.x = p.x - 100 * dt
end

function ComponentEnemy:remove()
end
