return {
    {
        title = "The Arrival",
        filename = "data/map00.lua",
        parallaxes = {
            {
                y = 48,
                speed = 1/4096,
                texture = "ground"
            },
            {
                y = 220,
                speed =  0.0001,
                texture = "hills_1"
            },
            {
                y = 220,
                speed = 0.00005,
                texture = "hills_2"
            },
            {
                y = 440,
                speed = 0.00002,
                texture = "buildings"
            },
            {
                y = 540,
                speed = 0,
                texture = "sky_colours"
            }
        },
        music = "data/robot.mp3",
        shop = {
            {
                type = "weapon",
                name = "plasma",
                level = 3
            }
        }
    },
    {
        title = "On the way",
        filename = "data/map01.lua",
        parallaxes = {
            {
                y = 48,
                speed = 1/4096,
                texture = "ground"
            },
            {
                y = 220,
                speed =  0.0001,
                texture = "hills_1"
            },
            {
                y = 220,
                speed = 0.00005,
                texture = "hills_2"
            },
            {
                y = 440,
                speed = 0.00002,
                texture = "buildings"
            },
            {
                y = 540,
                speed = 0,
                texture = "sky_colours"
            }
        },
        music = "data/robot.mp3",
        shop = {
            {
                type = "weapon",
                name = "plasma",
                level = 10
            }
        }
    }
}
