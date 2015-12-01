var menuPages = {
    mainScreen: {},
    mapSelect: {}
};

var mainPages = {
    menu: {},
    hud: {},
    shop: {}
};

var fader;
var faderOpacity = 0;
var shopContainer;
var shopModel;

function showPage(pages, name, duration, lua)
{
    pages.nextPageName = name;
    gengine_execute("Game.interState = function() " + ((typeof lua == "undefined") ? "" : lua) + "end");
    fader.show();
    fader.fadeTo(duration, 1, function() {
        for(var k in pages)
        {
            if(k!="nextPageName")
            {
                if(k == pages.nextPageName)
                {
                    pages[k].element.show();
                }
                else
                {
                    pages[k].element.hide();
                }
            }
        }

        gengine_execute("Game:interState()");

        fader.fadeTo(duration, 0, function() {
            fader.hide();
        });
    });
}

function updateLife(v)
{
    $(".lifeBar").progressbar( "value", v );
}

function updateGenerator(v)
{
    $(".generatorBar").progressbar( "value", v );
}

function updateShield(v)
{
    $(".shieldBar").progressbar( "value", v );
}

function updateKills(v)
{
    $("#kills").html(v);
}

function startGame(n)
{
    showPage(mainPages, 'hud', 300, "Application:changeState('inGame')");
}

function addMap(index, title)
{
    var content = '<li><span class="button" onclick="startGame(' + index + ');">' + title + '</span></li>';
    $("#maps").append(content);
}

function setupPages(pages, containerName)
{
    var children = $('#' + containerName).children();

    for(var i=0; i<children.size(); ++i)
    {
        var name = $(children.get(i)).attr('id');
        pages[name].element = $('#' + name);
        pages[name].element.hide();
    }
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

$(function() {
    setupPages(mainPages, "pages");
    setupPages(menuPages, "menu");

    fader = $('#fader');
    fader.hide();

    $( ".lifeBar" ).progressbar({
        value: 1,
        max: 1
    });
    $( ".generatorBar" ).progressbar({
        value: 1,
        max: 1
    });
    $( ".shieldBar" ).progressbar({
        value: 1,
        max: 1
    });

    $(".lifeBar").css({ 'background': 'LightRed' });
    $(".lifeBar > div").css({ 'background': 'Red' });
    $(".generatorBar").css({ 'background': 'LightBlue' });
    $(".generatorBar > div").css({ 'background': 'Blue' });
    $(".shieldBar").css({ 'background': 'LightYellow' });
    $(".shieldBar > div").css({ 'background': 'Yellow' });

    $("#garage").on("click", function() {
        showPage(mainPages, 'shop', 300, "Application:changeState('shop')");
    });

    showPage(mainPages, 'menu', 0);
    showPage(menuPages, 'mainScreen', 0);
    gengine_execute("Game:onGuiLoaded()");

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
});
