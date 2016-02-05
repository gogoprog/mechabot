return {
    smoke = {
        particle = {
            texture = gengine.graphics.texture.get("rocket_smoke"),
            emitterRate = 15,
            scales = {vector2(1, 1), vector2(10, 10)},
            colors = {vector4(0.8,0.8,0.9,1), vector4(0,0,0,0)},
            lifeTimeRange = {0.9, 0.9},
        }
    },
    blood = {
        particle = {
            texture = gengine.graphics.texture.get("particle"),
            size = 32,
            emitterRate = 20000,
            emitterLifeTime = 0.1,
            extentRange = {vector2(4,8)*2, vector2(8,16)*2},
            lifeTimeRange = {0.4, 0.7},
            directionRange = {0, 2*3.14},
            speedRange = {50, 300},
            rotationRange = {-3, 3},
            spinRange = {-10, 10},
            linearAccelerationRange = {vector2(1000,-1000), vector2(1000,-1000)},
            scales = {vector2(1, 1)},
            colors = {vector4(0.6,0.0,0.0,1), vector4(0.6,0,0,0.5)},
        }
    }
}
