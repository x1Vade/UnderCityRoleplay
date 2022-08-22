let oldContainerHistory = []
let currentContainer = "home";
let playerId = 0;

let isSprint = false;
let curLap = 0;
let maxLaps = 0;
let maxCheckpoints = 0;
let curCheckpoint = 0;
let startTime = 0;
let previousLapTime = 0;
let currentStartTime = 0;
let fastestLapTime = 0;
let overallLapTime = 0;
let drawRaceStatsIntervalId = 0;
let races = {};
let maps = {};
let pRacingTabletOpen = false

var decodeEntities = (function () {
    // this prevents any overhead from creating the object each time
    var element = document.createElement('div');

    function decodeHTMLEntities(str) {
        if (str && typeof str === 'string') {
            // strip script/html tags
            str = str.replace(/<script[^>]*>([\S\s]*?)<\/script>/gmi, '');
            str = str.replace(/<\/?\w(?:[^"'>]|"[^"]*"|'[^']*')*>/gmi, '');
            element.innerHTML = str;
            str = element.textContent;
            element.textContent = '';
        }

        return str;
    }

    return decodeHTMLEntities;
})();

const calendarFormatDate = {
    sameDay: '[Today at] HH:mm',
    nextDay: '[Tomorrow at] HH:mm',
    nextWeek: 'dddd [at] HH:mm',
    lastDay: '[Yesterday at] HH:mm',
    lastWeek: '[Last] dddd [at] HH:mm',
    sameElse: 'YYYY-MM-DD HH:mm:ss'
}

moment.updateLocale('en', {
    relativeTime: {
        past: function (input) {
            return input === 'now'
                ? input
                : input + ' ago'
        },
        s: 'now',
        future: "in %s",
        ss: '%ds',
        m: "1m",
        mm: "%dm",
        h: "1h",
        hh: "%dh",
        d: "1d",
        dd: "%dd",
        M: "1mo",
        MM: "%dmo",
        y: "1y",
        yy: "%dy"
    }
});

var debounce = function (func, wait, immediate) {
    var timeout;
    return function () {
        var context = this, args = arguments;
        var later = function () {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
};

$(document).ready(function () {
    $('.collapsible').collapsible();
    $('.modal').modal();

    $.post('http://ucrp-racing/getWeather', JSON.stringify({}));

    setInterval(function () {
        $.post('http://ucrp-racing/getWeather', JSON.stringify({}));
    }, 60 * 1000);

    /* This handles keyEvents - ESC etc */
    document.onkeyup = function (data) {
        // If Key == ESC -> Close Phone
        if (data.which == 27) {
            $.post('http://ucrp-racing/close', JSON.stringify({}));
        }
    }

    $(".phone-screen").on('click', '.phone-button', function (e) {
        var action = $(this).data('action');
        var actionButton = $(this).data('action-button');
        if (actionButton !== undefined) {
            switch (actionButton) {
                case "home":
                    if (currentContainer !== "home") {
                        openContainer('home');
                    }
                    break;
                case "back":
                    if (oldContainerHistory.length > 0)
                        openContainer(oldContainerHistory.pop(), null, currentContainer);
                    break;
                case "browser":
                    openBrowser($(this).data('site'));
                    openContainer("importados");
                    break;
            }
        }
        if (action !== undefined) {
            switch (action) {
                default:
                    $.post('http://ucrp-racing/' + action, JSON.stringify({}));
                break;
            }
        }
    });

    window.addEventListener('message', function (event) {
        var item = event.data;

        if (item.openPhone === true) {
            pRacingTabletOpen = true
            $('.top-notifications-wrapper').removeClass("slideinnotify").addClass("slideoutnotify").fadeOut()
            $('.notification-container-twitter').removeClass("slideinnotify").addClass("slideoutnotify").fadeOut()
            
            $(".phone-screen").removeClass("slideout").css("bottom" , "31px")
            $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-app").css("bottom" , "0");
            
            $(".phone-screen").css("top" , "");
            $(".phone-screen").css("left" , "");
            $(".phone-screen").css("right" , "");
            $(".phone-screen").css("width" , "");
            $(".phone-screen").css("bottom" , "");
            $(".phone-screen").css("height" , "");
            $(".phone-screen").css("min-width" , "");
            $(".phone-screen").css("min-height" , "");
            $(".phone-screen").css("margin" , "");
            document.getElementById("tela").style.backgroundImage = "url(https://c4.wallpaperflare.com/wallpaper/683/633/291/windows-11-microsoft-hd-wallpaper-preview.jpg" +")";
            if (item.wallpaper) {
                document.getElementById("tela").style.backgroundImage = "url("+item.wallpaper+"&w=1366&h=768" +")";
            }
            
            $(".navigation-menu").css("bottom" , "-25px")
            $(".row .col.s3 ").css("width" , "")
            openPhoneShell();
            playerId = item.playerId;
            $('.status-bar-player-id').text(item.playerId);
              
            openContainer("home")

            if(callStates[currentCallState] !== "isNotInCall") {
              
            }
        }

        if (item.openPhone === false) {
            pRacingTabletOpen = false
            closePhoneShell();
            $('#browser').fadeOut(300);
            closeContainer("home");
        }

        switch (item.openSection) {
            case "iphone":
                $(".notch").css("display" , "flex");
                $(".phone-screen").css("border-radius" , "");
                
                $(".jss1264").css("top" , "");
                $(".jss1264").css("left" , "");
                
                $(".jss1264").css("bottom" , "");
                $(".jss1264").css("right" , "");
                $(".jss1264").css("width" , "");
                $(".jss1264").css("height" , "");
                $(".jss1264").css("padding" , "");
                $(".jss1264").css("z-index" , "");
                $(".jss1264").css("position" , "");
                $(".jss1264").css("background" , "");
                $(".jss1264").css("border-radius" , "1");
                $(".jss1264").css("transform" , "1");
                $(".jss1264").css("top" , "1");
                $(".jss1264").css("left" , "1");
                $(".jss1264").css("min-width" , "1");
                $(".jss1264").css("min-height" , "1");
                $(".jss1264").css("transform-style" , "1");
                $(".jss1264").css("margin" , "1");
                $(".jss1264").css("transition" , "1");
                $(".jss16465").css("top" , "");
                $(".jss16465").css("left" , "");
                $(".jss16465").css("width" , "");
                $(".jss16465").css("height" , "");
                $(".jss16465").css("z-index" , "");
                $(".jss16465").css("position" , "");
                $(".jss16465").css("background" , "");
                $(".jss16465").css("border-top" , "");
                $(".jss16465").css("box-shadow" , "");
                $(".jss16465").css("border-bottom" , " ");
                $(".jss16465").css("border-radius" , "");
                $(".jss16471").css("top" , "");
                $(".jss16471").css("left" , "");
                $(".jss16471").css("width" , "");
                $(".jss16471").css("height" , "");
                $(".jss16471").css("overflow" , "");
                $(".jss16471").css("position" , "");
                $(".jss16471").css("border-radius" , "");
                $(".jss16472").css("top" , "");
                $(".jss16472").css("left" , "");
                $(".jss16472").css("width" , "");
                $(".jss16472").css("height" , "");
                $(".jss16472").css("z-index" , "");
                $(".jss16472").css("position" , "");
                $(".jss16472").css("border-radius" , "");
                $(".jss16472").css("box-shadow" , "");
                $(".jss16472").css("pointer-events" , ""); 
            break;
            case "rodarphone":
                $(".phone-screen").css("top" , "0px");
                $(".phone-screen").css("left" , "0px");
                $(".phone-screen").css("right" , "52px");
                $(".phone-screen").css("width" , "978px");
                $(".phone-screen").css("bottom" , "-53px");
                $(".phone-screen").css("height" , "420px");
                $(".phone-screen").css("min-width" , "978px");
                $(".phone-screen").css("min-height" , "420px");
                $(".phone-screen").css("margin" , "auto");

                $(".browser-window").css("width" , "98%");
                $(".browser-window").css("height" , "379px");
                $(".browser-window").css("margin-left" , "184px");
                $(".browser-window").css("margin-top" , "232px");

                $(".notch").css("transform" , "rotate( -90deg ) scale(1)")
                $(".notch").css("top" , "170px");
                $(".notch").css("left" , "-59px");
                
                $(".navigation-menu").css("bottom" , "0px")

                // Aplicativos
                $(".row .col.s3 ").css("width" , "8%")
                $(".row .col.s12 ").css("width" , "120%")
                $(".row").css("margin-bottom" , "0px")

                //Contacts App
                $(".collapsible-header").css("margin-top" , "15px")
                $(".collapsible span.badge").css("margin-left" , "-114px")


                // Menu

                $(".modal.modal-fixed-footer").css("height" , "47%")
                $(".modal.modal-fixed-footer").css("margin-top" , "58px")
                $(".phone-modal").css("width" , "calc(40% - 50px);")

                break;
                case "phonenormal":
                

                    $(".phone-screen").css("top" , "");
                    $(".phone-screen").css("left" , "");
                    $(".phone-screen").css("right" , "");
                    $(".phone-screen").css("width" , "");
                    $(".phone-screen").css("bottom" , "");
                    $(".phone-screen").css("height" , "");
                    $(".phone-screen").css("min-width" , "");
                    $(".phone-screen").css("min-height" , "");
                    $(".phone-screen").css("margin" , "");



                    $(".browser-window").css("width" , "");
                    $(".browser-window").css("height" , "");
                    $(".browser-window").css("margin-left" , "");
                    $(".browser-window").css("margin-top" , "");

                    $(".notch").css("transform" , "")
                    $(".notch").css("top" , "");
                    $(".notch").css("left" , "");
                    
                    $(".navigation-menu").css("bottom" , "-25px")
                     // Aplicativos
                     $(".row .col.s3 ").css("width" , "")
                     $(".row .col.s12 ").css("width" , "")
                     $(".row").css("margin-bottom" , "")
 
                     //Contacts App
                     $(".collapsible-header").css("margin-top" , "")
                     $(".collapsible span.badge").css("margin-left" , "")
 
 
                     // Menu
 
                     $(".modal.modal-fixed-footer").css("height" , "")
                     $(".modal.modal-fixed-footer").css("margin-top" , "")
                     $(".phone-modal").css("width" , "")
                    break;
            case "phonemedio":
                $(".phone-screen").removeClass("slideout").addClass('slidein').show().css("bottom" , "-531px").add($('.phone-screen')).fadeIn();
                $(".phone-app").removeClass("slideout").addClass('slidein').show().css("bottom" , "-550px").add($('.phone-screen')).fadeIn();
                break;
            case "phonemedioclose":
                if(pRacingTabletOpen === false) {
                    $(".phone-screen").removeClass("slidein").addClass("slideout").fadeOut()
                    $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
                    $(".phone-app").css("bottom" , "10px")
                }
                break;
            case "racing:events:list":
                $('.racing-entries').empty();
                $("#flag-teste").css({"color":"#b4efb4"});
                $("#flag-teste").css({"border-bottom":"2px solid #b4efb4"});
                $("#flag-teste").css({"padding":"6px 15px"});
                races = item.races;
                addRaces(races);
                setInterval(racingStartsTimer, 1000);
                openContainer('racing')
                if (item.canMakeMap)
                    $('.racing-create').css("visibility", "visible").hide().fadeIn(150);
                break;
            case "racing-start":
                $('#racing-start-tracks').empty();
                maps = item.maps;
                addRacingTracks(maps);
                openContainer('racing-start');
                break;
            case "racing:hud:update":
                switch (item.hudState) {
                    case "starting":
                        $('#racing-hud').fadeIn(300);
                        startTime = moment.utc();
                        currentStartTime = startTime;
                        drawRaceStats();
                        break;
                    case "start":
                        isSprint = item.hudData.isSprint
                        if (isSprint)
                            $('#FastestLaptime').hide();
                        startTime = moment.utc();
                        currentStartTime = startTime;
                        curLap = 1;
                        maxLaps = item.hudData.maxLaps;
                        curCheckpoint = 1;
                        maxCheckpoints = item.hudData.maxCheckpoints;
                        fastestLapTime = 0;
                        drawRaceStatsIntervalId = this.setInterval(drawRaceStats, 10);
                        break;
                    case "update":
                        checkFastestLap(item.hudData.curLap);
                        curLap = item.hudData.curLap;
                        curCheckpoint = item.hudData.curCheckpoint;
                        break;
                    case "finished":
                        checkFastestLap(item.hudData.curLap);
                        endTime = moment.utc();
                        curLap = maxLaps;
                        curCheckpoint = maxCheckpoints;
                        this.clearInterval(drawRaceStatsIntervalId);
                        drawRaceStats();
                        $.post('http://ucrp-racing/race:completed', JSON.stringify({
                            fastestlap: moment(fastestLapTime).valueOf(),
                            overall: moment(endTime - startTime).valueOf(),
                            sprint: isSprint,
                            identifier: item.hudData.eventId
                        }));
                        break;
                    case "clear":
                        curLap = 0;
                        maxLaps = 0;
                        curCheckpoint = 0;
                        maxCheckpoints = 0;
                        fastestLapTime = 0;
                        endTime = 0;
                        startTime = 0;
                        currentStartTime = 0;
                        drawRaceStats();
                        $('#racing-hud').fadeOut(300);
                        break;
                }
                break;
            case "racing:event:update":
                if (item.eventId !== undefined) {
                    $(`.racing-entries li[data-event-id="${item.eventId}"]`).remove();
                    if (races !== undefined)
                        races[item.eventId] = item.raceData
                    addRace(item.raceData, item.eventId);
                } else
                    races = item.raceData
                break;
            case "racing:events:highscore":
                $('.racing-highscore-entries').empty();
                addRacingHighScores(item.highScoreList);
                openContainer('racing-highscore');
                break;
        }
    });
});

$('.phone-screen').on('copy', '.number-badge', function (event) {
    if (event.originalEvent.clipboardData) {
        let selection = document.getSelection();
        selection = selection.toString().replace(/-/g, "")
        event.originalEvent.clipboardData.setData('text/plain', selection);
        event.preventDefault();
    }
});

function checkFastestLap(dataLap) {
    if (curLap < dataLap) {
        let lapTime = curLap === 0 ? moment(startTime - currentStartTime) : moment(moment.utc() - currentStartTime);
        if (fastestLapTime === 0)
            fastestLapTime = lapTime;
        else if (lapTime.isBefore(fastestLapTime)) {
            fastestLapTime = lapTime;
        }
        currentStartTime = moment.utc();
    }
}

function drawRaceStats() {
    $('#Lap').text(`${curLap} / ${maxLaps}`);
    $('#Checkpoints').text(`${curCheckpoint} / ${maxCheckpoints}`);
    $('#Laptime').text(`${moment(moment.utc() - currentStartTime).format("mm:ss.SSS")}`);
    if (!isSprint)
        $('#FastestLaptime').text(`${moment(fastestLapTime).format("mm:ss.SSS")}`)
    $('#OverallTime').text(`${moment(moment.utc() - startTime).format("mm:ss.SSS")}`)
}

function addRacingHighScores(highScores) {
    for (let highScore in highScores) {
        let score = highScores[highScore]
        let highScoreElement = `
        <li>
        <div class="collapsible-header">
            <i class="fad fa-trophy" style="font-size: 55px"> </i>
            <i class="name-car" style="font-size: 18px;">${score.map}</i>
            <span  class="new-badge">Vencedor: ${score.fastestName}</span>
        </div>
        <div class="collapsible-body garage-body">
        <i class="fas fa-map-marker-alt fa-2x btn-contacts-send-message"  aria-label="${score.fastestName}" style="margin-top: 20px;margin-left: 47px;"></i>
        <i class="fas fa-closed-captioning fa-2x btn-contacts-send-message"  aria-label="${score.fastestSprintName}"style="margin-left: 10px;"></i>
        <i class="fas fa-oil-can fa-2x btn-contacts-send-message"  aria-label="${score.mapDistance}"></i>

     
    </div>
</li>`;
        $('.racing-highscore-entries').prepend(highScoreElement);
    }
}

function addRacingTracks(tracks) {
    $('#racing-start-tracks').append(`<option value="" disabled selected>Choose your option</option>`);
    for (let track in tracks) {
        $('#racing-start-tracks').append(`<option value="${track}">${tracks[track].track_name}</option>`)
    }
    $('select').formSelect();
}

function racingStartsTimer() {
    $('.racing-entries .racing-start-timer').each(function () {
        let startTime = moment.utc($(this).data('start-time'));
        if (startTime.diff(moment.utc()) > 0) {
            let formatedTime = makeTimer(startTime);
            $(this).text(`${formatedTime.minutes} min ${formatedTime.seconds} Seconds.`);
        }
        else {
            $(this).text('Closed');
        }
    });
}

function addRace(race, raceId) {
    let raceElement = `<li data-event-id="${raceId}">
    <div class="hovereffect">

    </h3>
    `
    if (race.open)
        raceElement += `<button id="hovercorridas" style="margin-left: 20px;" class="racing-entries-join phone-button" data-id="${race.identifier}" aria-label="Join race" data-balloon-pos="up"><i class="fas fa-flag-checkered icon"></i></button> `
    raceElement += `<button id="hovercorridas" class=" phone-button" data-action="racing:event:leave" aria-label="Leave race" data-balloon-pos="up"><i class="fas fa-sign-out-alt icon"></i></button> `
    raceElement +=
    `         
    </h3>
    

    <div class="collapsible-header row scrollbar--dark no-padding" style="margin-bottom: 0px;">
    <div class="col s12">
    <div class="row no-padding">
    <div class="col s12">

    <span class="name-racing">${race.raceName}</span>
    <span class="voltas-racing">Laps: ${race.laps}</span>
    </div>
    </div>
    <div class="row no-padding">
    <div class="col s12">
    <span data-balloon-pos="down" class="racing-start-timer" style=${race.open ?  "color:" + "white" : "margin-left:161px; + color:" + "red"} data-start-time="${race.startTime}" ></span>
    </div>
    </div>
 
    </li>
    `
    $('.racing-entries').prepend(raceElement);
}

function addRaces(races) {
    for (let race in races) {
        let curRace = races[race]
        addRace(curRace, race);
    }
}

var validBinds = [
    "esc","f1","f2","f3","f5","f5","f6","f7","f8","f9","f10",
    "~","5","6","7","8","9","-","=","backspace",
    "tab","q","e","r","t","y","u","p","[","]","enter",
    "caps","f","g","h","k","l",
    "leftshift","z","x","c","b","n","m",",",".",
    "leftctrl","leftalt","space","rightctrl",
    "home","pageup","pagedown","delete",
    "left","right","top","down",
    "nenter","n4","n5","n6","n7","n8","n9","inputaim"
];

// Util Functions of Controls

function getCurrentBindFromID(bindID)
{
    for (var i = currentBinds.length - 1; i >= 0; i--) {
        if(currentBinds[i][0].toUpperCase() == bindID.toUpperCase())
        {
            return currentBinds[i][1];
        }
    }

    return false;
}

function setBindFromID(bindID,bind)
{
    for (var i = currentBinds.length - 1; i >= 0; i--) {
        if(currentBinds[i][0].toUpperCase() == bindID.toUpperCase())
        {
            currentBinds[i][1] = bind;
        }
    }
}

function validKey(key)
{
    var bindValid = false
    for (var i = validBinds.length - 1; i >= 0; i--) {
        if(validBinds[i].toUpperCase() == key.toUpperCase())
        {
            bindValid = true
        }
    }
    return bindValid
    
}


// Fill fucntion of control
function createControlList()
{
    for (let i = 0; i < controlNames.length; i++) { 
        var bindID = controlNames[i][0];
        var bindIsLocked = controlNames[i][2];

        if(bindID == "label")
        {
             var element = $(`
                <div class="row settings-switchBorder">
                  <div class="col s12 resizeBorder">
                      <label class="resizeBorder-Text">${controlNames[i][1]}</label>
                  </div>
                </div> 
            `);

            $('#controlSettings').append(element);
        }
        else
        {
            var element;
            if(bindIsLocked)
            {
                element = $(`
                    <div class="row settings-switchBorder">
                        <div class="col s8">
                            <label class="resizeBorder2 lockedText">${controlNames[i][1]}</label>
                        </div>
                        <div class="input-field col s4 input-field-small">
                             <input class="errorChecking white-text" id="${bindID}" type="text" onfocusout="TriggerSubmit(id)" data-isUnique="${controlNames[i][2]}"> 
                        </div>
                    </div>
                <span class="error" id="${bindID}-error" aria-live="polite"></span> 
                `);
            }
            else
            {
                element = $(`
                    <div class="row settings-switchBorder">
                        <div class="col s8">
                            <label class="resizeBorder2">${controlNames[i][1]}</label>
                        </div>
                        <div class="input-field col s4 input-field-small">
                             <input class="errorChecking white-text" id="${bindID}" type="text" onfocusout="TriggerSubmit(id)" data-isUnique="${controlNames[i][2]}"> 
                        </div>
                    </div>
                <span class="error" id="${bindID}-error" aria-live="polite"></span> 
                `);
            }
            $('#controlSettings').append(element);
            $("#"+bindID).val(getCurrentBindFromID(bindID))
        }
         
    }
}

function delay() {
  return new Promise(resolve => setTimeout(resolve, 30));
}

async function delayedLog(item) {
  await delay();
}

function findTypeOf(settingID)
{
    var type = 0

    for (j in checkedFunctions) {
        if(settingID == checkedFunctions[j])
        {
            type = 1
        }
    }

    if(type == 0)
    {
        for (j in sliderFunctions) {
            if(settingID == sliderFunctions[j])
            {
                type = 2
            }
        }
    }

    return type
}

//Submit Function / check function / main function of control
function TriggerSubmit(name)
{
    var error = $("#"+name+"-error")[0]; 
   
    var valid = true
    var errorMessage = "Invalid Control Input."

    var inputVal = $("#"+name).val();
    var isUnique = $("#"+name).attr("data-isUnique");


     if(inputVal == "")
    {
        valid = false;
        errorMessage = "There must be a bind for this.";
    }

    if(valid)
    {

        if(inputVal.includes('+'))
        {
            var split = inputVal.split("+");
            if(split.length == 2){
                if(!validKey(split[0]))
                {
                    valid = false 
                    errorMessage = "Not a valid bind [1]."
                }
                if(!validKey(split[1]) && valid)
                {
                    valid = false 
                    errorMessage = "Not a valid bind [2]."
                }
            }
            else
            {
                valid = false 
                errorMessage = "Cannot bind 3 keys."
            }
        }
        else
        {
            if(!validKey(inputVal))
            {
                valid = false 
                errorMessage = "Not a valid bind."
            }
        }
    }

    if (valid) {
        for (var i = controlNames.length - 1; i >= 0; i--) {
            if(controlNames[i][0] != "label")
            {
                var nameArr = controlNames[i][0]
                var isUniqueArr = $("#"+nameArr).attr("data-isUnique");
                if(nameArr != name){

                    // If input is the same as another already set input and that found input is unique then error
                    if($("#"+nameArr).val().toUpperCase() == inputVal.toUpperCase() && isUniqueArr == "true"){
                        valid = false;
                        errorMessage = "This Bind is already Being Used";
                    }
                    // if input is same as another already set input and THIS is unique then error
                    
                    if($("#"+nameArr).val().toUpperCase() == inputVal.toUpperCase() && isUnique == "true")
                    {
                        valid = false;
                        errorMessage = "Already in Use : "+controlNames[i][1];
                    }

                    if(inputVal.includes('+'))
                    {
                        var split = inputVal.split("+");
                        var newInput = split[1]+"+"+split[0]

                        if(split[1].toUpperCase() == split[0].toUpperCase()){
                            valid = false;
                            errorMessage = "Both Binds cannot be the same";
                        }

                        // If input is the same as another already set input and that found input is unique then error
                        if($("#"+nameArr).val().toUpperCase() == newInput.toUpperCase() && isUniqueArr == "true"){
                            valid = false;
                            errorMessage = "This Bind is already Being Used";
                        }
                        // if input is same as another already set input and THIS is unique then error
                        
                        if($("#"+nameArr).val().toUpperCase() == newInput.toUpperCase() && isUnique == "true")
                        {
                            valid = false;
                            errorMessage = "Already in Use : "+controlNames[i][1];
                        }
                    }
                }
            }
        }
    }

    if (!valid) {
        error.innerHTML = errorMessage;
        error.className = "error active";
    }
    else
    {
        $("#"+name).val(inputVal.toUpperCase())
        setBindFromID(name,inputVal)
        error.innerHTML = "";
        error.className = "error";
    }
}

function reply_click(clicked_id)
{
  currentSettingWindow = clicked_id;
}

$('#racing-create-form').on('reset', function (e) {
    $.post('http://ucrp-racing/racing:map:cancel', JSON.stringify({}));
});

$('#racing-start-tracks').on('change', function (e) {
    let selectedMap = $(this).val();
    if(maps[selectedMap] !== undefined) {
        $.post('http://ucrp-racing/racing:map:removeBlips', JSON.stringify({}));
        $.post('http://ucrp-racing/racing:map:load', JSON.stringify({ id: selectedMap}));
        $('#racing-start-map-creator').text(maps[selectedMap].creator);
        $('#racing-start-map-distance').text(maps[selectedMap].distance);
        $('#racing-start-description').text(maps[selectedMap].description);
    }
});

$('#racing-start').submit(function (e) {
    e.preventDefault();
    let reverseTrack = false;
    if ($('#racing-reverse-track').is(":checked")) { reverseTrack = true };
    $.post('http://ucrp-racing/racing:event:start', JSON.stringify({
        raceMap: $('#racing-start-tracks').val(),
        raceLaps: $('#racing-start-laps').val(),
        raceStartTime: moment.utc().add($('#racing-start-time').val(), 'seconds'),
        reverseTrack: reverseTrack,
        raceCountdown: $('#racing-start-time').val(),
        raceName: $('#racing-start-name').val(),
        mapCreator: $('#racing-start-map-creator').text(),
        mapDistance: $('#racing-start-map-distance').text(),
        mapDescription: $('#racing-start-description').text()
    }));
});

$('#racing-create-form').submit(function (e) {
    e.preventDefault();
    $.post('http://ucrp-racing/racing:map:save', JSON.stringify({
        name: escapeHtml($('#racing-create-name').val()),
        desc: escapeHtml($('#racing-create-description').val()),
    }));
});

$('#real-estate-evict-modal-accept').click(function () {
    $.post('http://ucrp-racing/btnEvictHouse', JSON.stringify({}));
    $('#real-estate-evict-modal-').modal('close');
});

$('.btn-racing-clear').click(function() {
    $.post('http://ucrp-racing/racing:map:removeBlips', JSON.stringify({}));
});

$('.racing-create').click(function () {
    openContainer('racing-create');
});

$('.racing-entries').on('click', '.racing-entries-entrants', function () {
    $('#racing-entrants-modal').modal('open');
    $('.racing-entrants').empty();
    $('#racing-info-description').text();
    let currentRace = races[$(this).data('id')]
    $('#racing-info-description').text(currentRace.mapDescription);
    if(currentRace.racers !== undefined)
        currentRace.racers = Object.values(currentRace.racers).sort((a,b) => a.total - b.total); 
    for (let id in currentRace.racers) {
        let racer = currentRace.racers[id];
        let racerElement = `
            <li>
                <div class="collapsible-header">Titanium#${racer.server_id}</div>
                <div class="collapsible-body">
                    <div class="row">
                        <div class="col s3 right-align">
                            <i class="fas fa-shipping-fast fa-2x icon "></i>
                        </div>  
                        <div class="col s9">
                            <strong>Fastest Lap</strong>
                            <br>${moment(racer.fastest).format("mm:ss.SSS")}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s3 right-align">
                            <i class="fas fa-stopwatch fa-2x icon"></i>
                        </div>  
                        <div class="col s9">
                            <strong>Total</strong>
                            <br>${moment(racer.total).format("mm:ss.SSS")}
                        </div>
                    </div>
                </div>
            </li>
        `
        $('.racing-entrants').append(racerElement);
    }
});

$('.racing-entries').on('click', '.racing-entries-join', function () {
    $.post('http://ucrp-racing/racing:event:join', JSON.stringify({ identifier: $(this).data('id') }));
});

function openContainer(containerName, fadeInTime = 500, ...args) {
    closeContainer(currentContainer, (currentContainer !== containerName ? 300 : 0));
    $("." + containerName + "-container").hide().fadeIn((currentContainer !== containerName ? fadeInTime : 0));
    if (containerName === "home") {
        $(".phone-screen .rounded-square:not('.hidden-buttons')").each(function () {
            $(this).fadeIn(1000);
        });
        $(".navigation-menu").fadeTo("slow", 0.5, null);
    }
    else
        $(".navigation-menu").fadeTo("slow", 1, null);

    if (containerName === "racing")
        clearInterval(racingStartsTimer);

    if (containerName === "message")
        $('.message-entries-wrapper').animate({
            scrollTop: $('.message-entries-wrapper')[0].scrollHeight
        }, 0);

    if (args[0] === undefined) {
        oldContainerHistory.push(currentContainer);
    }
    currentContainer = containerName;
}

function closeContainer(containerName, fadeOutTime = 500) {
    $.when($("." + containerName + "-container").fadeOut(fadeOutTime).hide()).then(function () {
        if (containerName === "home")
            $(".phone-screen .rounded-square").each(function () {
                $(this).fadeIn(300);
            });
    });
}

function openPhoneShell() {
    $('.tablet-container').show();
    $(".phone-screen").removeClass("closephone").addClass('openphone').show().css("bottom" , "32px").add($('.jss13')).fadeIn(500);
   
}

function closePhoneShell() {
    $(".phone-screen").removeClass("openphone").addClass("closephone").fadeOut()
}


var entityMap = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#39;',
    '/': '&#x2F;',
    '`': '&#x60;',
    '=': '&#x3D;'
};

function escapeHtml(string) {
    return String(string).replace(/[&<>"'`=\/]/g, function (s) {
        return entityMap[s];
    });
}

function makeTimer(targetTime) {
    var endTime = new Date(targetTime);
    endTime = (Date.parse(endTime) / 1000);

    var now = new Date();
    now = (Date.parse(now) / 1000);

    var timeLeft = endTime - now;

    var days = Math.floor(timeLeft / 86400);
    var hours = Math.floor((timeLeft - (days * 86400)) / 3600);
    var minutes = Math.floor((timeLeft - (days * 86400) - (hours * 3600)) / 60);
    var seconds = Math.floor((timeLeft - (days * 86400) - (hours * 3600) - (minutes * 60)));

    if (hours < "10") { hours = "0" + hours; }
    if (minutes < "10") { minutes = "0" + minutes; }
    if (seconds < "10") { seconds = "0" + seconds; }

    return {
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds
    }
}