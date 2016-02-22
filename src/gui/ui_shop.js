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
        var container = this.container;

        items.find('.toggler').on('click', function() {
            var that = $(this).parent();
            gengine.execute("Game:resetItems()");
            playSound("smooth_click");

            if(that.hasClass("selected"))
            {
                items.removeClass("selected");
            }
            else
            {
                items.removeClass("selected");

                that.addClass("selected");

                var offset = that.offset().top - container.offset().top;
                container.scrollTop(offset);

                var type = that.data("type");
                var name = that.data("name");
                var level = that.data("level");
                var code;
                var i;
                var thisValues = shop[type+'s'][name][level];
                var currentValues = shop[type+'s'][shop.currentItems[type].name][shop.currentItems[type].level];

                for(i=0;i<3;i++)
                {
                    var c = thisValues[i] - currentValues[i];
                    var element = that.find('.comparator' + (i+1));

                    element.removeClass();
                    element.addClass('comparator' + (i+1));

                    if(c > 0)
                    {
                        c = '+' + c;
                        element.addClass('positive');
                    }
                    else if(c===0)
                    {
                        c = '=';
                    }
                    else
                    {
                        element.addClass('negative');
                    }

                    element.html(c);
                }

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

            }
        });

        items.find(".buy").on('click', function() {
            var that = $(this);
            var parent = that.parent().parent();

            var type = parent.data("type");
            var name = parent.data("name");
            var level = parent.data("level");

            var code = "Session:buy('" + type + "','" + name + "'," + level + ")";
            gengine.execute(code);
            playSound("button");
        });
    },
    clear: function()
    {
        this.container.find(".itemInstance").remove();
        this.weapons = {};
        this.shields = {};
        this.generators = {};
    },
    addItem: function(type, name, level, title, price, info1, info2, info3)
    {
        var item = this.model.clone();
        this.container.append(item);
        item.show();
        item.addClass(type);
        item.addClass("itemInstance");
        item.find(".name").html(title + " " + level);
        item.find(".price").html(price);
        item.data("type", type);
        item.data("name", name);
        item.data("level", level);
        item.data("price", price);

        this[type + 's'][name] = this[type + 's'][name] || {};
        this[type + 's'][name][level] = [parseFloat(info1), parseFloat(info2), parseFloat(info3)];

        switch(type)
        {
            case "weapon":
            {
                item.find(".label1").html("Damage/s :");
                item.find(".label2").html("Speed :");
                item.find(".label3").html("Power cost/s :");
            }
            break;

            case "generator":
            {
                item.find(".label1").html("Power/s :");
                item.find(".label2").html("Capacity :");
                item.find(".label3").html("");
            }
            break;

            case "shield":
            {
                item.find(".label1").html("Capacity :");
                item.find(".label2").html("Regeneration :");
                item.find(".label3").html("Power cost/s :");
            }
            break;
        }

        item.find(".value1").html(info1);
        item.find(".value2").html(info2);
        item.find(".value3").html(info3);
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
            else
            {
                _this.find(".buy").show();
                _this.find(".price").html(_this.data("price"));
                _this.removeClass("current");
            }
        });
    }
};
