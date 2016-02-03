require 'component_parallax'
require 'component_box'
require 'component_arm'
require 'component_bullet'
require 'component_shaker'
require 'component_poolable'
require 'component_soldier'
require 'component_enemy'
require 'component_spawner'
require 'component_remover'
require 'component_blink'
require 'component_player'
require 'component_shooter'

Factory = Factory or {
    explosions = {},
    bloods = {},
    soldiers = {},
    bullets = {},
    particles = {},
    enemies = {}
}

function Factory:pickFromPool(t)
    local n = #t
    if n > 0 then
        local e = t[n]
        table.remove(t, n)
        return e
    end

    return nil
end

function Factory:init()
    local atlas

    self.definitions = {
        enemies = dofile("data/defs/enemies.lua")
    }

    gengine.graphics.texture.createFromDirectory("data/")
    gengine.audio.sound.createFromDirectory("data/")
    gengine.graphics.spriter.createFromDirectory("data/")

    atlas = gengine.graphics.atlas.create(
        "enemyMove",
        gengine.graphics.texture.get("enemy_move"),
        10,
        1
        )

    self.enemyMoveAnimation = gengine.graphics.animation.create(
        "enemyMove",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 },
            framerate = 16,
            loop = true
        }
        )

    self.explosionSound = gengine.audio.sound.get("explosion")
    self.hitSound = gengine.audio.sound.get("hit")
end

function Factory:createCamera()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentCamera(),
        {
            extent = vector2(1920, 1080)
        },
        "camera"
        )

    e:addComponent(
        ComponentShaker(),
        {
        },
        "shaker"
        )

    return e
end

function Factory:createParallax(y, speed, texture)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get(texture),
            layer = (speed == 0) and -100000000 or ( -1000 / speed)
        },
        "sprite"
        )


    e:addComponent(
        ComponentParallax(),
        {
            speed = speed
        }
        )

    e.position.y = y

    return e
end

function Factory:createPlayer()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSpriter(),
        {
            animation = gengine.graphics.spriter.get("mecha-walk"),
            layer = 4
        },
        "sprite"
        )

    e:addComponent(
        ComponentBlink(),
        {
        },
        "blink"
        )

    e:addComponent(
        ComponentPlayer(),
        {
        },
        "player"
        )

    return e
end

function Factory:createArm()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSpriter(),
        {
            animation = gengine.graphics.spriter.get("arm-fireing"),
            layer = 5
        },
        "sprite"
        )

    e:addComponent(
        ComponentArm(),
        {
        },
        "arm"
        )

    e:addComponent(
        ComponentBlink(),
        {
        },
        "blink"
        )

    return e
end

function Factory:createBullet(velocity, weapon, is_enemy)
    local e = self:pickFromPool(self.bullets)
    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentSprite(),
            {
                layer = 2
            },
            "sprite"
            )

        e:addComponent(
            ComponentBullet(),
            {
                itIsEnemy = is_enemy
            },
            "bullet"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.bullets
            }
            )

        e:addComponent(
            ComponentParticleSystem(),
            {
                size = 128,
                emitterRate = 20,
                emitterLifeTime = 1024,
                extentRange = {vector2(8,8), vector2(16,16)},
                directionRange = {0, 2*3.14},
                speedRange = {0, 0},
                rotationRange = {-3, 3},
                spinRange = {-10, 10},
                linearAccelerationRange = {vector2(0, 0), vector2(0, 0)},
                layer = 100,
                keepLocal = false
            },
            "particles"
            )
    end

    if weapon.particle then
        for k, v in pairs(weapon.particle) do
            e.particles[k] = v
        end
    else
        e.particles.emitterRate = 0
    end

    e.bullet.velocity = velocity
    e.bullet.damage = weapon.damage
    e.bullet.radius = weapon.bulletRadius
    e.bullet.itIsEnemy = is_enemy
    e.bullet.weapon = weapon

    e.sprite.texture = gengine.graphics.texture.get(weapon.texture)
    e.sprite.extent = weapon.extent
    e.sprite.color = weapon.color or vector4(1,1,1,1)

    e.particles:reset()

    return e
end

function Factory:createExplosion(texture)
    local e = self:pickFromPool(self.explosions)
    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentParticleSystem(),
            {
                size = 32,
                emitterRate = 20000,
                emitterLifeTime = 0.1,
                extentRange = {vector2(8,8), vector2(16,16)},
                lifeTimeRange = {0.4, 0.7},
                directionRange = {0, 2*3.14},
                speedRange = {50, 300},
                rotationRange = {-3, 3},
                spinRange = {-10, 10},
                linearAccelerationRange = {vector2(-10,-1000), vector2(10,-1100)},
                scales = {vector2(1, 1)},
                colors = {vector4(0.8,0.8,0.9,1), vector4(0,0,0,0)},
                layer = 100
            },
            "particles"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.explosions
            }
            )

        e:addComponent(
            ComponentRemover(),
            {
            }
            )
    end

    e.particles.texture = gengine.graphics.texture.get(texture or "box")
    e.particles:reset()

    return e
end

function Factory:createBlood()
    local e = self:pickFromPool(self.bloods)
    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentParticleSystem(),
            {
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
                layer = 20
            },
            "particles"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.bloods
            }
            )

        e:addComponent(
            ComponentRemover(),
            {
            }
            )
    end

    e.particles:reset()

    return e
end

function Factory:createSoldier()
    local e = self:pickFromPool(self.soldiers)
    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentSpriter(),
            {
                animation = gengine.graphics.spriter.get("soldier-walk"),
                layer = 10
            },
            "sprite"
            )

        e:addComponent(
            ComponentSoldier(),
            {
            },
            "enemy"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.soldiers
            }
            )
    end

    return e
end

function Factory:createRedLight()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSpriter(),
        {
            animation = gengine.graphics.spriter.get("entity_000-iddle"),
            layer = 10
        },
        "sprite"
        )

    e.sprite:pushAnimation(gengine.graphics.spriter.get("entity_000-start"))

    return e
end


function Factory.createEnemy(object, properties)
    local e = Factory:pickFromPool(Factory.enemies)
    local def = Factory.definitions.enemies[properties.type]

    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentSprite(),
            {
            },
            "sprite"
            )

        e:addComponent(
            ComponentEnemy(),
            {
            },
            "enemy"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = Factory.enemies
            }
            )

        e:addComponent(
            ComponentShooter(),
            {
            },
            "shooter"
            )

        e:addComponent(
            ComponentBlink(),
            {
            },
            "blink"
            )
    end

    e.sprite.texture = gengine.graphics.texture.get(def.texture)
    e.sprite.layer = 10
    e.sprite.extent = def.extent
    e.sprite.color = def.color or vector4(1,1,1,1)

    e.enemy.positions = object.polyline
    e.enemy.def = def

    e.shooter.weaponName = def.weapon[1]
    e.shooter.weaponLevel = def.weapon[2]
    e.shooter.direction = def.shootDirection

    e.position:set(object.x, object.y)

    table.insert(Map.futureEnemies, e)

    return e
end
