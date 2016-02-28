return {
    plasma = {
        texture = function(level) return "plasma" end,
        extent = function(level) return vector2(63,44) + vector2(level, level) * 5 end,
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
                return { vector2(1, 0) }
            elseif level < 5 then
                return {
                    vector2(1, 0.05),
                    vector2(1, 0),
                    vector2(1, -0.05)
                }
            end

            return {
                vector2(1, 0.1),
                vector2(1, 0.05),
                vector2(1, 0),
                vector2(1, -0.05),
                vector2(1, -0.1)
            }
        end
    },
    laser = {
        texture = function(level) return "laser" end,
        extent = function(level) return vector2(86,32) + vector2(level, level) * 5 end,
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
        color = vector4(1, 0.9, 0.9, 0.9),
        price = function(level) return 100 * level end,
        directions = function(level)
            if level < 3 then
                return { vector2(1, 0) }
            elseif level < 5 then
                return {
                    vector2(1, 0.05),
                    vector2(1, 0),
                    vector2(1, -0.05)
                }
            end

            return {
                vector2(1, 0.1),
                vector2(1, 0.05),
                vector2(1, 0),
                vector2(1, -0.05),
                vector2(1, -0.1)
            }
        end
    },
    rocket = {
        texture = function(level) return "rocket" end,
        extent = function(level) return vector2(64,64) end,
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
            vector2(1, 0)
        }
    },
    vulcan = {
        texture = function(level) return "vulcan" end,
        extent = function(level) return vector2(64,16) end,
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
        color = vector4(1, 1, 1, 1),
        price = function(level) return 100 * level end,
        directions = {
            vector2(1, 0)
        }
    }
}
