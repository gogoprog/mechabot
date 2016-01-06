var generatorBar, shieldBar, lifeBar;

var confirmDialog;

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
    gengine.execute("Session:start(1)");
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

function showConfirmDialog(title, yes_code, no_code)
{
    confirmDialog.attr("title", title);
    confirmDialog.dialog({
      height:166,
      modal: true,
      show: { effect: "fadeIn", duration: 200 },
      hide: { effect: "fadeOut", duration: 200 },
      buttons: {
        "Yes": function() {
          gengine.execute(yes_code);
          $( this ).dialog( "close" );
        },
        "No": function() {
          gengine.execute(no_code);
          $( this ).dialog( "close" );
        }
      }
    });
}

function closeConfirmDialog()
{
    confirmDialog.dialog("close");
}

$(function() {
    gengine.gui.showPage('menu', 'fade', 1);
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

    shop.init();

    confirmDialog = $("#dialog-confirm");
});
