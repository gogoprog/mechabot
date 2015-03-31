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
    gengine.audio.playSound(Factory.hitSound, 0.6)

    local e = self.entity
    for k, v in ipairs(Game.enemies) do
        if v == e then
            table.remove(Game.enemies, k)
            return
        end
    end
end
