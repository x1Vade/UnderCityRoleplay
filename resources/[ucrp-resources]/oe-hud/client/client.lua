local sesduzey = 1
local ping
local pausemenu = false
local dogalgaz, db, wind, ampul, dollar, yuzme, gym = false, 0, 0, 0, 0, 0, 0
local health2, armor2, oxy2, hunger2, thirst2 = false, false, false, false, false
local dev, parachute, debug, radio, armed = false, false, false, false, false
local cruise = 0
local harness = 0
local nitro = 0

-- local

local lastValues = {}
Fuel = 0
local currentValues = {
    ["hunger"] = 100,
	["thirst"] = 100,
	["armor"] = 100,
    ["stress"] = 100,
    ["voice"] = 2,
	["devmode"] = false,
	["devparachute"] = false,
	["devdebug"] = false,
	["is_talking"] = false
}

local pStress = 0

local setStressOnOff = true

Citizen.CreateThread(function()
    voice = 2
    while true do 
        Citizen.Wait(500)
        local player = PlayerPedId()
        local health,oxy = math.floor(GetEntityHealth(player) - 100)
        local nuke, gps, gpu = 0, 0, 0
        local weapon = GetSelectedPedWeapon(player)
        local get_ped = PlayerPedId()
        currentValues["armor"] = GetPedArmour(get_ped)

        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
            nitro = tonumber(0)
        end

        if pStress < 0 then 
            pStress = 0
        end

        if pStress > 100 then 
            pStress = 100
        end

        if currentValues["hunger"] < 0 then
            currentValues["hunger"] = 0
        end
        if currentValues["thirst"] < 0 then
            currentValues["thirst"] = 0
        end

        if currentValues["hunger"] > 100 then currentValues["hunger"] = 100 end

        if currentValues["thirst"] > 100 then currentValues["thirst"] = 100 end

        if weapon ~= `WEAPON_UNARMED` then armed = true else armed = false end
        
        TriggerServerEvent("hud-getping:sv") if IsPedSwimmingUnderWater(player) then oxy = math.ceil(GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10) if oxy < 1 then oxy = 1 end else oxy = false end if IsPauseMenuActive() then pausemenu = true SendNUIMessage({ action = 'show', show = false, }) elseif not IsPauseMenuActive() and pausemenu then SendNUIMessage({action = 'show', show = true, }) pausemenu = false end

        SendNUIMessage({
            action = "update",
            health = health,
            armor = lerp(0, 100, rangePercent(0, 60, currentValues["armor"])),
            hunger = currentValues["hunger"],
            thirst = currentValues["thirst"],
            oxy = oxy,
            dogalgaz = dogalgaz,
            stress = pStress,
            db = db,
            wind = wind,
            ping = ping,
            ampul = ampul,
            dollar = dollar,
            yuzme = yuzme,
            gym = gym,
            harness = harness,
            nitro = nitro,
            nitron = hasbottle,
            cruise = cruise,
            nuke = nuke,
            gps = gps,
            gpu = gpu,
            nos = nos,
            dev = dev,
            debug = debug,
            parachute = parachute,
            armed = armed,
            mic = voice,
            radio = pRadio,
            dev = developer,
            dev2 = debug,

            health2 = health2,
            armor2 = armor2,
            hunger2 = hunger2,
            thirst2 = thirst2,
            oxy2 = oxy2
        })
    end
end)

---------------------STRESS

local radioPush = false

RegisterNetEvent("police:setClientMeta")
AddEventHandler("police:setClientMeta",function(meta)
	if meta == nil then return end
	if meta.thirst == nil then currentValues["thirst"] = 100 else currentValues["thirst"] = meta.thirst end
	if meta.hunger == nil then currentValues["hunger"] = 100 else currentValues["hunger"] = meta.hunger end
	if meta.health == nil then
		return
	end

	if meta.health < 10.0 then
		SetEntityHealth(PlayerPedId(),10.0)
	else
		SetEntityHealth(PlayerPedId(),meta.health)
	end

	
	SetPlayerMaxArmour(PlayerPedId(), 60 )
	SetPedArmour(PlayerPedId(),meta.armour)
end)

