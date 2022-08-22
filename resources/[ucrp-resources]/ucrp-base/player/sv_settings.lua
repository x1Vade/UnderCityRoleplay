RegisterServerEvent("ucrp-base:sv:player_settings_set")
AddEventHandler("ucrp-base:sv:player_settings_set", function(settingsTable)
    local src = source
    NPX.DB:UpdateSettings(src, settingsTable, function(UpdateSettings, err)
            if UpdateSettings then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("ucrp-base:sv:player_settings")
AddEventHandler("ucrp-base:sv:player_settings", function()
    local src = source
    NPX.DB:GetSettings(src, function(loadedSettings, err)
        if loadedSettings ~= nil then 
            TriggerClientEvent("ucrp-base:cl:player_settings", src, loadedSettings) 
        else 
            TriggerClientEvent("ucrp-base:cl:player_settings",src, nil) 
        end
    end)
end)
