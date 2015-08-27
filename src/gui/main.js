var menuPages = {
    mainScreen: {},
    mapSelect: {}
}

var mainPages = {
    menu: {},
    hud: {}
}

var fader;
var faderOpacity = 0;

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

        gengine_execute("Game:interState()")

        fader.fadeTo(duration, 0, function() {
            fader.hide();
        });
    });
}

function updateLife(v)
{
    $( "#lifeBar" ).progressbar( "value", v );
}

function updateGenerator(v)
{
    $( "#generatorBar" ).progressbar( "value", v );
}

function updateKills(v)
{
    $("#kills").html(v);
}

function startGame(n)
{
    showPage(mainPages, 'hud', 300, "Game:start(" + n + ")");
}

function addMap(index, title)
{
    var content = '<li><span class="button" onclick="startGame(' + index + ');">' + title + '</span></li>';
    $("#maps").append(content);
}

function setupPages(pages)
{
    for(var k in pages)
    {
        pages[k].element = $('#' + k);
        pages[k].element.hide();
    }
}

$(function() {
    setupPages(mainPages);
    setupPages(menuPages);

    fader = $('#fader');
    fader.hide();

    $( "#lifeBar" ).progressbar({
        value: 1,
        max: 1
    });
    $( "#generatorBar" ).progressbar({
        value: 1,
        max: 1
    });

    showPage(mainPages, 'menu', 0);
    showPage(menuPages, 'mainScreen', 0);
    gengine_execute("Game:onGuiLoaded()");
});
