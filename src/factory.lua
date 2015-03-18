require 'component_parallax'
require 'component_box'
require 'component_arm'
require 'component_bullet'
require 'component_shaker'

Factory = Factory or {}

function Factory:init()

    local atlas = gengine.graphics.atlas.create(
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

function Factory:createBox(i, j)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("box"),
            extent = vector2(32, 32),
            layer = 0
        },
        "sprite"
        )

    e:addComponent(
        ComponentBox(),
        {
        },
        "box"
        )

    e.box:setPosition(i , j)

    return e
end

function Factory:createPlayer()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = self.mechaMoveAnimation,
            extent = vector2(168, 256),
            layer = 0
        },
        "sprite"
        )

    return e
end

function Factory:createArm()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("arm"),
            extent = vector2(256, 128),
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
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("particle"),
            extent = vector2(32, 32),
            color = vector4(0.2, 1.0, 0.2, 1),
            layer = 0
        },
        "sprite"
        )

    e:addComponent(
        ComponentBullet(),
        {
            velocity = velocity
        }
        )

    return e
end

function Factory:createBoxExplosion()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentParticleSystem(),
        {
            texture = gengine.graphics.texture.get("box"),
            size = 32,
            emitterRate = 20000,
            emitterLifeTime = 0.1,
            extentRange = {vector2(8,8), vector2(16,16)},
            lifeTimeRange = {0.5, 1},
            directionRange = {0, 2*3.14},
            speedRange = {100, 500},
            rotationRange = {-3, 3},
            spinRange = {-10, 10},
            scales = {vector2(1, 1)},
            colors = {vector4(0.8,0.8,0.9,1), vector4(0.3,0.3,0.9,1), vector4(0,0,0,0)}
        }
        )

    return e
end
