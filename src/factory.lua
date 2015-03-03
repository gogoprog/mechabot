require 'component_parallax'

Factory = Factory or {}

function Factory:createParallax(h, y, speed)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("box"),
            extent = vector2(800, h),
            layer = 0
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