return {
    plasma = {
        texture = function(level) return "particle" end,
        extent = function(level) return vector2(64,64) end,
        damage = function(level)
            return 10 * level
        end,
        interval = function(level)
            return 0.1
        end,
        powerCost = function(level)
            return 10
        end,
        bulletSpeed = function(level)
            return 1200
        end,
        sound = "laser",
        bulletRadius = 20,
        color = vector4(0.2, 1.0, 0.2, 1),
        debris = "particle"
    },
    rocket = {
        texture = function(level) return "rocket" end,
        extent = function(level) return vector2(64,64) end,
        damage = function(level)
            return 10 * level
        end,
        interval = function(level)
            return 0.1
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
            emitterRate = 5,
            scales = {vector2(1, 1), vector2(10, 10)},
            colors = {vector4(0.8,0.8,0.9,1), vector4(0,0,0,0)},
            lifeTimeRange = {0.9, 0.9},
        },
        debris = "rocket",
        explosionSound = "explosion"
    }
}
