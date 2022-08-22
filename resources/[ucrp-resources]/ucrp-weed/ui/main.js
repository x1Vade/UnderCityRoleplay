let Buttons = [];
let Button = [];

const OpenMenu = (data) => {
    DrawButtons(data)
}

const CloseMenu = () => {
    $(".button").remove();
    Buttons = [];
    Button = [];
};

const DrawButtons = (data) => {
    for (let i = 0; i < data.length; i++) {
        let description = data[i].description ? data[i].description : ""
        let element = $(`
            <div class="button disable` + data[i].disabled + `" id=`+ i + `>
              <div class="header" id=`+ i + `>` + data[i].title + `</div>
              <div class="txt" id=`+ i + `>` + description + `</div>
            </div>`
        );
        $('#buttons').append(element);
        Buttons[i] = element
        Button[i] = data[i]
    }
};


$(document).click(function (event) {
    let $target = $(event.target);
    if ($target.closest('.button').length && $('.button').is(":visible")) {
        let id = event.target.id;
        if ((!Button[id].event && !Button[id].returnValue) || (Button[id].disabled)) return;
        PostData(id)
        document.getElementById('imageHover').style.display = 'none';
    }
})

const PostData = (id) => {
    $.post(`https://ucrp-weed/dataPost`, JSON.stringify({id: id}))
}

const CancelMenu = () => {
    $.post(`https://ucrp-weed/cancel`)
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const info = data.data
    const action = data.action
    switch (action) {
        case "OPEN_MENU":
            return OpenMenu(info);
        case "CLOSE_MENU":
            return CloseMenu();
        case "CANCEL_MENU":
            return CancelMenu();
        default:
            return;
    }
})

window.addEventListener("keyup", (ev) => {
    if (ev.which == 27) {
        CancelMenu();
        document.getElementById('imageHover').style.display = 'none';
    }
})

window.addEventListener('mousemove', (event) => {
    let $target = $(event.target);
    if ($target.closest('.button:hover').length && $('.button').is(":visible")) {
        let id = event.target.id;
        if (!Button[id]) return
        if (Button[id].image) {
            document.getElementById('image').src = Button[id].image;
            document.getElementById('imageHover').style.display = 'block';
        }
    }
    else {
        document.getElementById('imageHover').style.display = 'none';
    }
})
