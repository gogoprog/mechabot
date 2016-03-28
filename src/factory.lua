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
    soldiers = {},
    bullets = {},
    bulletsWithParticles = {},
    particles = {},
    effects = {},
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
    gengine.audio.sound.createFromDirectory("data/audio/")
    self.definitions = {
        enemies = dofile("data/defs/enemies.lua"),
        effects = dofile("data/defs/effects.lua")
    }
end

function Factory:createCamera()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentCamera(),
        {
            orthographic = true,
            orthoSize = 1080
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
        ComponentStaticSprite2D(),
        {
            sprite = cache:GetResource('Sprite2D', texture),
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
        ComponentAnimatedSprite2D(),
        {
            animationSet = cache:GetResource("AnimationSet2D", "animations/mecha/mecha.scml"),
            animation = "walk",
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
        ComponentAnimatedSprite2D(),
        {
            animationSet = cache:GetResource("AnimationSet2D", "animations/arm/arm.scml"),
            animation = "fireing",
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
    local has_particles = weapon.effects and weapon.effects.bullet
    local pool = has_particles and self.bulletsWithParticles or self.bullets
    local e = self:pickFromPool(pool)
    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentStaticSprite2D(),
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
                pool = pool
            }
            )

        if has_particles then
            --[[e:addComponent(
                ComponentParticleSystem(),
                {
                    size = 32,
                    emitterRate = 20,
                    emitterLifeTime = 1024,
                    extentRange = {Vector2(8,8), Vector2(16,16)},
                    directionRange = {0, 2*3.14},
                    speedRange = {0, 0},
                    rotationRange = {-3, 3},
                    spinRange = {-10, 10},
                    linearAccelerationRange = {Vector2(0, 0), Vector2(0, 0)},
                    layer = 100,
                    keepLocal = false
                },
                "particles"
                )]]
        end
    end


    if has_particles then
        --[[e.particles.emitterRate = 0

        local effect = self.definitions.effects[weapon.effects.bullet]
        if effect then
            if effect.particle then
                for k, v in pairs(effect.particle) do
                    e.particles[k] = v
                end
            end
        end

        e.particles:reset()]]
    end

    e.bullet.velocity = velocity
    e.bullet.damage = weapon.damage
    e.bullet.radius = weapon.bulletRadius
    e.bullet.itIsEnemy = is_enemy
    e.bullet.weapon = weapon

    e.sprite.sprite = cache:GetResource('Sprite2D', 'textures/' .. weapon.texture .. '.png')
    e.sprite.extent = weapon.extent
    e.sprite.color = weapon.color or Color(1,1,1,1)

    return e
end

function Factory:createEffect(name, no_sound, duration)
    local e = self:pickFromPool(self.effects)
    if not e then
        e = gengine.entity.create()

        --[[e:addComponent(
            ComponentParticleSystem(),
            {
                layer = 20,
                size = 32
            },
            "particles"
            )]]

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.effects
            }
            )

        e:addComponent(
            ComponentRemover(),
            {
            },
            "remover"
            )
    end

    e.remover.duration = duration
    --[[e.particles.emitterRate = 0

    local effect = self.definitions.effects[name]
    if effect then
        if effect.particle then
            for k, v in pairs(effect.particle) do
                e.particles[k] = v
            end
        end
        if effect.sound and not no_sound then
            gengine.audio.playSound(effect.sound, 0.5)
        end
    end

    e.particles:reset()]]

    return e
end

function Factory:createSoldier()
    local e = self:pickFromPool(self.soldiers)
    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentAnimatedSprite2D(),
            {
                animationSet = cache:GetResource("AnimationSet2D", "animations/soldier.scml"),
                animation = "walk",
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
        ComponentAnimatedSprite2D(),
        {
            animationSet = cache:GetResource("AnimationSet2D", "animations/redlight/redlight.scml"),
            animation = "ongoing",
            layer = 10
        },
        "sprite"
        )

    --e.sprite:pushAnimation(gengine.graphics.spriter.get("redlight-start"))

    return e
end

function Factory:createSprite(texture_name, layer)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentStaticSprite2D(),
        {
            sprite = cache:GetResource('Sprite2D', texture_name),
            layer = layer
        },
        "sprite"
        )

    return e
end

function Factory.createEnemy(object, layer)
    local e = Factory:pickFromPool(Factory.enemies)
    local def = Factory.definitions.enemies[layer:GetProperty('type')]

    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentAnimatedSprite2D(),
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

    e.sprite.animationSet = cache:GetResource("AnimationSet2D", def.animationSet)
    e.sprite.animation = def.animation
    e.sprite.layer = 10
    e.sprite.color = def.color or Color(1,1,1,1)

    e.enemy.positions = object.polyline
    e.enemy.def = def

    e.shooter.weaponName = def.weapon[1]
    e.shooter.weaponLevel = def.weapon[2]
    e.shooter.direction = def.shootDirection

    e.position = Vector3(object.x, object.y)
    e.scale = Vector3(def.scale or 1, def.scale or 1)

    table.insert(Map.futureEnemies, e)

    return e
end

function Factory.createBox(e, layer, tile)
    e:addComponent(
        ComponentBox(),
        {
        },
        "box"
        )

    e:addComponent(
        ComponentBlink(),
        {
        },
        "blink"
        )
end
