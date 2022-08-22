
local purpleLap = false
local orangeLap = false

--- Blip shit ---
blip = nil

function AddOrangeBlip()
    blip = AddBlipForCoord(1401.37, -1490.43, 6)
    SetBlipSprite(blip, 306)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 47)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pickup Location")
    EndTextCommandSetBlipName(blip)
end

function AddPurpleBlip()
    blip = AddBlipForCoord(509.93, 3098.93, 6)
    SetBlipSprite(blip, 306)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pickup Location")
    EndTextCommandSetBlipName(blip)
end

--- Purple Tablet ---

RegisterNetEvent('ucrp-robberies:purpleQueue')
AddEventHandler('ucrp-robberies:purpleQueue', function()
    if exports["ucrp-inventory"]:hasEnoughOfItem("purpleusb", 1) then
        TriggerServerEvent('ucrp-robberies:purplelaptopSV')
    else
        TriggerEvent('DoLongHudText', "I don't give work out for free!", 2)
    end
end)

RegisterNetEvent('ucrp-robberies:getPTablet')
AddEventHandler('ucrp-robberies:getPTablet', function()
    Wait(3000)
    TriggerEvent('DoLongHudText', 'Please allow up to 2 hours while we get in contact with our dealer!', 1)
    Citizen.Wait(3.6e+6)
    purpleLap = true
    TriggerEvent('DoLongHudText', 'Head to the location we marked on your gps to pick up the tablet.', 1)
    AddPurpleBlip()
    SetNewWaypoint(509.93, 3098.93)
    Citizen.Wait(3000)
end)

RegisterNetEvent('ucrp-robberies:receivePTablet')
AddEventHandler('ucrp-robberies:receivePTablet', function()
    if purpleLap == true then 
        if exports["ucrp-inventory"]:hasEnoughOfItem("purpleusb", 1) then
            TriggerEvent('inventory:removeItem', 'purpleusb', 1)
            FreezeEntityPosition(PlayerPedId(),true)
            local finished = exports["ucrp-taskbar"]:taskBar(45000,"Waiting for a response...")
            TriggerServerEvent('ucrp-robberies:removeQueuePurple')
            TriggerEvent('player:receiveItem', 'purplelaptop', 1)
            FreezeEntityPosition(PlayerPedId(),false)
            purpleLap = false
            RemoveBlip(blip)
            blip = nil
        else
            TriggerEvent('DoLongHudText', 'You owe me something in return!', 2)
        end
    end
end)

RegisterNetEvent("ucrp-robberies:leavePurpleQueueClient")
AddEventHandler("ucrp-robberies:leavePurpleQueueClient", function()
    TriggerServerEvent("ucrp-robberies:leavePurpleQueueServer")
end)

--- Orange Tablet ---

RegisterNetEvent('ucrp-robberies:orangeQueue')
AddEventHandler('ucrp-robberies:orangeQueue', function()
    if exports["ucrp-inventory"]:hasEnoughOfItem("orangeusb", 1) then
        TriggerServerEvent('ucrp-robberies:orangelaptopSV')
    else
        TriggerEvent('DoLongHudText', 'You are going to need some tools to start working for us!', 2)
    end
end)

RegisterNetEvent('ucrp-robberies:getOTablet')
AddEventHandler('ucrp-robberies:getOTablet', function()
    Wait(3000)
    TriggerEvent('DoLongHudText', 'Please allow up to 2 hours while we get in contact with our dealer!', 1)
    Citizen.Wait(3.6e+6)
    orangeLap = true
    TriggerEvent('DoLongHudText', 'Head to the location we marked on your gps to pick up the tablet.', 1)
    AddOrangeBlip()
    SetNewWaypoint(1401.37, -1490.43)
    Citizen.Wait(3000)
end)

RegisterNetEvent('ucrp-robberies:receiveOTablet')
AddEventHandler('ucrp-robberies:receiveOTablet', function()
    if orangeLap == true then 
        if exports["ucrp-inventory"]:hasEnoughOfItem("orangeusb", 1) then
            TriggerEvent('inventory:removeItem', 'orangeusb', 1)
            FreezeEntityPosition(PlayerPedId(),true)
            local finished = exports["ucrp-taskbar"]:taskBar(45000,"Waiting for a response...") 
            TriggerServerEvent('ucrp-robberies:removeQueueOrange')
            TriggerEvent('player:receiveItem', 'orangelaptop', 1)
            FreezeEntityPosition(PlayerPedId(),false)
            orangeLap = false
            RemoveBlip(blip)
            blip = nil
        else
            TriggerEvent('DoLongHudText', 'You owe me something in return!', 2)
        end  
    end
end)

RegisterNetEvent("ucrp-robberies:leaveOrangeQueueClient")
AddEventHandler("ucrp-robberies:leaveOrangeQueueClient", function()
    TriggerServerEvent("ucrp-robberies:leaveOrangeQueueServer")
end)