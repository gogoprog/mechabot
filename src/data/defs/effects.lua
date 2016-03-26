return {
    smoke = {
        particle = {
            texture = cache:GetResource('Sprite2D', "rocket_smoke"),
            emitterRate = 55,
            scales = {Vector2(1, 1), Vector2(10, 10)},
            colors = {Color(0.8,0.8,0.9,1), Color(0,0,0,0)},
            lifeTimeRange = {0.9, 0.9},
            spinRange = {-5, 5},
        }
    },
    blood = {
        sound = gengine.audio.sound.get("hit"),
        particle = {
            texture = cache:GetResource('Sprite2D', "particle"),
            emitterRate = 20000,
            emitterLifeTime = 0.1,
            extentRange = {Vector2(4,8)*2, Vector2(8,16)*2},
            lifeTimeRange = {0.4, 0.7},
            directionRange = {0, 2*3.14},
            speedRange = {50, 300},
            rotationRange = {-3, 3},
            spinRange = {-10, 10},
            linearAccelerationRange = {Vector2(1000,-1000), Vector2(1000,-1000)},
            scales = {Vector2(1, 1)},
            colors = {Color(0.6,0.0,0.0,1), Color(0.6,0,0,0.5)},
        }
    },
    explosion = {
        sound = gengine.audio.sound.get("explosion"),
        particle = {
            texture = cache:GetResource('Sprite2D', "explosion"),
            emitterRate = 20000,
            emitterLifeTime = 0.1,
            extentRange = {Vector2(8,8), Vector2(16,16)},
            lifeTimeRange = {0.4, 0.7},
            directionRange = {0, 1*3.14},
            speedRange = {50, 150},
            rotationRange = {-1, -1},
            spinRange = {-1, -1},
            linearAccelerationRange = {Vector2(-10,-100), Vector2(10,-110)},
            scales = {Vector2(3, 3)},
            colors = {Color(0.8,0.8,0.9,1), Color(0,0,0,0)},
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
            texture = cache:GetResource('Sprite2D', "laser"),
            emitterRate = 200,
            emitterLifeTime = 5,
            extentRange = {Vector2(30,10), Vector2(30,10)},
            lifeTimeRange = {0.1, 0.2},
            directionRange = {0, 0},
            speedRange = {1000, 1000},
            rotationRange = {0, 0},
            spinRange = {0, 0},
            linearAccelerationRange = {Vector2(0,0), Vector2(0,0)},
            scales = {Vector2(0.1, 1), Vector2(1, 1)},
            colors = {Color(1,0,0,1), Color(1,0,0,0)},
            keepLocal = true
        }
    },
    largeSmoke = {
        particle = {
            texture = cache:GetResource('Sprite2D', "smoke"),
            emitterRate = 20000,
            emitterLifeTime = 0.2,
            extentRange = {Vector2(32,32), Vector2(64, 64)},
            lifeTimeRange = {0.4, 0.7},
            directionRange = {0, 2*3.14},
            speedRange = {50, 300},
            rotationRange = {-3, 3},
            spinRange = {-10, 10},
            linearAccelerationRange = {Vector2(0, -10), Vector2(0,100)},
            scales = {Vector2(1, 1), Vector2(2, 2)},
            colors = {Color(0.8,0.8,0.9,1), Color(1,1,1,0)},
        }
    }
}
