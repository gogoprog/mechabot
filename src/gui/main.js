var pages = {
    menu: {},
    hud: {}
}

var fader;
var nextPageName;
var faderOpacity = 0;

function showPage(name)
{
    nextPageName = name;
    fader.show();
    fader.fadeTo(200, 1, function() {
        for(var k in pages)
        {
            if(k==nextPageName)
            {
                pages[k].element.show();
            }
            else
            {
                pages[k].element.hide();
            }
        }

        fader.fadeTo(200, 0, function() {
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

function startGame()
{
    gengine_execute("Game:start()");
}

$(function() {
    for(var k in pages)
    {
        pages[k].element = $('#' + k);
        pages[k].element.hide();
    }

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

    showPage('menu');
});