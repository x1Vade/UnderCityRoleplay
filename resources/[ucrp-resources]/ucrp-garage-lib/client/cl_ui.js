const registered = [];

function RegisterUICallback(name, cb) {
    AddEventHandler(`_vui_uiReq:${name}`, cb);

    if (GetResourceState('ucrp-ui') === 'started') exports['ucrp-ui'].RegisterUIEvent(name);

    registered.push(name);
}

function SendUIMessage(data) {
    exports['ucrp-ui'].SendUIMessage(data);
}

function SetUIFocus(hasFocus, hasCursor) {
    exports['ucrp-ui'].SetUIFocus(hasFocus, hasCursor);
}

function GetUIFocus() {
    return exports['ucrp-ui'].GetUIFocus();
}

AddEventHandler('_vui_uiReady', () => {
    registered.forEach((eventName) => exports['ucrp-ui'].RegisterUIEvent(eventName));
});