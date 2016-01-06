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

    self.money = 10000
end

function Session:start(lvl)
    self.currentLevel = lvl

    local shop_def = Map.definitions[lvl].shop

    Application:clearShop()

    Application:addShopItem("weapon", self.weapon.name, self.weapon.level)
    Application:addShopItem("generator", self.generator.name, self.generator.level)
    Application:addShopItem("shield", self.shield.name, self.shield.level)

    for k, v in ipairs(shop_def) do
        Application:addShopItem(v.type, v.name, v.level)
    end

    Application:shopPostFill()

    self:updateShop()

    gengine.gui.showPage("shop", "slide", 300)
end

function Session:isCurrentItem(_type, name, level)
    return self[_type].name == name and self[_type].level == level
end

function Session:buy(_type, name, level)
    local item = Game:getItem(_type, name, level)
    local price = item.price

    if price then
        if price <= self.money then
            self[_type].name = name
            self[_type].level = level

            self.money = self.money - price
            gengine.gui.executeScript("shop.updateMoney(" .. self.money .. ")")
        end
    end

    self:updateShop()
end

function Session:updateShop()
    gengine.gui.executeScript("shop.setCurrentItem('weapon', '" .. self.weapon.name .. "', " .. self.weapon.level .. ");")
    gengine.gui.executeScript("shop.setCurrentItem('generator', '" .. self.generator.name .. "', " .. self.generator.level .. ");")
    gengine.gui.executeScript("shop.setCurrentItem('shield', '" .. self.shield.name .. "', " .. self.shield.level .. ");")
    gengine.gui.executeScript("shop.update()")
end

function Session:onLevelWon(score)
    self.money = self.money + score
    Session:start(self.currentLevel + 1)
end
