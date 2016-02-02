var shop = {
    currentItems: {},
    init: function()
    {
        this.container = $("#shop .items");
        this.model = $("#shop .model");
        this.money = $("#shop .money");
        this.levelName = $("#shop .nextLevel");
        this.model.hide();
    },
    postFill: function()
    {
        var items = $(".items").children();
        items.on('click', function() {
            var that = $(this);
            gengine.execute("Game:resetItems()");

            items.removeClass("selected");

            that.addClass("selected");

            var type = that.data("type");
            var name = that.data("name");
            var level = that.data("level");
            var code;

            switch(type)
            {
                case "weapon":
                {
                    code = "Game.player.player:setWeapon('";
                }
                break;

                case "generator":
                {
                    code = "Game.player.player:setGenerator('";
                }
                break;

                case "shield":
                {
                    code = "Game.player.player:setShield('";
                }
                break;
            }

            code += name;
            code += "',";
            code += level;
            code += ")";

            gengine.execute(code);
        });

        items.find(".buy").on('click', function() {
            var that = $(this);
            var parent = that.parent().parent();

            var type = parent.data("type");
            var name = parent.data("name");
            var level = parent.data("level");

            var code = "Session:buy('" + type + "','" + name + "'," + level + ")";
            gengine.execute(code);
        });
    },
    clear: function()
    {
        this.container.find(".itemInstance").remove();
    },
    addItem: function(type, name, level, title, price)
    {
        var item = this.model.clone();
        this.container.append(item);
        item.show();
        item.addClass(type);
        item.addClass("itemInstance");
        item.find(".name").html(title + " " + level);
        item.find(".price").html(price);
        item.find(".buy").button();
        item.data("type", type);
        item.data("name", name);
        item.data("level", level);
        item.data("price", price);
    },
    updateMoney: function(amount) {
        this.money.html(amount);
    },
    updateLevelName: function(name) {
        this.levelName.html(name);
    },
    setCurrentItem: function(type, name, level) {
        this.currentItems[type] = {name:name, level:level};
    },
    update: function() {
        var items = this.container.find(".itemInstance");
        var that = this;

        items.each(function(index) {
            var _this = $(this);

            var type = _this.data("type");
            var name = _this.data("name");
            var level = _this.data("level");

            if(that.currentItems[type].name == name && that.currentItems[type].level == level)
            {
                _this.find(".buy").hide();
                _this.find(".price").html("current");
                _this.addClass("current");
            }
            else {
                _this.find(".buy").show();
                _this.find(".price").html(_this.data("price"));
                _this.removeClass("current");
            }
        });
    },
};
