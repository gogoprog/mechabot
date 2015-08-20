require 'component_parallax'
require 'component_box'
require 'component_arm'
require 'component_bullet'
require 'component_shaker'
require 'component_poolable'
require 'component_enemy'
require 'component_spawner'
require 'component_remover'
require 'component_blink'
require 'component_player'

Factory = Factory or {
    boxExplosions = {},
    bloods = {},
    enemies = {},
    bullets = {}
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

    gengine.graphics.atlas.create(
        "crates",
        gengine.graphics.texture.get("crates"),
        5,
        2
        )

    atlas = gengine.graphics.atlas.create(
        "mechaMove",
        gengine.graphics.texture.get("mecha_move"),
        14,
        1
        )

    self.mechaMoveAnimation = gengine.graphics.animation.create(
        "mechaMove",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 },
            framerate = 16,
            loop = true
        }
        )

    atlas = gengine.graphics.atlas.create(
        "armFire",
        gengine.graphics.texture.get("arm"),
        4,
        1
        )

    self.armFireAnimation = gengine.graphics.animation.create(
        "armFire",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3 },
            framerate = 16,
            loop = false
        }
        )

    self.armIdleAnimation = gengine.graphics.animation.create(
        "armFire",
        {
            atlas = atlas,
            frames = { 2 },
            framerate = 1,
            loop = true
        }
        )

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

    self.explosionSound = gengine.audio.sound.create("data/explosion.wav")
    self.hitSound = gengine.audio.sound.create("data/hit.wav")
end

function Factory:createCamera()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentCamera(),
        {
            extent = vector2(960, 540)
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
            layer = - 1000 / speed
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
        ComponentAnimatedSprite(),
        {
            animation = self.mechaMoveAnimation,
            extent = vector2(200, 300),
            layer = 0
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
        ComponentAnimatedSprite(),
        {
            animation = self.armIdleAnimation,
            extent = vector2(256, 200),
            layer = 1
        },
        "sprite"
        )

    e:addComponent(
        ComponentArm(),
        {
        },
        "arm"
        )

    return e
end

function Factory:createBullet(velocity, weapon)
    local e = self:pickFromPool(self.bullets)
    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentSprite(),
            {
                color = vector4(0.2, 1.0, 0.2, 1),
                layer = 2
            },
            "sprite"
            )

        e:addComponent(
            ComponentBullet(),
            {
            },
            "bullet"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.bullets
            }
            )
    end

    e.bullet.velocity = velocity
    e.bullet.damage = weapon.damage

    e.sprite.texture = gengine.graphics.texture.get(weapon.texture)
    e.sprite.extent = weapon.extent

    return e
end

function Factory:createBoxExplosion(box_definition)
    local e = self:pickFromPool(self.boxExplosions)
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
                linearAccelerationRange = {vector2(0,-1000), vector2(0,-1000)},
                scales = {vector2(1, 1)},
                colors = {vector4(0.8,0.8,0.9,1), vector4(0,0,0,0)}
            },
            "particles"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.boxExplosions
            }
            )

        e:addComponent(
            ComponentRemover(),
            {
            }
            )
    end

    e.particles.texture = gengine.graphics.texture.get("box")

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
                extentRange = {vector2(8,8), vector2(8,16)},
                lifeTimeRange = {0.4, 0.7},
                directionRange = {0, 2*3.14},
                speedRange = {50, 300},
                rotationRange = {-3, 3},
                spinRange = {-10, 10},
                linearAccelerationRange = {vector2(1000,-1000), vector2(1000,-1000)},
                scales = {vector2(1, 1)},
                colors = {vector4(0.6,0.0,0.0,1), vector4(0.6,0,0,0.5)}
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

function Factory:createEnemy()
    local e = self:pickFromPool(self.enemies)
    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentAnimatedSprite(),
            {
                animation = self.enemyMoveAnimation,
                extent = vector2(32, 32),
                layer = 1
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
                pool = self.enemies
            }
            )
    end

    return e
end
