return {
    smoke = {
        particle = {
            texture = gengine.graphics.texture.get("rocket_smoke"),
            emitterRate = 55,
            scales = {vector2(1, 1), vector2(10, 10)},
            colors = {vector4(0.8,0.8,0.9,1), vector4(0,0,0,0)},
            lifeTimeRange = {0.9, 0.9},
            spinRange = {-5, 5},
        }
    },
    blood = {
        sound = gengine.audio.sound.get("hit"),
        particle = {
            texture = gengine.graphics.texture.get("particle"),
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
    },
    explosion = {
        sound = gengine.audio.sound.get("explosion"),
        particle = {
            texture = gengine.graphics.texture.get("explosion"),
            emitterRate = 20000,
            emitterLifeTime = 0.1,
            extentRange = {vector2(8,8), vector2(16,16)},
            lifeTimeRange = {0.4, 0.7},
            directionRange = {0, 1*3.14},
            speedRange = {50, 150},
            rotationRange = {-1, -1},
            spinRange = {-1, -1},
            linearAccelerationRange = {vector2(-10,-100), vector2(10,-110)},
            scales = {vector2(3, 3)},
            colors = {vector4(0.8,0.8,0.9,1), vector4(0,0,0,0)},
        }
    },
    rocket_fire = {
        sound = gengine.audio.sound.get("rocket_firing")
    },
    plasma_fire = {
        sound = gengine.audio.sound.get("plasma")
    },
    laser_fire = {
        sound = gengine.audio.sound.get("laser")
    },
    laser_trail = {
        particle = {
            texture = gengine.graphics.texture.get("laser"),
            emitterRate = 200,
            emitterLifeTime = 5,
            extentRange = {vector2(30,10), vector2(30,10)},
            lifeTimeRange = {0.1, 0.2},
            directionRange = {0, 0},
            speedRange = {1000, 1000},
            rotationRange = {0, 0},
            spinRange = {0, 0},
            linearAccelerationRange = {vector2(0,0), vector2(0,0)},
            scales = {vector2(0.1, 1), vector2(1, 1)},
            colors = {vector4(1,0,0,1), vector4(1,0,0,0)},
            keepLocal = true
        }
    },
    largeSmoke = {
        particle = {
            texture = gengine.graphics.texture.get("smoke"),
            emitterRate = 20000,
            emitterLifeTime = 0.2,
            extentRange = {vector2(32,32), vector2(64, 64)},
            lifeTimeRange = {0.4, 0.7},
            directionRange = {0, 2*3.14},
            speedRange = {50, 300},
            rotationRange = {-3, 3},
            spinRange = {-10, 10},
            linearAccelerationRange = {vector2(0, -10), vector2(0,100)},
            scales = {vector2(1, 1), vector2(2, 2)},
            colors = {vector4(0.8,0.8,0.9,1), vector4(1,1,1,0)},
        }
    }
}
