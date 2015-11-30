Session = Session or {}

function Session:init()
    self.weapon = {
        name = "plasma",
        level = 1
    }

    self.generator = {
        name = "small",
        level = 1
    }

    self.shield = {
        name = "small",
        level = 1
    }
end
