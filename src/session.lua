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


function Session:isCurrentItem(_type, name, level)
    return self[_type].name == name and self[_type].level == level
end