RegisterNetEvent('hud:saveCurrentMeta')
AddEventHandler('hud:saveCurrentMeta', function()
	TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"],currentValues["armor"])
end)


local stressDisabled = false
RegisterNetEvent("client:disableStress")
AddEventHandler("client:disableStress",function(stressNew)
	stressDisabled = stressNew
end)

RegisterNetEvent("stress:timed2")
AddEventHandler("stress:timed2",function(alteredValue,scenario)
	local removedStress = 0
	Wait(1000)

	TriggerEvent("DoShortHudText",'Stress is being relieved',6)
	SetPlayerMaxArmour(PlayerId(), 60)
	while true do
		removedStress = removedStress + 100
		if removedStress >= alteredValue then
			break
		end
        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+3)
		if scenario ~= "None" then
			if not IsPedUsingScenario(PlayerPedId(),scenario) then
				TriggerEvent("animation:cancel")
				break
			end
		end
		Citizen.Wait(1000)
	end
	TriggerServerEvent("server:alterStress",false,removedStress)
end)

RegisterNetEvent("client:updateStress")
AddEventHandler("client:updateStress",function(newStress)
    pStress = newStress
end)

Citizen.CreateThread(function()
    while true do
        local waitTime = 75000
        if not isBlocked then
            if pStress> 100 then
                waitTime = 5000
            elseif pStress > 75 then
                waitTime = 15000
            elseif pStress > 50 then
                waitTime = 30000
            end
            if pStress > 25 then
              TriggerScreenblurFadeIn(1000.0)
              Wait(1100)
              TriggerScreenblurFadeOut(1000.0)
            end
        end 
        Citizen.Wait(waitTime)
    end
end)


-- RegisterCommand('xxx', function(status, amount)
--     TriggerEvent("client:newStress",true,10)
-- print("Stress Give")
-- end)

-- RegisterCommand('xx', function(status, amount)
--     TriggerEvent("client:newStress",false,10)
-- print("STRESS Take")
-- end)


RegisterNetEvent("client:newStress")
AddEventHandler("client:newStress", function(status, amount)
    print("??")
    if status == true then
        pStress = pStress + amount
        TriggerEvent("DoShortHudText",'Stress Gained',6)
        Wait(1000)
        TriggerServerEvent('ucrp-hud:UpdateStress_SV', pStress)
    elseif status == false then
        pStress = pStress - amount
        TriggerEvent("DoShortHudText",'Stress Relieved',6)
        Wait(1000)
        TriggerServerEvent('ucrp-hud:UpdateStress_SV', pStress)
    end
end)


---------------------------------stress

-----------HUNGER AND THIRST


Citizen.CreateThread(function()
    while true do
    	if currentValues["hunger"] > 0 then
    		currentValues["hunger"] = currentValues["hunger"] - math.random(3)
    	end
	    if currentValues["thirst"] > 0 then
    		currentValues["thirst"] = currentValues["thirst"] - 3
    	end	

		Citizen.Wait(300000)
    	TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"])
		
		if currentValues["thirst"] < 20 or currentValues["hunger"] < 20 then
			local newhealth = GetEntityHealth(PlayerPedId()) - math.random(10)
			SetEntityHealth(PlayerPedId(), newhealth)
		end
	end
end)

RegisterNetEvent('ucrp-hud:ChangeThirst')
AddEventHandler('ucrp-hud:ChangeThirst', function(amount)
		currentValues["thirst"] = currentValues["thirst"] + amount

		if currentValues["thirst"] < 0 then
			currentValues["thirst"] = 0
		end

		if currentValues["thirst"] > 100 then
			currentValues["thirst"] = 100
	end
end)

RegisterNetEvent('ucrp-hud:ChangeHunger')
AddEventHandler('ucrp-hud:ChangeHunger', function(amount)
		currentValues["hunger"] = currentValues["hunger"] + amount

		if currentValues["hunger"] < 0 then
			currentValues["hunger"] = 0
		end

		if currentValues["hunger"] > 100 then
			currentValues["hunger"] = 100
	end
end)


currentValues["hunger"] = 100
currentValues["thirst"] = 100

