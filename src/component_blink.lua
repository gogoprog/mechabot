ComponentBlink = {}

function ComponentBlink:init()
    self.time = 0
    self.blinkLeft = 0
end

function ComponentBlink:insert()
end

function ComponentBlink:update(dt)
    if self.blinkLeft > 0 then
        self.time = self.time + dt

        if self.time > 0.05 then
            local color

            if self.blinkLeft % 2  == 1 then
                color = Color(1,1,1,1)
            else
                color = Color(1,0.5,0.5,0.6)
            end

            self.entity.sprite.color = color

            self.time = 0
            self.blinkLeft = self.blinkLeft - 1
        end
    end
end

function ComponentBlink:remove()
end

function ComponentBlink:blink()
    if self.blinkLeft == 0 then
        self.blinkLeft = 4
    end
end