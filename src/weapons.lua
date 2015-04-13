return {
    plasma = {
        texture = function(level) return "particle" end,
        extent = function(level) return vector2(32,32) end,
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
            return 600
        end
    }
}