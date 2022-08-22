NPX.Core.hasLoaded = false


function NPX.Core.Initialize(self)
    Citizen.CreateThread(function()
        while true do
            if NetworkIsSessionStarted() then
                TriggerEvent("ucrp-base:playerSessionStarted")
                TriggerServerEvent("ucrp-base:playerSessionStarted")
                break
            end
        end
    end)
end
NPX.Core:Initialize()

AddEventHandler("ucrp-base:playerSessionStarted", function()
    while not NPX.Core.hasLoaded do
        --print("waiting in loop")
        Wait(100)
    end
    ShutdownLoadingScreen()
    NPX.SpawnManager:Initialize()
end)

RegisterNetEvent("ucrp-base:waitForExports")
AddEventHandler("ucrp-base:waitForExports", function()
    if not NPX.Core.ExportsReady then return end

    while true do
        Citizen.Wait(0)
        if exports and exports["ucrp-base"] then
            TriggerEvent("ucrp-base:exportsReady")
            return
        end
    end
end)

RegisterNetEvent("customNotification")
AddEventHandler("customNotification", function(msg, length, type)

	TriggerEvent("chatMessage","SYSTEM",4,msg)
end)

RegisterNetEvent("base:disableLoading")
AddEventHandler("base:disableLoading", function()
    print("player has spawned ")
    if not NPX.Core.hasLoaded then
         NPX.Core.hasLoaded = true
    end
end)

Citizen.CreateThread( function()
    TriggerEvent("base:disableLoading")
end)
