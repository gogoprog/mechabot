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
var generatorBar, shieldBar, lifeBar;

var confirmDialog;

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
    lifeBar.progressbar( "value", v );
}

function updateGenerator(v)
{
    generatorBar.progressbar( "value", v );
}

function updateShield(v)
{
    shieldBar.progressbar( "value", v );
}

function updateKills(v)
{
    $("#kills").html(v);
}

function startGame(n)
{
    gengine_execute("Session:start(1)");
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

function goToShop()
{
    showPage(mainPages, 'shop', 300, "Application:changeState('shop')");
}

function goToGame()
{
    showPage(mainPages, 'hud', 300, "Application:changeState('inGame')");
}

function showConfirmDialog(title, code)
{
    confirmDialog.attr("title", title);
    confirmDialog.dialog({
      height:166,
      modal: true,
      show: { effect: "fadeIn", duration: 200 },
      hide: { effect: "fadeOut", duration: 200 },
      buttons: {
        "Yes": function() {
          gengine_execute(code);
          $( this ).dialog( "close" );
        },
        "No": function() {
          $( this ).dialog( "close" );
        }
      }
    });
}

$(function() {
    setupPages(mainPages, "pages");
    setupPages(menuPages, "menu");

    fader = $('#fader');
    fader.hide();

    generatorBar = $(".generatorBar");
    lifeBar = $(".lifeBar" );
    shieldBar = $(".shieldBar");

    lifeBar.progressbar({
        value: 1,
        max: 1
    });
    generatorBar.progressbar({
        value: 1,
        max: 1
    });
    shieldBar.progressbar({
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

    shop.init();

    confirmDialog = $("#dialog-confirm");
});
