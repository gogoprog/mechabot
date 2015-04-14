function switchToHud()
{
    document.getElementById("menu").style.display = "none";
    document.getElementById("hud").style.display = "block";
}

function switchToMenu()
{
    document.getElementById("hud").style.display = "none";
    document.getElementById("menu").style.display = "block";
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
    $( "#lifeBar" ).progressbar({
        value: 1,
        max: 1
    });
    $( "#generatorBar" ).progressbar({
        value: 1,
        max: 1
    });
    switchToMenu();
});