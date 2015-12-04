var shop = {
    init: function()
    {
        this.container = $("#shop .items");
        this.model = $("#shop .model");
        this.money = $("#shop .money");
        this.model.hide();

        this.addItem("weapon", "plasma", 1, "Plasma", 100);
        this.addItem("weapon", "plasma", 10, "Plasma", 100);
        this.addItem("weapon", "rocket", 1, "Rocket", 100);

        this.addItem("shield", "small", 1, "SmallS", 100);

        this.addItem("generator", "small", 1, "SmallG", 200);

        var items = $(".items").children();
        items.on('click', function() {
            var that = $(this);
            gengine_execute("Game:resetItems()");

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

            gengine_execute(code);
        });

        items.find(".buy").on('click', function() {
            var that = $(this);
            var parent = that.parent().parent();

            var type = parent.data("type");
            var name = parent.data("name");
            var level = parent.data("level");

            var code = "Session:buy('" + type + "','" + name + "'," + level + ")";
            gengine_execute(code);
        });
    },
    clear: function()
    {

    },
    addItem: function(type, name, level, title, price)
    {
        var item = this.model.clone();
        this.container.append(item);
        item.show();
        item.addClass(type);
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
    }
};