hunger = "Full"
thirst = "Sustained"

-----------------HUNGER AND THIRST


----------------------------NOS STUFF


-- RegisterNetEvent('noshud')
-- AddEventHandler('noshud', function(newlevel,noson,bottle)
-- 	level = newlevel
-- 	nitro = noson
-- 	nitron = bottle
-- end)



RegisterNetEvent('oe-hud:nitro:check')
AddEventHandler('oe-hud:nitro:check', function(totalNos)
    local plate = GetVehicleNumberPlateText(vehicle)
    local vehicle = GetVehiclePedIsIn(player)
    local player = GetPlayerPed()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        totalNos = totalNos
        nitro = tonumber(totalNos)
        if totalNos < 1 then
            nitro = tonumber(0)
        end
        if vehicle == false then
            nitro = tonumber(0)
        end
    end
end)

--[[ RegisterCommand("nos", function()
    nitro = tonumber(100)
end)
     ]]


     RegisterNetEvent("ucrp-hud:changeRange")
     AddEventHandler("ucrp-hud:changeRange", function(pRange)
         voice = pRange or 2
     end)
     
     AddEventHandler("hud:voice:transmitting", function (talking)
         SendNUIMessage({type = "transmittingStatus", is_transmitting = transmitting})
     end)


Citizen.CreateThread(function ()
	while true do
		local isTalking = NetworkIsPlayerTalking(PlayerId())
        local pRadioActive = exports['ucrp-voice']:pRadioActive()
        SendNUIMessage({
            action = "voiceupdate", 
            talking = NetworkIsPlayerTalking(PlayerId()) and not pRadioActive,
            radioPush = pRadioActive,
        })
		Citizen.Wait(250)
	end
end)


-- functs

function OpenMenu() SetNuiFocus(true, true) SendNUIMessage({action = "open"})end

RegisterNUICallback('close', function(data, cb) SetNuiFocus(false, false) end)

RegisterNetEvent("hud-getping:cl") AddEventHandler("hud-getping:cl", function(ping1) ping = tonumber(ping1) end)

function enhancements(name, value)
    if name == "db" then
        db = tonumber(value)
        print(db)
    elseif name == "wind" then
        wind = tonumber(value)
    elseif name == "ampul" then
        ampul = tonumber(value)
    elseif name == "dollar" then
        dollar = tonumber(value)
    elseif name == "yuzme" then
        yuzme = tonumber(value)
    elseif name == "gym" then
        gym = tonumber(value)

    ----
    elseif name == "dev" then 
        dev = not dev
    elseif name == "debug" then 
        debug = not debug
    ----
    elseif name == "parachute" then 
        parachute = not parachute
    ----
    elseif name == "health" then
        health2 = value
    elseif name == "armor" then
        armor2 = value
    elseif name == "hunger" then
        hunger2 = value
    elseif name == "thirst" then
        thirst2 = value
    elseif name == "oxy" then
        oxy2 = value
    end
    
end

RegisterNetEvent("harnesshud", function(condition)
    harnesshud(condition)
--[[     print("condition selection") ]]
end)

function harnesshud(condition)
    durability = 100
    TriggerServerEvent("vehicleMod:createHarness", durability)
    while condition == true do
        durability = durability - 0.02
        print(durability)
        harness = tonumber(durability)
        
        Citizen.Wait(1000)
        TriggerServerEvent("vehicleMod:updateHarness", durability)
        if durability == 0 then
            harness = tonumber(0)
--[[             print("Value 0") ]]
            TriggerServerEvent("vehicleMod:updateHarness", durability)
            break
        end
    end
    if condition == false then
        harness = tonumber(durability)
        durability = 0
    end
end


RegisterCommand("radio1", function()
    radio = not radio
end)

RegisterNetEvent("oe-hud:cruise")
AddEventHandler("oe-hud:cruise", function(value)
    cruise = value
end)


--- CARHUD ---

local area = ""
local street = ""
local dist = 0
local barV = true
local sleep = 50
local osurcam = 50
local carhudfps = 500

function bar(value)
    barV = value
end

RegisterNUICallback("compass", function(data)
    sleep = data.fps 
    osurcam = data.fps
    print(sleep)
end)

