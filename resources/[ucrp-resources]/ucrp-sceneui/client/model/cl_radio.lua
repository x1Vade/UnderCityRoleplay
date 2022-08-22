--[[RegisterNUICallback("ucrp-ui:hudUpdateRadioSettings", function(data, cb)
    exports["ucrp-base"]:getModule("SettingsData"):setSettingsTableGlobal({ ["tokovoip"] = data.settings }, true)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
end)

RegisterNUICallback("ucrp-ui:hudUpdateKeybindSettings", function(data, cb)
    exports["ucrp-base"]:getModule("DataControls"):encodeSetBindTable(data.controls)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
end)]]