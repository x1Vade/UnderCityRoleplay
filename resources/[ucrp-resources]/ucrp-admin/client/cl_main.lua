LoggedIn = false
 

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    RefreshMenu('All')
    LoggedIn = true
end)
  
AddEventHandler('onResourceStop', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        LoggedIn = false
    end
end)
  

function openadminfunction()
    TriggerServerEvent('ucrp-admin/server/open-menu')
end
Citizen.CreateThread(function()
    exports["ucrp-keybinds"]:registerKeyMapping("", "adminmenu", "Open Admin Menu", "+openadminfunction", "-openadminfunction")
    RegisterCommand('+openadminfunction', openadminfunction, false)
    RegisterCommand('-openadminfunction', function() end, false)
end)

RegisterKeyMapping('ucrp-admin-AttemptOpen', 'Open Admin Menu', 'keyboard', 'INSERT')

RegisterCommand('noclip', function()
    TriggerEvent('ucrp-admin:NoClipBind')
  end)

RegisterKeyMapping('ucrp-admin:NoClipBind', '(Admin) Noclip', "NONE", "NONE")

-- [ Code ] --

-- [ Mapping ] --

-- [ Events ] --

RegisterNetEvent('ucrp-admin-AttemptOpen', function(OnPress)
    local Players = GetPlayers()
    SetCursorLocation(0.5, 0.5)
    SetNuiFocus(true, true)
    SendNUIMessage({
        Action = 'Open',
        Debug = Config.MenuDebug,
        AllPlayers = Players,
        AdminItems = Config.AdminMenus,
        Favorited = Config.FavoritedItems,
        PinnedPlayers = Config.PinnedTargets,
        MenuSettings = Config.AdminSettings
    })
end)

RegisterNetEvent('ucrp-admin/client/force-close', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        Action = 'Close',
    })
end)

-- [ NUI Callbacks ] --

RegisterNUICallback('Admin/ToggleFavorite', function(Data, Cb)
    Config.FavoritedItems[Data.Id] = Data.Toggle
    SetKvp("ucrp-adminmenu-favorites", json.encode(Config.FavoritedItems), "Favorites")
    Cb('Ok')
end)

RegisterNUICallback('Admin/TogglePinnedTarget', function(Data, Cb)
    Config.PinnedTargets[Data.Id] = Data.Toggle
    SetKvp("ucrp-adminmenu-pinned_targets", json.encode(Config.PinnedTargets), "Targets")
    Cb('Ok')
end)

RegisterNUICallback('Admin/ToggleSetting', function(Data, Cb)
    Config.AdminSettings[Data.Id] = Data.Toggle
    SetKvp("ucrp-adminmenu-settings", json.encode(Config.AdminSettings), "Settings")
    Cb('Ok')
end)

RegisterNUICallback('Admin/GetCharData', function(Data, Cb)
    RPC.execute('ucrp-admin/server/get-player-data', function(PlayerData)
        Cb(PlayerData)
    end, Data.License)
end)

RegisterNUICallback("Admin/Close", function(Data, Cb)
   SetNuiFocus(false, false)
   Cb('Ok')
end)

RegisterNUICallback("Admin/DevMode", function(Data, Cb)
    local Bool = Data.Toggle
    ToggleDevMode(Bool)
    Cb('Ok')
end)

RegisterNUICallback('Admin/TriggerAction', function(Data, Cb) 
    -- print(json.encode(Data, Cb))
    if IsPlayerAdmin() then
        if Data.EventType == nil then Data.EventType = 'Client' end
        if Data.Event ~= nil and Data.EventType ~= nil then
            if Data.EventType == 'Client' then
                TriggerEvent(Data.Event, Data.Result)
            else
                TriggerServerEvent(Data.Event, Data.Result)
            end
        end
    end
    Cb('Ok')
end)