RegisterNUICallback("carhud", function(data)
    carhudfps = data.fps 
    TriggerEvent("alahiyedik", data.fps)
end)

Citizen.CreateThread(function()
    while true do

        local player = PlayerPedId()
        local s = GetVehiclePedIsIn(player, false)

        if s == 0 then
            sleep = 2500
            inVehicle = false

            SendNUIMessage({
                action = "carhud",
                show = false
            })

            DisplayRadar(0)
        else
            sleep = osurcam
            local hour = GetClockHours()
            if hour < 10 then 
                hour = "0" .. hour
            end
            local minute = GetClockMinutes()
            if minute < 10 then 
                minute = "0" .. minute
            end
            local time = hour .. ":" .. minute

            inVehicle = true
            roundedRadar()
            if IsWaypointActive() then
                dist = (#(GetEntityCoords(PlayerPedId()) - GetBlipCoords(GetFirstBlipInfoId(8))) / 1000) * 0.715 -- quick conversion maff
            else
                dist = 0
            end
            gets()

            SetRadarZoom(1200)
            roundedRadar()

            if not IsPauseMenuActive() then 
                SendNUIMessage({
                    action = "carhud",
                    show = true,
                    bar5 = barV,
                    direction = math.floor(calcHeading(-GetEntityHeading(player) % 360)),
                    area = area,
                    street = street,
                    mil = dist,
                    time = time
                })
            else
                SendNUIMessage({
                    action = "carhud",
                    show = false
                })
            end
        end

        Citizen.Wait(sleep)
    end
end)

function gets()
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z, currentStreetHash, intersectStreetHash)
    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    zone = tostring(GetNameOfZone(playerCoords))
    area = GetLabelText(zone)

    if area == "Fort Zancudo" then
        area = "Williamsburg"
    end

    if intersectStreetName ~= nil and intersectStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. " [" .. intersectStreetName .. "]"
    elseif currentStreetName ~= nil and currentStreetName ~= "" then
        playerStreetsLocation = currentStreetName
    else
        playerStreetsLocation = ""
    end
    
    street = playerStreetsLocation
end

local imageWidth = 100 -- leave this variable, related to pixel size of the directions
local containerWidth = 100 -- width of the image container

-- local width =  (imageWidth / containerWidth) * 100; -- used to convert image width if changed

local width =  0;
local south = (-imageWidth) + width
local west = (-imageWidth * 2) + width
local north = (-imageWidth * 3) + width
local east = (-imageWidth * 4) + width
local south2 = (-imageWidth * 5) + width

function calcHeading(direction)
    if (direction < 90) then
        return lerp(north, east, direction / 90)
    elseif (direction < 180) then
        return lerp(east, south2, rangePercent(90, 180, direction))
    elseif (direction < 270) then
        return lerp(south, west, rangePercent(180, 270, direction))
    elseif (direction <= 360) then
        return lerp(west, north, rangePercent(270, 360, direction))
    end
end

function rangePercent(min, max, amt)
    return (((amt - min) * 100) / (max - min)) / 100
end

function lerp(min, max, amt)
   return (1 - amt) * min + amt * max
end


---- OVALMAP -----

local minimapEnabled = true
local inVehicle = false
local forceShowMinimap = false
local appliedTextureChange = false
local useDefaultMinimap = false
local sa = false

RegisterNUICallback("minimap", function(data)
    if data.action == "close" then
        minimapEnabled = false
        bar(false)

        SendNUIMessage({
            action = "squremap",
            value = true
        })
        roundedRadar()
    elseif data.action == "open" then
        minimapEnabled = true
        DisplayRadar(1)
        bar(true)
        SendNUIMessage({
            action = "squremap",
            value = false
        })
        roundedRadar()
    elseif data.action == "default" then
        useDefaultMinimap = true
        roundedRadar()

        Wait(500)
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)

        TriggerEvent("carhud:getmap", "default")
    elseif data.action == "ovalmap" then
        useDefaultMinimap = false
        roundedRadar()

        Wait(500)
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)
        TriggerEvent("carhud:getmap", "ovalmap")
    elseif data.action == "outline-close" then
        DisplayRadar(1)
        bar(false)
        SendNUIMessage({
            action = "squremap",
            value = false
        })
    elseif data.action == "outline-open" then
        DisplayRadar(1)
        bar(true)
        SendNUIMessage({
            action = "squremap",
            value = true
        })        
    end
