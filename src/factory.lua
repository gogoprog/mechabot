require 'component_parallax'
require 'component_box'

Factory = Factory or {}

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
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("mecha"),
            extent = vector2(128, 256),
            layer = 0
        },
        "sprite"
        )

    return e
end
