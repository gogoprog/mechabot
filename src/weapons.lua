return {
    plasma = {
        texture = function(level) return "particle" end,
        extent = function(level) return vector2(32,32) + vector2(level, level) * 5 end,
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
        sound = "laser",
        bulletRadius = 20,
        color = vector4(0.2, 1.0, 0.2, 1),
        debris = "particle",
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
            return 0.500
        end,
        powerCost = function(level)
            return 10
        end,
        bulletSpeed = function(level)
            return 1200
        end,
        sound = "rocket_firing",
        bulletRadius = 20,
        particle = {
            texture = gengine.graphics.texture.get("rocket_smoke"),
            emitterRate = 15,
            scales = {vector2(1, 1), vector2(10, 10)},
            colors = {vector4(0.8,0.8,0.9,1), vector4(0,0,0,0)},
            lifeTimeRange = {0.9, 0.9},
        },
        debris = "rocket",
        explosionSound = "explosion",
        price = function(level) return 100 * level end,
        directions = {
            vector2(1, 0)
        }
    }
}
