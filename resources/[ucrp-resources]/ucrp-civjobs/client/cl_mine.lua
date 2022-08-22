
--// Start With Axe

RegisterNetEvent('ucrp-start-mining')
AddEventHandler('ucrp-start-mining', function()
    if DreamsMiningZone then
        TriggerEvent('ucrp-civjobs-mining')
    else
        TriggerEvent('DoLongHudText', 'You are not in the Mining Zone', 2)
    end
end)

local currentlyMining = false
local pFarmed = 0

RegisterNetEvent("ucrp-civjobs-mining")
AddEventHandler("ucrp-civjobs-mining", function()
	if exports["ucrp-inventory"]:hasEnoughOfItem("miningpickaxe",1,false) and not currentlyMining then 
        currentlyMining = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
            FreezeEntityPosition(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
            Citizen.Wait(200)
            local pickaxe = GetHashKey("prop_tool_pickaxe")
            
            -- Loads Pickaxe
            RequestModel(pickaxe)
            while not HasModelLoaded(pickaxe) do
            Wait(1)
            end
            
            local anim = "melee@hatchet@streamed_core_fps"
            local action = "plyr_front_takedown"
            
            -- Loads Anims
            RequestAnimDict(anim)
            while not HasAnimDictLoaded(anim) do
                Wait(1)
            end
            
            local object = CreateObject(pickaxe, coords.x, coords.y, coords.z, true, false, false)
            AttachEntityToEntity(object, playerPed, GetPedBoneIndex(playerPed, 57005), 0.1, 0.0, 0.0, -90.0, 25.0, 35.0, true, true, false, true, 1, true)
            TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
            local finished = exports ["ucrp-ui"]:taskBarSkill(18000,math.random(10,20))
            if (finished == 100) then
                local finished = exports ["ucrp-ui"]:taskBarSkill(18000,math.random(10,20))
                if (finished == 100) then
                    local finished = exports ["ucrp-ui"]:taskBarSkill(18000,math.random(10,20))
                    if (finished == 100) then
                        TriggerEvent('ucrp-civjobs:mines-items')
                        pFarmed = pFarmed + 1    
                    else
                        TriggerEvent("DoLongHudText", "Failed", 2)
                        currentlyMining = false
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(playerPed, false)
                        DeleteObject(object)
                    
                    end
                else
                    TriggerEvent("DoLongHudText", "Failed", 2)
                    currentlyMining = false
                    ClearPedTasks(PlayerPedId())
                    FreezeEntityPosition(playerPed, false)
                    DeleteObject(object)
                
                end        
            else
                TriggerEvent("DoLongHudText", "Failed", 2)
                currentlyMining = false
                ClearPedTasks(PlayerPedId())
                FreezeEntityPosition(playerPed, false)
                DeleteObject(object)
            
            end
            currentlyMining = false
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(playerPed, false)
            DeleteObject(object)
    else
		TriggerEvent('DoLongHudText', 'You need a pickaxe to mine', 2)
    end
end)

--// Events to get items

RegisterNetEvent('ucrp-civjobs:mines-items', function()
    local roll = math.random(8)
        if roll == 1 then
            TriggerEvent('player:receiveItem', 'mininggem', 1)
            TriggerEvent('DoLongHudText', 'You Found A Gemstone !', 1)
        elseif roll == 2 then
            TriggerEvent('player:receiveItem', 'miningstone', math.random(1, 3))
            TriggerEvent('DoLongHudText', 'You Found Stone', 1)
        elseif roll == 3 then
            TriggerEvent('player:receiveItem', 'miningcoal', math.random(1, 5))
            TriggerEvent('DoLongHudText', 'You Found Coal', 1)
        elseif roll == 4 then
            TriggerEvent('player:receiveItem', 'miningdiamond', 1)
            TriggerEvent('DoLongHudText', 'You Found A Diamond', 1)
        elseif roll == 5 then
            TriggerEvent('player:receiveItem', 'miningsapphire', 1)
            TriggerEvent('DoLongHudText', 'You found a Sapphire', 1)
        elseif roll == 6 then
            TriggerEvent('player:receiveItem', 'miningstone', math.random(1, 3))
            TriggerEvent('DoLongHudText', 'You Found Stone', 1)
        elseif roll == 7 then
            TriggerEvent('player:receiveItem', 'mininggem', 1)
            TriggerEvent('DoLongHudText', 'You Found A Gemstone', 1)
        elseif roll == 8 then
            TriggerEvent('player:receiveItem', 'miningruby', 1)
            TriggerEvent('DoLongHudText', 'You found a Ruby', 1)
        end
    end)

--// Polyzone

DreamsMiningZone = false

Citizen.CreateThread(function()
    exports["ucrp-polyzone"]:AddBoxZone("mining_zone", vector3(-592.1, 2075.5, 131.38), 25, 4, {
        name="mining_zone",
        heading=15,
        minZ=129.18,
        maxZ=133.18
    })
end)

RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    if name == "mining_zone" then
        DreamsMiningZone = true     
       -- print("^2[Blacklist Mining] In Zone^0")
        exports['ucrp-ui']:showInteraction("Start Mining")
    end
end)

RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name == "mining_zone" then
        DreamsMiningZone = false  
       -- print("^2[Blacklist Mining] Left Zone^0")  
        exports['ucrp-ui']:hideInteraction()
    end
end)

--// Peds

--[[function setMiningSalesPeds()
    modelHash = GetHashKey("s_m_y_construct_02")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    created_ped = CreatePed(0, modelHash , -1463.947265625, -182.22857666016, 48.82568359375  -1, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityHeading(created_ped, 34.015747070312)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
end

Citizen.CreateThread(function()
    setMiningSalesPeds()
end)]]

RegisterNetEvent('ucrp-jobs:miningsell:menu', function()
    TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 0,
            header = "Mine Sells",
            txt = "",
            params = {
                event = "",
            },
        },
        {
            id = 1,
            header = "Sell Mining Gems",
            txt = "Sell your Gem",
            params = {
                event = "ucrp-civjobs:sell-mininggem",
            },
        },
        {
            id = 2,
            header = "Sell Mining Stones",
            txt = "Sell your Stones",
            params = {
            event = "ucrp-civjobs:sell-stone",
            },
        },  
        {
            id = 3,
            header = "Sell Mining Coals",
            txt = "Sell your Coal",
            params = {
            event = "ucrp-civjobs:sell-coal",
            },
        },  
        {
            id = 4,
            header = "Sell Mining Diamonds",
            txt = "Sell your Diamond",
            params = {
            event = "ucrp-civjobs:sell-diamonds",
             },
        },  
        {
            id = 5,
            header = "Sell Mining Sapphires",
            txt = "Sell your Sapphire",
            params = {
            event = "ucrp-civjobs:sell-sapphire",
            },
        },  
        {
            id = 6,
            header = "Sell Mining Rubys",
            txt = "Sell your Ruby",
            params = {
            event = "ucrp-civjobs:sell-ruby",
            },
        },
        {
            id = 7,
            header = "Close menu",
			txt = "Exit From Garbage Job",
			params = {
                event = "",
            }
        },
    })
end)

--// Sell Mining Items

RegisterNetEvent('ucrp-civjobs:sell-mininggem')
AddEventHandler('ucrp-civjobs:sell-mininggem', function()
    if exports['ucrp-inventory']:hasEnoughOfItem('mininggem', 1) then
        TriggerEvent('inventory:removeItem', 'mininggem', 1)
        TriggerServerEvent('ucrp-civjobs:sell-gem-cash')
    else
        TriggerEvent('DoLongHudText', 'You do not have a Gem to sell !', 2)
    end
end)

RegisterNetEvent('ucrp-civjobs:sell-stone')
AddEventHandler('ucrp-civjobs:sell-stone', function()
    if exports['ucrp-inventory']:hasEnoughOfItem('miningstone', 1) then
        TriggerEvent('inventory:removeItem', 'miningstone', 1)
        TriggerServerEvent('ucrp-civjobs:sell-stone-cash')
    else
        TriggerEvent('DoLongHudText', 'You do not have any Stone to sell !', 2)
    end
end)

RegisterNetEvent('ucrp-civjobs:sell-coal')
AddEventHandler('ucrp-civjobs:sell-coal', function()
    if exports['ucrp-inventory']:hasEnoughOfItem('miningcoal', 1) then
        TriggerEvent('inventory:removeItem', 'miningcoal', 1)
        TriggerServerEvent('ucrp-civjobs:sell-coal-cash')
    else
        TriggerEvent('DoLongHudText', 'You do not have any Coal to sell', 2)
    end
end)

RegisterNetEvent('ucrp-civjobs:sell-diamonds')
AddEventHandler('ucrp-civjobs:sell-diamonds', function()
    if exports['ucrp-inventory']:hasEnoughOfItem('miningdiamond', 1) then
        TriggerEvent('inventory:removeItem', 'miningdiamond', 1)
        TriggerServerEvent('ucrp-civjobs:sell-diamond-cash')
    else
        TriggerEvent('DoLongHudText', 'You do not have any Diamonds to sell', 2)
    end
end)

RegisterNetEvent('ucrp-civjobs:sell-sapphire')
AddEventHandler('ucrp-civjobs:sell-sapphire', function()
    if exports['ucrp-inventory']:hasEnoughOfItem('miningsapphire', 1) then
        TriggerEvent('inventory:removeItem', 'miningsapphire', 1)
        TriggerServerEvent('ucrp-civjobs:sell-sapphire-cash')
    else
        TriggerEvent('DoLongHudText', 'You do not have any Sapphire to sell', 2)
    end
end)

RegisterNetEvent('ucrp-civjobs:sell-ruby')
AddEventHandler('ucrp-civjobs:sell-ruby', function()
    if exports['ucrp-inventory']:hasEnoughOfItem('miningruby', 1) then
        TriggerEvent('inventory:removeItem', 'miningruby', 1)
        TriggerServerEvent('ucrp-civjobs:sell-ruby-cash')
    else
        TriggerEvent('DoLongHudText', 'You do not have any Ruby to sell', 2)
    end
end)