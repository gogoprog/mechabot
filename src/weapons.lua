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
        sound = function(level)
            return "shoot"
        end,
        bulletRadius = 20,
        color = vector4(0.2, 1.0, 0.2, 1)
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
        sound = function(level)
            return "shoot"
        end,
        bulletRadius = 20,
        particle = {
            texture = gengine.graphics.texture.get("particle"),
            size = 32,
            emitterRate = 20,
            emitterLifeTime = 0.1,
            extentRange = {vector2(16,16), vector2(16,16)},
            lifeTimeRange = {0.4, 0.7},
            directionRange = {0, 2*3.14},
            speedRange = {50, 300},
            rotationRange = {-3, 3},
            spinRange = {-10, 10},
            linearAccelerationRange = {vector2(1000,-1000), vector2(1000,-1000)},
            scales = {vector2(1, 1)},
            colors = {vector4(0.6,0.0,0.0,1), vector4(0.6,0,0,0.5)},
            layer = 20
        }
    }
}
