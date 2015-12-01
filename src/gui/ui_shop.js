function initShop()
{
    shopContainer = $("#shop .items");
    shopModel = $("#shop .model");
    shopModel.hide();

    addShopItem("weapon", "plasma", 1, "Plasma", 100);
    addShopItem("weapon", "plasma", 10, "Plasma", 100);
    addShopItem("weapon", "rocket", 1, "Rocket", 100);

    addShopItem("shield", "small", 1, "SmallS", 100);

    addShopItem("generator", "small", 1, "SmallG", 200);

    var items = $(".items").children();
    items.on('click', function() {
        var that = $(this);
        gengine_execute("Game:resetItems()");

        if(that.hasClass("selected"))
        {
            items.removeClass("selected");
            return;
        }

        items.removeClass("selected");

        that.addClass("selected");

        var type = that.data("type");
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

        code += that.data("name");
        code += "',";
        code += that.data("level");
        code += ")";

        gengine_execute(code);
    });
}


function clearShop()
{

}

function addShopItem(type, name, level, title, price)
{
    var item = shopModel.clone();
    shopContainer.append(item);
    item.show();
    item.addClass(type);
    item.find(".name").html(title + " " + level);
    item.find(".price").html(price);
    item.data("type", type);
    item.data("name", name);
    item.data("level", level);
    item.data("price", price);
}