end)

RegisterCommand("saas", function()
    useDefaultMinimap = not useDefaultMinimap
    Wait(500)
    DisplayRadar(0)
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)
    DisplayRadar(1)
end)

Citizen.CreateThread(function()
    while true do
        sleep = 2500
        local player = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(player, false)
        local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
        if IsPedInAnyVehicle(player, false) and vehicleIsOn then
            sleep = 1500
            inVehicle = true
            SendNUIMessage({mapoutline = true})
            roundedRadar()
            if sa == false then 
                sa = true 
                DisplayRadar(0)
                SetRadarBigmapEnabled(true, false)
                Citizen.Wait(0)
                SetRadarBigmapEnabled(false, false)
                DisplayRadar(1)
            end
        else
            sleep = 2500
            inVehicle = false
            SendNUIMessage({mapoutline = false})
            roundedRadar()
            sa = false
        end

        if useDefaultMinimap then
            SetRadarZoom(1000) -- 1200
        else
            SetRadarZoom(1200) -- 1200
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetBigmapActive(true, false)
    SetBigmapActive(false, false)
    while true do 
        Citizen.Wait(0)
        BeginScaleformMovieMethod(minimap, "HIDE_SATNAV")
        EndScaleformMovieMethod()
    end
end)

posX = -0.030
posY = 0.0-- 0.0152

width = 0.170
height = 0.28--0.354

