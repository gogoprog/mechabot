return {
    plasma = {
        texture = function(level) return "plasma" end,
        extent = function(level) return Vector2(63,44) + Vector2(level, level) * 5 end,
        damage = function(level)
            return 10 * level
        end,
        interval = function(level)
            return 0.3 - level/100
        end,
        powerCost = function(level)
            return 10 + level * 0.5
        end,
        bulletSpeed = function(level)
            return 1200
        end,
        effects = {
            fire = "plasma_fire",
            hit = "explosion"
        },
        bulletRadius = 20,
        price = function(level) return 100 * level end,
        directions = function(level)
            if level < 3 then
                return { Vector2(1, 0) }
            elseif level < 5 then
                return {
                    Vector2(1, 0.05),
                    Vector2(1, 0),
                    Vector2(1, -0.05)
                }
            end

            return {
                Vector2(1, 0.1),
                Vector2(1, 0.05),
                Vector2(1, 0),
                Vector2(1, -0.05),
                Vector2(1, -0.1)
            }
        end
    },
    machinegun = {
        texture = function(level) return "machinegun" end,
        extent = function(level) return Vector2(46,20) + Vector2(level, level) * 5 end,
        damage = function(level)
            return 2 * level
        end,
        interval = function(level)
            return 0.1 - level/100
        end,
        powerCost = function(level)
            return 10 + level * 0.5
        end,
        bulletSpeed = function(level)
            return 1200
        end,
        effects = {
            fire = "plasma_fire",
            hit = "explosion"
        },
        bulletRadius = 20,
        price = function(level) return 100 * level end,
        directions = {
            Vector2(1, 0)
        }
    },
    laser = {
        texture = function(level) return "laser" end,
        extent = function(level) return Vector2(86,32) + Vector2(level, level) * 5 end,
        damage = function(level)
            return 10 * level
        end,
        interval = function(level)
            return 0.3 - level/100
        end,
        powerCost = function(level)
            return 10 + level * 0.5
        end,
        bulletSpeed = function(level)
            return 1500
        end,
        effects = {
            fire = "laser_fire",
            hit = "explosion"
        },
        bulletRadius = 20,
        color = Color(1, 0.9, 0.9, 0.9),
        price = function(level) return 100 * level end,
        directions = function(level)
            if level < 3 then
                return { Vector2(1, 0) }
            elseif level < 5 then
                return {
                    Vector2(1, 0.05),
                    Vector2(1, 0),
                    Vector2(1, -0.05)
                }
            end

            return {
                Vector2(1, 0.1),
                Vector2(1, 0.05),
                Vector2(1, 0),
                Vector2(1, -0.05),
                Vector2(1, -0.1)
            }
        end
    },
    rocket = {
        texture = function(level) return "rocket" end,
        extent = function(level) return Vector2(64,64) end,
        damage = function(level)
            return 10 * level
        end,
        interval = function(level)
            return 0.500 - level/100
        end,
        powerCost = function(level)
            return 10
        end,
        bulletSpeed = function(level)
            return 1200
        end,
        bulletRadius = 20,
        effects = {
            bullet = "smoke",
            fire = "rocket",
            hit = "explosion"
        },
        price = function(level) return 100 * level end,
        directions = {
            Vector2(1, 0)
        }
    },
    vulcan = {
        texture = function(level) return "vulcan" end,
        extent = function(level) return Vector2(64,16) end,
        damage = function(level)
            return 10 + level
        end,
        interval = function(level)
            return 0.2 - level/100
        end,
        powerCost = function(level)
            return 10 + level * 0.5
        end,
        bulletSpeed = function(level)
            return 1200
        end,
        effects = {
            fire = "plasma_fire",
            hit = "explosion"
        },
        bulletRadius = 20,
        color = Color(1, 1, 1, 1),
        price = function(level) return 100 * level end,
        directions = {
            Vector2(1, 0)
        },
        yOffsetRange = 50
    }
}
