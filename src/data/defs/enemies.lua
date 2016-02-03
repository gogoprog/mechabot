return {
    copter = {
        texture = "helicopter",
        extent = vector2(256, 128),
        shootDirection = vector2(-1, -0.3),
        weapon = { "rocket", 1 },
        bulletSpeedFactor = 0.5
    },
    bossCopter = {
        texture = "helicopter",
        extent = vector2(512, 256),
        shootDirection = vector2(-1, -0.3),
        weapon = { "rocket", 4 },
        bulletSpeedFactor = 1,
        speed = 500,
        life = 200
    }
}