function roundedRadar()
    if minimapEnabled == false then
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
    end
    Citizen.CreateThread(function()
        if not appliedTextureChange and not useDefaultMinimap then
          RequestStreamedTextureDict("circlemap", false)
          while not HasStreamedTextureDictLoaded("circlemap") do
              Citizen.Wait(0)
          end
          AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasklg")
          AddReplaceTexture("platform:/textures/graphics", "radarmasklg", "circlemap", "radarmasklg")
          appliedTextureChange = true
          bar(true)
          SendNUIMessage({
            action = "squremap",
            value = false
          })
        elseif appliedTextureChange and useDefaultMinimap then
          appliedTextureChange = false
          RemoveReplaceTexture("platform:/textures/graphics", "radarmasksm")
          RemoveReplaceTexture("platform:/textures/graphics", "radarmasklg")
          bar(false)

            SendNUIMessage({
                action = "squremap",
                value = true
            })
        end

        SetBlipAlpha(GetNorthRadarBlip(), 0.0)

        local screenX, screenY = GetScreenResolution()
        local modifier = screenY / screenX

        local baseXOffset = 0.0046875
        local baseYOffset = 0.74

        local baseSize    = 0.20 -- 20% of screen

        local baseXWidth  = 0.1313 -- baseSize * modifier -- %
        local baseYHeight = baseSize -- %

        local baseXNumber = screenX * baseSize  -- 256
        local baseYNumber = screenY * baseSize  -- 144

        local radiusX     = baseXNumber / 2     -- 128
        local radiusY     = baseYNumber / 2     -- 72

        local innerSquareSideSizeX = math.sqrt(radiusX * radiusX * 2) -- 181.0193
        local innerSquareSideSizeY = math.sqrt(radiusY * radiusY * 2) -- 101.8233

        local innerSizeX = ((innerSquareSideSizeX / screenX) - 0.01) * modifier
        local innerSizeY = innerSquareSideSizeY / screenY

        local innerOffsetX = (baseXWidth - innerSizeX) / 2
        local innerOffsetY = (baseYHeight - innerSizeY) / 2

        local innerMaskOffsetPercentX = (innerSquareSideSizeX / baseXNumber) * modifier

        local function setPos(type, posX, posY, sizeX, sizeY)
            SetMinimapComponentPosition(type, "I", "I", posX, posY, sizeX, sizeY)
        end
        if not useDefaultMinimap then
        --   setPos("minimap",       baseXOffset - (0.025 * modifier), baseYOffset - 0.025, baseXWidth + (0.05 * modifier), baseYHeight + 0.05)
        --   setPos("minimap_blur",  baseXOffset, baseYOffset, baseXWidth + 0.001, baseYHeight)
          -- setPos("minimap_mask",  baseXOffset + innerOffsetX, baseYOffset + innerOffsetY, innerSizeX, innerSizeY)
          -- The next one is FUCKING WEIRD.
          -- posX is based off top left 0.0 coords of minimap - 0.00 -> 1.00
          -- posY seems to be based off of the top of the minimap, with 0.75 representing 0% and 1.75 representing 100%
          -- sizeX is based off the size of the minimap - 0.00 -> 0.10
          -- sizeY seems to be height based on minimap size, ranging from -0.25 to 0.25
        --   setPos("minimap_mask", 0.1, 0.95, 0.09, 0.15)
          -- setPos("minimap_mask", 0.0, 0.75, 1.0, 1.0)
          -- setPos("minimap_mask",  baseXOffset, baseYOffset, baseXWidth, baseYHeight)

          AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
          AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
          SetMinimapClipType(1)

          -- -0.0100 = nav symbol and icons left 
          -- 0.180 = nav symbol and icons stretched
          -- 0.258 = nav symbol and icons raised up

          SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY, width, height)
          SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.14, 0.14, 0.1, 0.1)

          SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.016, 0.015, 0.216, 0.290)
          
        else
          local function setPosLB(type, posX, posY, sizeX, sizeY)
              SetMinimapComponentPosition(type, "L", "B", posX, posY, sizeX, sizeY)
          end
          local offsetX = -0.018
          local offsetY = 0.025

          local defaultX = -0.0045
          local defaultY = 0.002

          local maskDiffX = 0.020 - defaultX
          local maskDiffY = 0.032 - defaultY
          local blurDiffX = -0.03 - defaultX
          local blurDiffY = 0.022 - defaultY

          local defaultMaskDiffX = 0.0245
          local defaultMaskDiffY = 0.03

          local defaultBlurDiffX = 0.0255
          local defaultBlurDiffY = 0.02

          setPosLB("minimap",       -0.0045,  -0.0245,  0.150, 0.18888)
          setPosLB("minimap_mask",  0.020,    0.022,  0.111, 0.159)
          setPosLB("minimap_blur",  -0.03,    0.002,  0.266, 0.237)

          bar(false)
        end
        if not useDefaultMinimap then
          SetMinimapClipType(1)
        else
          SetMinimapClipType(0)
        end
    end)
end

Citizen.CreateThread(function()
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)
end)

-- Parachute tingz
-- RegisterNetEvent("parachute:icon:enabled", function()
--     ped = PlayerPedId()
--     Citizen.Wait(100)
--     parachuteEnabled = true
--     parachuteOnBack = false
--     if parachuteEnabled == true then
--         enhancements("parachute") 
--         print("Parachute On")
--         Citizen.CreateThread(function()
--             if GetPedParachuteState(player) == 0 then
--                 Citizen.Wait(100)
--                 Print("parachute on back")
--                 parachuteOnBack = true
--                 if (GetPedParachuteLandingType(player) == 0 or 1 or 2 or 3) then 
--                     enhancements("parachute") 
--                     print("Parachute remove")
--                     parachuteEnabled = false
--                     parachuteOnBack = false
--                 end
--             else
--                 print("parachute not on back")
--                 return
--             end
--         end)
--     end
-- end)

RegisterNetEvent("parachute:icon:enabled", function()
    Citizen.CreateThread(function()
        player = PlayerPedId()
        enhancements("parachute") 
        -- print("Parachute On")
        while true do 
            if exports['ragdoll']:GetDeathStatus() then
                enhancements("parachute") 
            elseif GetPedParachuteState(player) == 2 then
                Citizen.Wait(100)
                if not GetPedParachuteLandingType(player) == 0 or 1 or 2 or 3 then
                    enhancements("parachute") 
                    -- print("Parachute remove")
                    break
                else
                    -- print("not landed yet")
                end
            else
                -- print("penis")
            end
        end
    end)
end)
