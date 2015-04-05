require 'component_parallax'
require 'component_box'
require 'component_arm'
require 'component_bullet'
require 'component_shaker'
require 'component_poolable'
require 'component_enemy'
require 'component_spawner'
require 'component_remover'

Factory = Factory or {
    boxExplosions = {},
    bloods = {},
    enemies = {},
    bullets = {}
}

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

    self.boxDefinitions = dofile("boxes.lua")
end

function Factory:createCamera()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentCamera(),
        {
            extent = vector2(800, 600)
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

function Factory:createParallax(h, y, speed, texture, uscale, vscale)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get(texture),
            extent = vector2(800, h),
            layer = - 1000 / speed,
            uvScale = vector2(uscale or 1, vscale or 1)
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

function Factory:createBox(i, j, tsId, id, defaultTexture)
    if self.boxDefinitions[tsId] then
        local def = self.boxDefinitions[tsId][id]

        if def then
            local e = gengine.entity.create()

            if def.textures then
                e:addComponent(
                    ComponentSprite(),
                    {
                        texture = gengine.graphics.texture.get(def.textures[1]),
                        layer = 0,
                    },
                    "sprite"
                    )
            elseif def.atlas then
                e:addComponent(
                    ComponentSprite(),
                    {
                        atlas = gengine.graphics.atlas.get(def.atlas),
                        atlasItem = def.atlasItems[1],
                        layer = 0,
                    },
                    "sprite"
                    )
            elseif defaultTexture then
                defaultTexture = string.gsub(defaultTexture, ".png", "")
                e:addComponent(
                    ComponentSprite(),
                    {
                        texture = gengine.graphics.texture.get(defaultTexture),
                        layer = 0,
                    },
                    "sprite"
                    )
            end

            if not def.extent then
                def.extent = e.sprite.extent
            end

            e:addComponent(
                ComponentBox(),
                {
                    definition = def
                },
                "box"
                )

            if def.spawner then
                e:addComponent(
                    ComponentSpawner(),
                    {
                    },
                    "spawner"
                    )
            end

            e.box:setPosition(i , j)

            return e
        end
    end
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

function Factory:createBullet(velocity)
    local n = #self.bullets
    if n > 0 then
        local e = self.bullets[n]

        e.bullet.velocity = velocity

        table.remove(self.bullets, n)
        return e
    end

    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("particle"),
            extent = vector2(32, 32),
            color = vector4(0.2, 1.0, 0.2, 1),
            layer = 2
        },
        "sprite"
        )

    e:addComponent(
        ComponentBullet(),
        {
            velocity = velocity,
            damage = 50
        },
        "bullet"
        )

    e:addComponent(
        ComponentPoolable(),
        {
            pool = self.bullets
        }
        )

    return e
end

function Factory:createBoxExplosion()
    local n = #self.boxExplosions
    if n > 0 then
        local e = self.boxExplosions[n]
        table.remove(self.boxExplosions, n)
        return e
    end

    local e = gengine.entity.create()

    e:addComponent(
        ComponentParticleSystem(),
        {
            texture = gengine.graphics.texture.get("box"),
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

    return e
end

function Factory:createBlood()
    local n = #self.bloods
    if n > 0 then
        local e = self.bloods[n]
        table.remove(self.bloods, n)
        return e
    end

    local e = gengine.entity.create()

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

    return e
end

function Factory:createEnemy()
    local n = #self.enemies
    if n > 0 then
        local e = self.enemies[n]
        table.remove(self.enemies, n)
        return e
    end

    local e = gengine.entity.create()

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
    return e
end