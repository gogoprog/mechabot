
Map = Map or {
    parallaxes = {}
}

function Map:init()
    local p

    p = Factory:createParallax(128, -300 + 64, 0.01)
    table.insert(self.parallaxes, p)

    p = Factory:createParallax(256, 128, 0.1)
    table.insert(self.parallaxes, p)
end

function Map:start()
    for k, v in ipairs(self.parallaxes) do
        v:insert()
    end
end

function Map:update(dt)

end
