local offroadVehicles = {
    "bifta",
    "blazer",
    "brawler",
    "dubsta3",
    "dune",
    "rebel2",
    "sandking",
    "trophytruck",
    "sanchez",
    "sanchez2",
    "blazer",
    "enduro",
    "pol9",
    "police3", -- police SUV
    "sheriff2", -- sheriff SUV
    "hwaycar", -- trooper suv
    "fbi2",
    "bf400"
}

local offroadbikes = {
    "ENDURO",
    "sanchez",
    "sanchez2"
}

local carsEnabled = {}
local airtime = 0
local offroadTimer = 0
local airtimeCoords = GetEntityCoords(PlayerPedId())
local heightPeak = 0
local lasthighPeak = 0
local highestPoint = 0
local zDownForce = 0
local veloc = GetEntityVelocity(GetVehiclePedIsIn(PlayerPedId()), false)
local offroadVehicle = false

local playerPed = nil
local currentVehicle = nil
local driverPed = nil
local harness = false
local harnessDurability = 0.0
local disableControl = false
local nosCar = nil
local nosTimeInSeconds = 5
local stalled = false
DecorRegister("vehicleHarnessDur", 1) -- who knows if this works :)

local NosVehicles = {}
local nosMods = {}
local nosForce = 0.0
local seatbelt = false
local disablenos = false
local exhausts = {
    "exhaust"
}
for i=2, 30 do
    exhausts[#exhausts+1] = "exhaust_"..i
end

function downgrade(veh,power,offroad)
    local vehModel = GetEntityModel(veh)
    if carsEnabled["" .. veh .. ""] == nil then
        return
    end
    if offroad then
        power = power + 0.5
        if IsThisModelABike(vehModel) then
            power = power + 0.3
        else
            power = power + 0.3
        end

    end
    power = math.ceil(power * 10)

    local factor = math.random( 3+power ) / 10


    if factor > 0.7 then
        if IsThisModelABike(vehModel) then
            if not offroad then
                factor = 0.7
            end
        else
            if not offroad then
                factor = 0.7
            else
                factor = 0.8
            end

        end
    end

    if factor < 0.4 then
        if not offroad then
            factor = 0.25
        else
            factor = 0.4
        end
    end

    if carsEnabled["" .. veh .. ""] == nil then return end
    local carData = carsEnabled["" .. veh .. ""]
    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel', carData["fInitialDriveMaxFlatVel"] * factor)
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock', carsEnabled["" .. veh .. ""]["fSteeringLock"] * factor)
    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult', carData["fTractionLossMult"] * factor)
    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', carData["fLowSpeedTractionLossMult"] * factor)
    -- SetVehicleEnginePowerMultiplier(veh,factor)
    -- SetVehicleEngineTorqueMultiplier(veh,factor)
    TriggerEvent("tuner:setDriver")
end

function resetdowngrade(veh)
    if carsEnabled["" .. veh .. ""] == nil then
        return
    end
    local carData = carsEnabled["" .. veh .. ""]
    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel', carData["fInitialDriveMaxFlatVel"])
    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock', carData["fSteeringLock"])
    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult', carData["fTractionLossMult"])
    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', carData["fLowSpeedTractionLossMult"])
    -- SetVehicleEnginePowerMultiplier(veh,0.7)
    -- SetVehicleEngineTorqueMultiplier(veh,0.7)

end

function ejectionLUL()
    local veh = GetVehiclePedIsIn(playerPed,false)
    local coords = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, 1.0)
    SetEntityCoords(playerPed, coords)
    Citizen.Wait(1)
    SetPedToRagdoll(playerPed, 5511, 5511, 0, 0, 0, 0)
    SetEntityVelocity(playerPed, veloc.x*4,veloc.y*4,veloc.z*4)
    local ejectspeed = math.ceil(GetEntitySpeed(playerPed) * 8)
    if IsPedWearingHelmet(playerPed) and IsThisModelABicycle(GetEntityModel(veh)) then
        -- Players on bicycles wearing helmets shouldn't die from the ejection itself. Instead, set HP to 1.
        -- Player will only die if further native damage occurs post ejection, more than the armour can protect.
        local damageAmount = GetEntityHealth(playerPed) - 1
        if damageAmount > ejectspeed then
            damageAmount = ejectspeed
        end
        SetEntityHealth(playerPed, GetEntityHealth(playerPed) - damageAmount)
        return
    end
    SetEntityHealth(playerPed, (GetEntityHealth(playerPed) - ejectspeed) )
   -- TriggerEvent("randomBoneDamage")
end

function preventVehicleExit()
    Citizen.CreateThread(function()
        local options = {1000,2000,3000}
        disableControl = true
        disableTurning()
        local finished = exports["ucrp-taskbar"]:taskBar(options[math.random(1,3)],"Taking off Harness",true)
        if finished == 100 then
            harness = false
            TriggerEvent("harness", false, 0.1)
            TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
            TriggerEvent("DoShortHudText",'Harness Disabled',4)
        end
        disableControl = false
    end)
end

function disableTurning()
    local tempVeh = currentVehicle
    if carsEnabled["" .. tempVeh .. ""] ~= nil then
        local defaultHandling = carsEnabled["" .. tempVeh .. ""]["fSteeringLock"]
        Citizen.CreateThread(function()
            while disableControl do
                -- SetVehicleHandlingFloat(tempVeh, 'CHandlingData', 'fSteeringLock', defaultHandling / 4)
                Citizen.Wait(10)
                -- DisableControlAction(0, 59, 1)
            end
            -- SetVehicleHandlingFloat(tempVeh, 'CHandlingData', 'fSteeringLock', defaultHandling)
        end)
    end
end

function carCrash()
    -- endNos()
    local new_health = GetVehicleEngineHealth(currentVehicle) - math.random(200, 300)
    TriggerEvent('DoLongHudText', 'Your vehicle has stalled!', 2)
    SetVehicleEngineOn(currentVehicle, false, true, true)
    SetVehicleEngineHealth(currentVehicle, new_health)
    SetVehicleUndriveable(veh, true)
    lastCurrentVehicleSpeed = 0.0
    lastCurrentVehicleBodyHealth = new_health
end

function tiresBurst()
    local wheels = {0,1,4,5}
    for i=1, math.random(4) do
        local wheel = math.random(#wheels)
        SetVehicleTyreBurst(currentVehicle, wheels[wheel], false, 1000)
        table.remove(wheels, wheel)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if stalled then
            Citizen.Wait(math.random(3500, 4500))
            SetVehicleEngineOn(currentVehicle, true, true, true)
            stalled = false
        end
    end
end)

-- function nosInit()
--     nosCar = GetVehiclePedIsIn(playerPed, false)
--     if nosCar ~= 0 and nosCar ~= false and nosCar ~= nil then
--         Citizen.CreateThread(function()
--             startNos()
--             sendServerEventForPassengers("NetworkNos")

--             local curSpeed = GetEntitySpeed(nosCar)
--             local modifier = (1.0 / (curSpeed / 5)) * 0.81
--             SetVehicleForwardSpeed(nosCar, curSpeed + modifier) --Forward Speed

--             if nosForce == 0.0 then
--                 local fInitialDriveForce = GetVehicleHandlingFloat(nosCar, 'CHandlingData', 'fInitialDriveForce')
--                 nosForce = fInitialDriveForce
--             end
--             local burst = math.ceil( (nosForce + nosForce * 1.15) * 100000 ) / 100000
--             if GetEntitySpeed(nosCar) > 70 then
--                 burst = math.ceil( (nosForce + nosForce * 0.85) * 100000 ) / 100000
--             end

--             if NosVehicles[currentVehicle] == 0 then
--                 TriggerEvent("vehicleMod:nosoff")
--             end
            
--             if burst > 0 then
--                 local fInitialDriveForce = GetVehicleHandlingFloat(nosCar, 'CHandlingData', 'fInitialDriveForce')
--                 if burst >= fInitialDriveForce then
--                     if nosMods[nosCar] ~= nil and burst > nosMods[nosCar] then
--                         burst = nosMods[nosCar]
--                     else
--                         nosMods[nosCar] = burst
--                     end
--                     SetVehicleHandlingField(nosCar, 'CHandlingData', 'fInitialDriveForce', burst)
--                 end
--             end
--             nosParticles()
--         end)
--     end
-- end

-- function nosParticles()
--      -- TODO: Fix for all exhaust
--     local scale = 1.0
--     local count = 500
--     local particleDict = "veh_xs_vehicle_mods"
--     local particleCar = GetVehiclePedIsIn(playerPed, false)
--     RequestNamedPtfxAsset(particleDict)
--     while not HasNamedPtfxAssetLoaded(particleDict) do
--         Citizen.Wait(0)
--     end
--     UseParticleFxAssetNextCall(particleDict)

--     local particles = {}

--     function removeParticles()
--         Citizen.CreateThread(function()
--             for i,v in pairs(particles) do
--                 RemoveParticleFx(v)
--             end
--             Citizen.Wait(2000)
--             for i,v in pairs(particles) do
--                 RemoveParticleFx(v)
--                 particles[i] = nil
--             end
--         end)
--     end

--     if particleCar ~= 0 and particleCar ~= false and particleCar ~= nil then
--         local pitch = GetEntityPitch(particleCar)
--         local carPos = GetEntityCoords(particleCar, false)

--         for i,v in pairs(exhausts) do
--             local bone = GetEntityBoneIndexByName(particleCar, v)
--             if bone ~= -1 then
--                 local offset = GetWorldPositionOfEntityBone(particleCar, bone)
--                 UseParticleFxAsset(particleDict)
--                 particles[#particles+1] = StartNetworkedParticleFxLoopedOnEntityBone("veh_nitrous", particleCar, 0.0,0.0,0.0 , 0.0, pitch, 0.0, bone, 1.0, false, false, false)
--             end
--         end

--         Citizen.Wait(1000)

--         for i,v in pairs(exhausts) do
--             local bone = GetEntityBoneIndexByName(particleCar, v)
--             if bone ~= -1 then
--                 local offset = GetWorldPositionOfEntityBone(particleCar, bone)
--                 UseParticleFxAsset(particleDict)
--                 particles[#particles+1] = StartNetworkedParticleFxLoopedOnEntityBone("veh_nitrous", particleCar, 0.0,0.0,0.0 , 0.0, pitch, 0.0, bone, 1.0, false, false, false)
--             end
--         end
--     end

--     Citizen.SetTimeout(1000 * nosTimeInSeconds, function()
--         removeParticles()
--         endNos()
--     end)
-- end

-- function startNos(veh)
--     disablenos = true
--     if nosCar ~= 0 and nosCar ~= false and nosCar ~= nil then
--         SetVehicleBoostActive(nosCar, 1) --Boost Sound
--     elseif veh ~= nil then
--         SetVehicleBoostActive(veh, 1)
--     end

--     Citizen.CreateThread(function()
--         local active = true

--         Citizen.SetTimeout(1000 * math.ceil(nosTimeInSeconds / 3), function()
--             active = false
--         end)

--         while active do
--             Citizen.Wait(0)
--             -- StartScreenEffect("RaceTurbo", 30.0, 0)
--             -- StartScreenEffect("ExplosionJosh3", 30.0, 0)
--         end

--         -- StartScreenEffect("RaceTurbo", 0, 0)
--         -- StartScreenEffect("ExplosionJosh3", 0, 0)
--         if nosCar ~= 0 and nosCar ~= false and nosCar ~= nil then
--             SetVehicleBoostActive(nosCar, 0)
--         end
--     end)
-- end

-- function endNos()
--     if not disablenos then
--         return
--     end

--     if nosCar ~= 0 and nosCar ~= false and nosCar ~= nil then
--         TriggerEvent("noshud", NosVehicles[nosCar], false)
--         SetVehicleHandlingField(nosCar, 'CHandlingData', 'fInitialDriveForce', nosForce)
--     end

--     nosForce = 0.0
--     disablenos = false
-- end

function sendServerEventForPassengers(event, value)
    local player = PlayerPedId()
    for i=-1, GetVehicleMaxNumberOfPassengers(currentVehicle)-1 do
        local ped = GetPedInVehicleSeat(currentVehicle, i)
        if ped ~= player and ped ~= 0 then
            TriggerServerEvent(event, GetPlayerServerId(v), value)
        end
    end
end


function toggleHarness()
    disableControl = true
    disableTurning()
    local finished = 0
    if harness then
        finished = exports["ucrp-taskbar"]:taskBar(5000,"Taking off Harness",true) 
--[[         Citizen.Wait(5000)
        TriggerEvent("harnesshud", false) ]]
    else
        finished = exports["ucrp-taskbar"]:taskBar(5000,"Putting on Harness",true)
    end
    if (finished == 100) then
        if playerPed == driverPed then
            if not harness then
                TriggerEvent("harnesshud", true)
                print("harnesshud true") 
                TriggerEvent("harness", true, harnessDurability)
                TriggerEvent("seatbelt",true)
                TriggerEvent("InteractSound_CL:PlayOnOne","seatbelt",0.1)
                TriggerEvent("DoShortHudText",'Harness Enabled',4)                         
            else
                TriggerEvent("harnesshud", false)    
                print("harnesshud false")    
                TriggerEvent("harness", false, 0.1)
                TriggerEvent("seatbelt",false)
                TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
                TriggerEvent("DoShortHudText",'Harness Disabled',4)                            
            end
            harness = not harness
            seatbelt = false
        else
            -- Player switched while putting it on ...
            harnessDurability = 0.0
            TriggerEvent("harnesshud", false)  
            TriggerEvent("harness", false, 0.1)
            TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
            TriggerEvent("DoShortHudText",'Harness Disabled',4)   
            harness = false
            seatbelt = false
        end
    end
    disableControl = false
end

--[[ function toggleSeatbelt()
    if seatbelt == false then
        TriggerEvent("seatbelt",true)
        TriggerEvent("InteractSound_CL:PlayOnOne","seatbelt",0.1)
       -- TriggerEvent("DoShortHudText",'Seat Belt Enabled',4)
        TriggerEvent("harness", false, 0.0)
        
    else
        TriggerEvent("seatbelt",false)
        TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
       -- TriggerEvent("DoShortHudText",'Seat Belt Disabled',4)
        TriggerEvent("harness", true, 0.1)
    end
    seatbelt = not seatbelt
end ]]

RegisterNetEvent('NosStatus')
AddEventHandler('NosStatus', function()
    if not IsToggleModOn(currentVehicle,18) then
        TriggerEvent('DoLongHudText', 'Need a Turbo for Nos!', 2)
        return
    end

    if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
        if driverPed == playerPed then
            NosVehicles[currentVehicle] = 100
        end
    end
end)

RegisterNetEvent('NetworkNos')
AddEventHandler('NetworkNos', function()
    startNos(GetVehiclePedIsIn(playerPed,false))
end)


RegisterNetEvent("carhud:ejection:client")
AddEventHandler("carhud:ejection:client",function(value)
    veloc = value
    if seatbelt then
        if math.random(10) > 8 then
            ejectionLUL()
        end
    else
        if math.random(10) > 4 then
            ejectionLUL()
        end
    end
end)

RegisterNetEvent('event:control:vehicleMod')
AddEventHandler('event:control:vehicleMod', function(useID)
    if IsPedInAnyVehicle(playerPed) and not IsThisModelABike(GetEntityModel(currentVehicle)) then
        if harnessDurability > 0.0 then
            toggleHarness()
        elseif harnessDurability <= 0.0 and harness then
            TriggerEvent("harness", false, harnessDurability)
            TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
            TriggerEvent("DoShortHudText",'Harness Disabled',4)               
            harness = false
        else
--[[             toggleSeatbelt() ]]
        end
    end
end)

RegisterNetEvent("vehicleMod:setHarness")
AddEventHandler("vehicleMod:setHarness",function(result, isNew)
    if result then -- player owned car
        if tonumber(result) >= 0.0 then
            harnessDurability = tonumber(result)
        else
            harnessDurability = 0.0
        end
    else -- local car or fake plates
        if DecorExistOn(currentVehicle, "vehicleHarnessDur") and not isNew then
            harnessDurability = DecorGetFloat(currentVehicle, "vehicleHarnessDur")
        elseif isNew then
            DecorSetFloat(currentVehicle, "vehicleHarnessDur", 1.0)
            harnessDurability = 1.0
        else
            harnessDurability = 0.0
        end
    end
    if currentVehicle ~= 0 and currentVehicle ~= nil and currentVehicle ~= false then
        if driverPed == playerPed then
            TriggerEvent("harness", true, 0.1)
        else
            harness = false
            harnessDurability = 0.0
            TriggerEvent("harness", false, 0.0)
        end
    end
end)

RegisterNetEvent("vehicleMod:useHarnessItem")
AddEventHandler("vehicleMod:useHarnessItem",function()
    TriggerServerEvent("vehicleMod:applyHarness", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)), 1.0)
end)

RegisterNetEvent("vehicleMod:endnos")
AddEventHandler("vehicleMod:endnos",function()
    endNos()
end)

RegisterNetEvent("vehicleMod:resetDowngrade")
AddEventHandler("vehicleMod:resetDowngrade",function(targetvehicle)
    resetdowngrade(targetvehicle)
end)

RegisterNetEvent("client:illegal:upgrades")
AddEventHandler("client:illegal:upgrades",function(Extractors,Filter,Suspension,Rollbars,Bored,Carbon)
    if (IsPedInAnyVehicle(playerPed, false)) then
        local veh = GetVehiclePedIsIn(playerPed,false)
        if Extractors == 1 then

            local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
            fInitialDriveForce = fInitialDriveForce + fInitialDriveForce * 0.1
            SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
        end


        if Filter == 1 then

            local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
            fInitialDriveForce = fInitialDriveForce + fInitialDriveForce * 0.1
            SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
        end

        if Suspension == 1 then

            local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
            fBrakeForce = fBrakeForce + fBrakeForce * 0.3
            SetVehicleHandlingField(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

            local fSteeringLock = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock')
            fSteeringLock = fSteeringLock + fSteeringLock * 0.2
            SetVehicleHandlingField(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)

        end

        if Rollbars == 1 then

            local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
            fBrakeForce = fBrakeForce + fBrakeForce * 0.1
            SetVehicleHandlingField(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

            local fSteeringLock = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock')
            fSteeringLock = fSteeringLock + fSteeringLock * 0.2
            SetVehicleHandlingField(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)

        end

        if Bored == 1 then

            local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
            fInitialDriveForce = fInitialDriveForce + fInitialDriveForce * 0.05
            SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
        end

        if Carbon == 1 then


            local fMass = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fMass')
            fMass = fMass - fMass * 0.3
            SetVehicleHandlingField(veh, 'CHandlingData', 'fMass', fMass)

            local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
            fInitialDriveForce = fInitialDriveForce + fInitialDriveForce * 0.1

        end
    end
end)


Citizen.CreateThread(function()
    local firstDrop = GetEntityVelocity(PlayerPedId())
    local lastentSpeed = 0
    while true do
        Citizen.Wait(1)

        if (IsPedInAnyVehicle(PlayerPedId(), false)) then

            local veh = GetVehiclePedIsIn(PlayerPedId(),false)
            if not invehicle and not IsThisModelABike(GetEntityModel(veh)) then
                invehicle = true
                TriggerEvent("InteractSound_CL:PlayOnOne","beltalarm",0.35)
            end

            local bicycle = IsThisModelABicycle( GetEntityModel(veh) )

            if carsEnabled["" .. veh .. ""] == nil and not bicycle then
                SetVehiclePetrolTankHealth(veh, 4000.0)

                SetVehicleHandlingFloat(veh, 'CHandlingData', 'fWeaponDamageMult', 3.500000)

                local fSteeringLock = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock')

                fSteeringLock = math.ceil((fSteeringLock * 0.6)) + 0.1
                -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)
                -- SetVehicleHandlingField(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)

                local fInitialDriveMaxFlatVel = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel')
                if IsThisModelABike(GetEntityModel(veh)) then

                    local fTractionCurveMin = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMin')

                    fTractionCurveMin = fTractionCurveMin * 0.6
                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMin', fTractionCurveMin)
                    -- SetVehicleHandlingField(veh, 'CHandlingData', 'fTractionCurveMin', fTractionCurveMin)

                    local fTractionCurveMax = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMax')

                    fTractionCurveMax = fTractionCurveMax * 0.6
                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMax', fTractionCurveMax)
                    -- SetVehicleHandlingField(veh, 'CHandlingData', 'fTractionCurveMax', fTractionCurveMax)



                    local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
                    fInitialDriveForce = fInitialDriveForce * 2.2
                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)

                    local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
                    fBrakeForce = fBrakeForce * 1.4
                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSuspensionReboundDamp', 5.000000)
                    -- SetVehicleHandlingField(veh, 'CHandlingData', 'fSuspensionReboundDamp', 5.000000)

                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSuspensionCompDamp', 5.000000)
                    -- SetVehicleHandlingField(veh, 'CHandlingData', 'fSuspensionCompDamp', 5.000000)

                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSuspensionForce', 22.000000)
                    -- SetVehicleHandlingField(veh, 'CHandlingData', 'fSuspensionForce', 22.000000)

                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fCollisionDamageMult', 2.500000)
                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fEngineDamageMult', 0.120000)
                else

                    local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
                    fBrakeForce = fBrakeForce * 0.5
                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

                    local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
                    if fInitialDriveForce < 0.289 then
                        fInitialDriveForce = fInitialDriveForce * 1.05
                        -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
                    else
                        fInitialDriveForce = fInitialDriveForce * 0.8
                        -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
                    end
                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fEngineDamageMult', 0.100000)
                    -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fCollisionDamageMult', 2.900000)

                end

                -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDeformationDamageMult', 1.000000)

                SetVehicleHasBeenOwnedByPlayer(veh,true)
                carsEnabled["" .. veh .. ""] = {
                    ["fInitialDriveMaxFlatVel"] = fInitialDriveMaxFlatVel,
                    ["fSteeringLock"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock'),
                    ["fTractionLossMult"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult'),
                    ["fLowSpeedTractionLossMult"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult')
                }
                local plt = GetVehicleNumberPlateText(veh)
                TriggerServerEvent("request:illegal:upgrades",plt)
            else
                Wait(1000)
            end


            if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then

                local coords = GetEntityCoords(PlayerPedId())
                local roadtest2 = IsPointOnRoad(coords.x, coords.y, coords.z, veh)
              --  roadtest, endResult, outHeading = GetClosestVehicleNode(coords.x, coords.y, coords.z,  1, 0, -1)
             --   endDistance = #(vector3(endResult.x, endResult.y, endResult.z) - GetEntityCoords(PlayerPedId()))
                local myspeed = GetEntitySpeed(veh) * 3.6
                local xRot = GetEntityUprightValue(veh)
                if not roadtest2 then
                    if (xRot < 0.90) then
                        offroadTimer = offroadTimer + (1 - xRot)
                    elseif xRot > 0.90 then
                        if offroadTimer < 1 then
                            offroadTimer = 0
                        else
                            offroadTimer = offroadTimer - xRot
                            resetdowngrade(veh)
                        end
                    end
                elseif offroadTimer > 0 or offroadTimer == 0 then
                    offroadTimer = 0
                    offroadVehicle = false
                    resetdowngrade(veh)
                end

                if offroadTimer > 5 and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then

                    for i = 1, #offroadVehicles do
                        if IsVehicleModel( GetVehiclePedIsUsing(PlayerPedId()), GetHashKey(offroadVehicles[i]) ) then
                            offroadVehicle = true

                        end
                    end

                    if not offroadVehicle then
                        if IsThisModelABike(GetEntityModel(veh)) then
                            downgrade(veh,0.12 - xRot / 10,offroadVehicle)
                        else
                            downgrade(veh,0.20 - xRot / 10,offroadVehicle)
                        end

                    else
                        downgrade(veh,0.35 - xRot / 10,offroadVehicle)
                    end
                end

                if IsEntityInAir(veh) then
                    firstDrop = GetEntityVelocity(veh)
                    lastentSpeed = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())))
                    if airtime == 1 then
                        heightPeak = 0
                        lasthighPeak = 0
                        airtimeCoords = GetEntityCoords(veh)
                        lasthighPeak = airtimeCoords.z
                    else
                        local AirCurCoords = GetEntityCoords(veh)
                        heightPeak = AirCurCoords.z
                        if tonumber(heightPeak) > tonumber(lasthighPeak) and airtime ~= 0 then
                            lasthighPeak = heightPeak
                            highestPoint = heightPeak - airtimeCoords.z
                        end
                    end
                    airtime = airtime + 1
                elseif airtime > 0 then

                    if airtime > 110 then
                        Citizen.Wait(333)
                        local landingCoords = GetEntityCoords(veh)
                        local landingfactor = landingCoords.z - airtimeCoords.z
                        local momentum = GetEntityVelocity(veh)
                        highestPoint = highestPoint - landingfactor

                        highestPoint = highestPoint * 0.55

                        airtime = math.ceil(airtime * highestPoint)

                        local xdf = 0
                        local ydf = 0
                        if momentum.x < 0 then
                            xdf = momentum.x
                            xdf = math.ceil(xdf - (xdf * 2))
                        else
                            xdf = momentum.x
                        end

                        if momentum.y < 0 then
                            ydf = momentum.y
                            ydf = math.ceil(ydf - (ydf * 2))
                        else
                            ydf = momentum.y
                        end



                        zdf = momentum.z
                        lastzvel = firstDrop.z

                        zdf = zdf - lastzvel
                        local dirtBike = false
                        for i = 1, #offroadbikes do
                            if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()), GetHashKey(offroadbikes[i], _r)) then
                                dirtBike = true
                            end
                        end
                        if dirtBike then
                            airtime = airtime - 200
                        end

                        if IsThisModelABicycle(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) then
                            local ohshit = math.ceil((zdf * 200))
                            local entSpeed = math.ceil( GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 1.35 )

                            if airtime > 550 then
                                if airtime > 550 and ohshit > airtime and ( entSpeed < lastentSpeed or entSpeed < 2.0 ) then
                                    ejectionLUL()
                                    tiresBurst()
                                elseif airtime > 1500 and entSpeed < lastentSpeed then
                                    ejectionLUL()
                                    tiresBurst()
                                else
                                end
                            end

                        elseif airtime > 950 and IsThisModelABike(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) then
                            local ohshit = math.ceil((zdf * 200))
                            local entSpeed = math.ceil( GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 1.15 )

                            if airtime > 950 then
                                if airtime > 950 and ohshit > airtime and ( entSpeed < lastentSpeed or entSpeed < 2.0 ) then
                                    ejectionLUL()
                                    tiresBurst()
                                elseif airtime > 2500 and entSpeed < lastentSpeed then
                                    ejectionLUL()
                                    tiresBurst()
                                else
                                end
                            end

                        end
                    end
                    airtimeCoords = GetEntityCoords(PlayerPedId())
                    heightPeak = 0
                    airtime = 0
                    lasthighPeak = 0
                    zDownForce = 0
                end

                --GetVehicleClass(vehicle)
                local ped = PlayerPedId()
                local roll = GetEntityRoll(veh)

                -- if IsEntityInAir(veh) and not IsThisModelABike(GetEntityModel(veh)) then
                --     DisableControlAction(0, 59)
                --     DisableControlAction(0, 60)
                -- end
                -- if ((roll > 75.0 or roll < -75.0) or not IsVehicleEngineOn(veh)) and not IsThisModelABike(GetEntityModel(veh)) then
                --     DisableControlAction(2,59,true)
                --     DisableControlAction(2,60,true)
                -- end
            else
                Wait(1000)
            end
        else
            if invehicle or seatbelt then
                if seatbelt then
                    TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
                end
                invehicle = false
                seatbelt = false
                TriggerEvent("seatbelt",false)
            end
            Citizen.Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if seatbelt then
            DisableControlAction(0, 75)
        end
    end
end)

-- CurrentVehicle and DriverPed Updater --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        playerPed = PlayerPedId()
        local tempVehicle = GetVehiclePedIsIn(playerPed, false)
        local tempDriver = GetPedInVehicleSeat(tempVehicle, -1)
        if tempVehicle ~= currentVehicle then
            harness = false
            seatbelt = false
            currentVehicle = tempVehicle
            if currentVehicle == nil or currentVehicle == 0 or currentVehicle == false then
                TriggerEvent("DensityModifierEnable", true)
            else
                driverPed = GetPedInVehicleSeat(currentVehicle, -1)
                if driverPed == playerPed then
                    TriggerEvent("DensityModifierEnable", true)
                    TriggerEvent("noshud", NosVehicles[currentVehicle], false)
                    TriggerEvent("tuner:setDriver")
                else
                    TriggerEvent("DensityModifierEnable", false)
                end
                TriggerServerEvent("vehicleMod:getHarness", GetVehicleNumberPlateText(currentVehicle))
            end
        elseif (tempDriver ~= driverPed and tempDriver ~= 0) or (tempDriver == 0 and driverPed == playerPed) then
            driverPed = tempDriver
            if driverPed == playerPed then
                -- Switched seat to driver
                if seatbelt then
                    return
                end
                TriggerEvent("DensityModifierEnable", true)
                TriggerEvent("noshud", NosVehicles[currentVehicle], false)
                TriggerServerEvent("vehicleMod:getHarness", GetVehicleNumberPlateText(currentVehicle))
                TriggerEvent("tuner:setDriver")
            else
                if harness then
                    toggleHarness()
                elseif seatbelt then
                    return
                else
                    TriggerServerEvent("vehicleMod:getHarness", GetVehicleNumberPlateText(currentVehicle))
                end

                TriggerEvent("DensityModifierEnable", false)
                TriggerEvent("noshud", 0, false)
            end

            TriggerEvent("seatbelt",false)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2)
        if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
            if harness then
                DisableControlAction(1, 75, true)
                if IsDisabledControlJustPressed(1, 75) then
                    preventVehicleExit()
                end
            -- elseif IsControlJustPressed(1, 75) then
            --     endNos()
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(5000)
        end
    end
end)

-- Collision Thread --
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local lastCurrentVehicleBodyHealth = 0
    local lastCurrentVehicleSpeed = 0

    local function eject(percent, speed, trigger)
        if math.random(math.ceil(speed)) > percent then
            ejectionLUL()
            if trigger then
          --      TriggerEvent("civilian:alertPolice",50.0,"carcrash",0)
            end
        end
    end

    while true do
        Citizen.Wait(1)
        if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
            SetPedHelmet(playerPed, false)
            if driverPed == playerPed then
                local currentEngineHealth = GetVehicleEngineHealth(currentVehicle)
                if currentEngineHealth < 0.0 then
                    -- Dont blow up
                    SetVehicleEngineHealth(currentVehicle,0.0)
                end

                vehicle = GetVehiclePedIsIn(ped, false)
                local roll = GetEntityRoll(vehicle)
                if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
	                DisableControlAction(2,59,true) -- Disable left/right
	                DisableControlAction(2,60,true) -- Disable up/down
                end

                local collision = HasEntityCollidedWithAnything(currentVehicle)
                if collision == false then
                    lastCurrentVehicleSpeed = GetEntitySpeed(currentVehicle)
                    lastCurrentVehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
                    veloc = GetEntityVelocity(currentVehicle)
                    if currentEngineHealth > 10.0 and (currentEngineHealth < 175.0 or lastCurrentVehicleBodyHealth < 50.0) then
                        carCrash()
                        stalled = true
                        Citizen.Wait(1000)
                    end
                else
                    Citizen.Wait(100)
                    local currentVehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
                    local currentVehicleSpeed = GetEntitySpeed(currentVehicle)
                    if currentEngineHealth > 0.0 and lastCurrentVehicleBodyHealth - currentVehicleBodyHealth > 15 then
                        if lastCurrentVehicleSpeed > 35.5 and currentVehicleSpeed < (lastCurrentVehicleSpeed * 0.75) then
                            if not IsThisModelABike(GetEntityModel(currentVehicle)) then
                                carCrash()
                                stalled = true
                                sendServerEventForPassengers("carhud:ejection:server", veloc)
                                if harness and lastCurrentVehicleSpeed > 45.6 then
                                    local roll = math.random(40)
                                    if roll == 15 then                                                                                                  
                                        TriggerServerEvent("vehicleMod:breakHarness", GetVehicleNumberPlateText(currentVehicle))
                                        TriggerEvent("harness", false, 0)
                                        TriggerEvent("seatbelt",false)
                                        harness = false
                                        TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
                                        TriggerEvent('DoLongHudText', 'Harness Broken!', 2)
                                        eject(30.5, lastCurrentVehicleSpeed, true)                                 
                                    end
                                elseif not seatbelt then
                                    eject(30.5, lastCurrentVehicleSpeed, true)
                                elseif seatbelt and lastCurrentVehicleSpeed > 45.6 then
                                    eject(33.0, lastCurrentVehicleSpeed, true)
                                end
                                -- Buffer after crash
                                Citizen.Wait(1000)
                                lastCurrentVehicleSpeed = 0.0
                                lastCurrentVehicleBodyHealth = currentVehicleBodyHealth
                            else
                                -- IsBike
                                carCrash()
                                stalled = true
                                Citizen.Wait(1000)
                                lastCurrentVehicleSpeed = 0.0
                                lastCurrentVehicleBodyHealth = currentVehicleBodyHealth
                            end
                        end
                    else
                        if currentEngineHealth > 10.0 and (currentEngineHealth < 195.0 or currentVehicleBodyHealth < 50.0) then
                            carCrash()
                            stalled = true
                            Citizen.Wait(1000)
                        end
                        lastCurrentVehicleSpeed = currentVehicleSpeed
                        lastCurrentVehicleBodyHealth = currentVehicleBodyHealth
                    end
                end
            else
                -- Not driver
                Citizen.Wait(1000)
            end
        else
            -- Not in veh
            currentVehicleSpeed = 0
            lastCurrentVehicleSpeed = 0
            lastCurrentVehicleBodyHealth = 0
            Citizen.Wait(4000)
        end
    end
end)

-- NOS Thread --
Citizen.CreateThread(function()
    -- Handle NOS
    while true do
        Citizen.Wait(5000)
        if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 and driverPed == playerPed then
            if NosVehicles[currentVehicle] == nil then
                NosVehicles[currentVehicle] = 0
            end
            local vehModel = GetEntityModel(currentVehicle)
            if IsControlPressed(1,209) and NosVehicles[currentVehicle] ~= nil then
                if not IsThisModelAHeli(vehModel) and not IsThisModelABoat(vehModel) and not IsThisModelABike(vehModel) and IsVehicleOnAllWheels(currentVehicle) and IsVehicleEngineOn(currentVehicle) then
                    print('here')
                    if GetEntitySpeed(currentVehicle) > 12.5 and NosVehicles[currentVehicle] > 0 then
                        if GetEntitySpeed(currentVehicle) > 113.0 then -- 250mph
                            SetVehicleEngineHealth(currentVehicle, 0.0)
                            SetVehicleEngineOn(currentVehicle, false, true, true)
                        elseif not disablenos then
                            nosInit()
                            TriggerEvent("noshud", NosVehicles[currentVehicle], true)
                            NosVehicles[currentVehicle] = NosVehicles[currentVehicle] - 5
                        end
                    end
                end
            end
            if NosVehicles[currentVehicle] == 95 then
                TriggerEvent("vehicleMod:nos95")
            elseif NosVehicles[currentVehicle] == 90 then
                TriggerEvent("vehicleMod:nos90")
            elseif NosVehicles[currentVehicle] == 85 then
                TriggerEvent("vehicleMod:nos85")
            elseif NosVehicles[currentVehicle] == 80 then
                TriggerEvent("vehicleMod:nos80")
            elseif NosVehicles[currentVehicle] == 75 then
                TriggerEvent("vehicleMod:nos75")
            elseif NosVehicles[currentVehicle] == 70 then
                TriggerEvent("vehicleMod:nos70")
            elseif NosVehicles[currentVehicle] == 65 then
                TriggerEvent("vehicleMod:nos65")
            elseif NosVehicles[currentVehicle] == 60 then
                TriggerEvent("vehicleMod:nos60")
            elseif NosVehicles[currentVehicle] == 55 then
                TriggerEvent("vehicleMod:nos55")
            elseif NosVehicles[currentVehicle] == 50 then
                TriggerEvent("vehicleMod:nos50")
            elseif NosVehicles[currentVehicle] == 45 then
                TriggerEvent("vehicleMod:nos45")
            elseif NosVehicles[currentVehicle] == 40 then
                TriggerEvent("vehicleMod:nos40")
            elseif NosVehicles[currentVehicle] == 35 then
                TriggerEvent("vehicleMod:nos35")
            elseif NosVehicles[currentVehicle] == 30 then
                TriggerEvent("vehicleMod:nos30")
            elseif NosVehicles[currentVehicle] == 25 then
                TriggerEvent("vehicleMod:nos25")
            elseif NosVehicles[currentVehicle] == 20 then
                TriggerEvent("vehicleMod:nos20")
            elseif NosVehicles[currentVehicle] == 15 then
                TriggerEvent("vehicleMod:nos15")
            elseif NosVehicles[currentVehicle] == 10 then
                TriggerEvent("vehicleMod:nos10")
            elseif NosVehicles[currentVehicle] == 5 then
                TriggerEvent("vehicleMod:nos5")
            end

        else
            Citizen.Wait(5000)
        end
    end
end)



function getVehicleInDirection()

	playerped = PlayerPedId()
    coordFrom = GetEntityCoords(playerped, 1)
    coordTo = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)

	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end


    local LastVehicle = nil
    local LicencePlate = {}
    LicencePlate.Index = false
    LicencePlate.Number = false

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end






-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         local veh = GetVehiclePedIsIn(PlayerPedId(), false)
--         if DoesEntityExist(veh) and not IsEntityDead(veh) then
--             local model = GetEntityModel(veh)
--             -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
--             if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABike(model) and not IsThisModelABicycle(model) and IsEntityInAir(veh) then
--                 DisableControlAction(0, 59) -- leaning left/right
--                 DisableControlAction(0, 60) -- leaning up/down
--             end
--         end
--     end
-- end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local get_ped = PlayerPedId() -- current ped
        local get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
        if get_ped_veh ~= 0 then
            local model = GetEntityModel(get_ped_veh)
            local roll = GetEntityRoll(get_ped_veh)
  
            if not IsThisModelABoat(model)
                and not IsThisModelAHeli(model)
                and not IsThisModelAPlane(model)
                and not IsThisModelABicycle(model)
                and not IsThisModelABike(model)
                and not IsThisModelAJetski(model)
                and not IsThisModelAQuadbike(model)
                and (IsEntityInAir(get_ped_veh) or (roll < -50 or roll > 50)) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end
        end
    end
end)

function HarnessDur(currentVehicle)
   return DecorGetFloat(currentVehicle, "vehicleHarnessDur")
end

exports('HarnessDur', HarnessDur)

-- Animations
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end



RegisterNetEvent('fakeplate:accepted')
AddEventHandler('fakeplate:accepted', function(newplate,isStolen,oldplate)

	local playerped = PlayerPedId()
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	local plate = GetVehicleNumberPlateText(targetVehicle)
	if targetVehicle ~= nil  and targetVehicle ~= 0 then
		TriggerEvent("inventory:removeItem","fakeplate", 1)
		if isStolen then
			TriggerEvent("keys:checkandgive",newplate,oldplate)
			TriggerEvent("customNotification","This vehicle is now running with stolen plates")

		else
			TriggerEvent("customNotification","This vehicle now has its default plate")

		end
		TriggerEvent("vehicleMod:resetDowngrade", targetVehicle)
		SetVehicleNumberPlateText(targetVehicle, newplate)
	end
end)

RegisterNetEvent('fakeplate:change')
AddEventHandler('fakeplate:change', function()
	local playerped = PlayerPedId()
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	local plate = GetVehicleNumberPlateText(targetVehicle)
	if targetVehicle ~= nil  and targetVehicle ~= 0 then
		loadAnimDict("amb@medic@standing@kneel@base")
		TaskPlayAnim(playerped,"amb@medic@standing@kneel@base","base", 8.0, -8, -1, 0, 0, 0, 0, 0)
		local finished = exports["ucrp-taskbar"]:taskBar(20000,"Changing plates", true)
		if finished == 100 then
			TriggerServerEvent("fakeplate:change",plate)
		end
	else
		TriggerEvent("DoLongHudText","No vehicle close by.", 2)
	end
end)

RegisterNetEvent('transfer:attempt')
AddEventHandler('transfer:attempt', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "ARE YOU SURE?!?", 
            txt = ""
        },
		{
            id = 2,
            header = "YES",
			txt = "",
			params = {
                event = "transfer:attempt2",
            }
        }
		,
		{
            id = 3,
            header = "NO",
			txt = "",
			params = {
                event = "ucrp-context:closeglobal",
            }
        }
    })
end)

RegisterNetEvent("transfer:attempt2")
AddEventHandler("transfer:attempt2", function()
    local coords = GetEntityCoords(PlayerPedId())
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        if DoesEntityExist(vehicle) then
            t, distance = GetClosestPlayer()
	        if(distance ~= -1 and distance < 2) then
                local plate = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent("transfer:attempt:send", plate, GetPlayerServerId(t))
            else
                TriggerEvent("DoLongHudText", "You are not near anyone to transfer the vehicle to", 2)
            end
        end
    end
end)

function deleteVeh(ent)
	SetVehicleHasBeenOwnedByPlayer(ent, true)
	NetworkRequestControlOfEntity(ent)
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(ent))
	DeleteEntity(ent)
	DeleteVehicle(ent)
	SetEntityAsNoLongerNeeded(ent)
end

RegisterNetEvent("scuff:impound")
AddEventHandler("scuff:impound", function()
	coordA = GetEntityCoords(PlayerPedId(), 1)
	coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
	vehicle = getVehicleInDirection(coordA, coordB)
	if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
		plate = GetVehicleNumberPlateText(vehicle)
		TriggerEvent("animation:impound")
		FreezeEntityPosition(PlayerPedId(),true)
		local finished = exports["ucrp-taskbar"]:taskBar("3000","Completing Task")
		if finished == 100 then
			ClearPedTasks(PlayerPedId())
			FreezeEntityPosition(PlayerPedId(),false)
			deleteVeh(vehicle)
			TriggerEvent("DoShortHudText","Impounded")
		else
			FreezeEntityPosition(PlayerPedId(),false)
			ClearPedTasks(PlayerPedId())
		end
	end
end)


RegisterNetEvent('animation:impound')
AddEventHandler('animation:impound', function()
	inanimation = true
	local lPed = GetPlayerPed(-1)
	RequestAnimDict("amb@code_human_police_investigate@idle_a")
	while not HasAnimDictLoaded("amb@code_human_police_investigate@idle_a") do
		Citizen.Wait(0)
	end
		
	if IsEntityPlayingAnim(lPed, "amb@code_human_police_investigate@idle_a", "idle_b", 3) then
		ClearPedSecondaryTask(lPed)
	else
		TaskPlayAnim(lPed, "amb@code_human_police_investigate@idle_a", "idle_b", 8.0, -8, -1, 49, 0, 0, 0, 0)
		seccount = 4
		while seccount > 0 do
			Citizen.Wait(1000)
			seccount = seccount - 1
		end
		ClearPedSecondaryTask(lPed)
	end		
	inanimation = false
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPed = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	if not IsPedInAnyVehicle(PlayerPedId(), false) then

		for index,value in ipairs(players) do
			local target = GetPlayerPed(value)
			if(target ~= ply) then
				local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
				local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
				if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
					closestPlayer = value
					closestPed = target
					closestDistance = distance
				end
			end
		end
		
		return closestPlayer, closestDistance, closestPed

	else
		TriggerEvent("DoShortHudText","Inside Vehicle.",2)
	end

end

local isRepair = false
local curplate = "NONE123"









--------------------



-- local copCars = {
--     "police2", -- police / sheriff charger
--     "police3", -- police SUV
--     "policeb", -- police bike
--     "sheriff", -- sheriff cvsi
--     "sheriff2", -- sheriff SUV
--     "hwaycar2", -- trooper cvpi
--     "hwaycar", -- trooper suv
--     "hwaycar3", -- trooper charger
--     "2015polstang", -- mustang pursuit
--     "police", -- K9 Vehicle
--     "police4", -- uc cv
--     "fbi", -- uc charger
--     "fbi2", -- uc cadi
--     "pbus", -- prison bus
--     "polmav", -- chopper
--     "polaventa", --Aventador
--     "pol718", -- porsche
--     "polf430", -- ferrarri
--     "romero", -- lmfao
--     "predator"
-- }

-- local offroadVehicles = {
--     "bifta",
--     "blazer",
--     "brawler",
--     "dubsta3",
--     "dune",
--     "rebel2",
--     "sandking",
--     "trophytruck",
--     "sanchez",
--     "sanchez2",
--     "blazer",
--     "enduro",
--     "pol9",
--     "police3", -- police SUV
--     "sheriff2", -- sheriff SUV
--     "hwaycar", -- trooper suv
--     "fbi2",
--     "bf400"
-- }

-- local offroadbikes = {
--     "ENDURO",
--     "sanchez",
--     "sanchez2"
-- }

-- local carsEnabled = {}
-- local airtime = 0
-- local offroadTimer = 0
-- local airtimeCoords = GetEntityCoords(PlayerPedId())
-- local heightPeak = 0
-- local lasthighPeak = 0
-- local highestPoint = 0
-- local zDownForce = 0
-- local veloc = GetEntityVelocity(GetVehiclePedIsIn(PlayerPedId()), false)
-- local offroadVehicle = false

-- local playerPed = nil
-- local currentVehicle = nil
-- local driverPed = nil
-- local harness = false
-- local harnessDurability = 0.0
-- local disableControl = false
-- local nosCar = nil
-- local nosTimeInSeconds = 10

-- DecorRegister("vehicleHarnessDur", 1) -- who knows if this works :)

-- local NosVehicles = {}
-- local nosMods = {}
-- local nosForce = 0.0
-- local seatbelt = false
-- local disablenos = false
-- local exhausts = {
--     "exhaust"
-- }
-- for i=2, 30 do
--     exhausts[#exhausts+1] = "exhaust_"..i
-- end

-- function downgrade(veh,power,offroad)
--     local vehModel = GetEntityModel(veh)
--     if carsEnabled["" .. veh .. ""] == nil then
--         return
--     end
--     if offroad then
--         power = power + 0.5
--         if IsThisModelABike(vehModel) then
--             power = power + 0.3
--         else
--             power = power + 0.3
--         end

--     end
--     power = math.ceil(power * 10)

--     local factor = math.random( 3+power ) / 10


--     if factor > 0.7 then
--         if IsThisModelABike(vehModel) then
--             if not offroad then
--                 factor = 0.7
--             end
--         else
--             if not offroad then
--                 factor = 0.7
--             else
--                 factor = 0.8
--             end

--         end
--     end

--     if factor < 0.4 then
--         if not offroad then
--             factor = 0.5
--         else
--             factor = 0.7
--         end
--     end

--     if carsEnabled["" .. veh .. ""] == nil then return end
--     local carData = carsEnabled["" .. veh .. ""]
--     --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel', carData["fInitialDriveMaxFlatVel"] * factor)
--     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock', carsEnabled["" .. veh .. ""]["fSteeringLock"] * factor)
--     --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult', carData["fTractionLossMult"] * factor)
--     --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', carData["fLowSpeedTractionLossMult"] * factor)
--     --SetVehicleEnginePowerMultiplier(veh,factor)
--     --SetVehicleEngineTorqueMultiplier(veh,factor)
--     --TriggerEvent("tuner:setDriver")
-- end

-- function resetdowngrade(veh)
--     if carsEnabled["" .. veh .. ""] == nil then
--         return
--     end
--     local carData = carsEnabled["" .. veh .. ""]
--     --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel', carData["fInitialDriveMaxFlatVel"])
--     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock', carData["fSteeringLock"])
--     --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult', carData["fTractionLossMult"])
--     --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', carData["fLowSpeedTractionLossMult"])
--     --SetVehicleEnginePowerMultiplier(veh,0.7)
--     --SetVehicleEngineTorqueMultiplier(veh,0.7)

-- end

-- function ejectionLUL()
--     local veh = GetVehiclePedIsIn(playerPed,false)
--     local coords = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, 1.0)
--     SetEntityCoords(playerPed,coords)
--     Citizen.Wait(1)
--     SetPedToRagdoll(playerPed, 5511, 5511, 0, 0, 0, 0)
--     SetEntityVelocity(playerPed, veloc.x*2,veloc.y*2,veloc.z*2)
--     local ejectspeed = math.ceil(GetEntitySpeed(playerPed) * 4)
--     if IsPedWearingHelmet(playerPed) and IsThisModelABicycle(GetEntityModel(veh)) then
--         -- Players on bicycles wearing helmets shouldn't die from the ejection itself. Instead, set HP to 1.
--         -- Player will only die if further native damage occurs post ejection, more than the armour can protect.
--         local damageAmount = GetEntityHealth(playerPed) - 1
--         if damageAmount > ejectspeed then
--             damageAmount = ejectspeed
--         end
--         SetEntityHealth(playerPed, GetEntityHealth(playerPed) - damageAmount)
--         return
--     end
--     SetEntityHealth(playerPed, (GetEntityHealth(playerPed) - ejectspeed) )
--    -- TriggerEvent("randomBoneDamage")
-- end

-- function preventVehicleExit()
--     Citizen.CreateThread(function()
--         local options = {1000,2000,3000}
--         disableControl = true
--         local finished = exports["ucrp-taskbar"]:taskBar(options[math.random(1,3)],"Taking off Harness",true)
--         if finished == 100 then
--             harness = false
--             TriggerEvent("harness", false, harnessDurability)
--             TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
--             TriggerEvent("DoShortHudText",'Harness Disabled',4)
--         end
--         disableControl = false
--     end)
-- end

-- local stalled = false

-- function carCrash()
--     endNos()
--     local wheels = {0,1,4,5}
--     for i=1, math.random(4) do
--         local wheel = math.random(#wheels)
--         SetVehicleTyreBurst(currentVehicle, wheels[wheel], false, 1000)
--         table.remove(wheels, wheel)
--     end
--     TriggerEvent("client:newStress",true, 200)
--     SetVehicleEngineHealth(currentVehicle, 10)
--     SetVehicleEngineOn(currentVehicle, false, true, true)
--     lastCurrentVehicleSpeed = 0.1
--     lastCurrentVehicleBodyHealth = 0.1
--     stalled = true
-- end

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1)
--         if stalled then
--             Citizen.Wait(math.random(3500, 4500))
--             SetVehicleEngineOn(currentVehicle, true, true, true)
--             stalled = false
--         end
--     end
-- end)

-- function nosInit()
--     nosCar = GetVehiclePedIsIn(playerPed, false)
--     if nosCar ~= 0 and nosCar ~= false and nosCar ~= nil then
--         Citizen.CreateThread(function()
--             startNos()
--             sendServerEventForPassengers("NetworkNos")

--             local curSpeed = GetEntitySpeed(nosCar)
--             local modifier = (1.0 / (curSpeed / 5)) * 0.81
--             -- SetVehicleForwardSpeed(nosCar, curSpeed + modifier) --Forward Speed

--             if nosForce == 0.0 then
--                 local fInitialDriveForce = GetVehicleHandlingFloat(nosCar, 'CHandlingData', 'fInitialDriveForce')
--                 nosForce = fInitialDriveForce
--             end
--             local burst = math.ceil( (nosForce + nosForce * 1.15) * 100000 ) / 100000
--             if GetEntitySpeed(nosCar) > 70 then
--                 burst = math.ceil( (nosForce + nosForce * 0.85) * 100000 ) / 100000
--             end

--             if burst > 0 then
--                 local fInitialDriveForce = GetVehicleHandlingFloat(nosCar, 'CHandlingData', 'fInitialDriveForce')
--                 if burst >= fInitialDriveForce then
--                     if nosMods[nosCar] ~= nil and burst > nosMods[nosCar] then
--                         burst = nosMods[nosCar]
--                     else
--                         nosMods[nosCar] = burst
--                     end
--                     SetVehicleHandlingField(nosCar, 'CHandlingData', 'fInitialDriveForce', burst)
--                 end
--             end
--             nosParticles()
--         end)
--     end
-- end

-- function nosParticles()
--      -- TODO: Fix for all exhaust
--     local scale = 1.0
--     local count = 500
--     local particleDict = "veh_xs_vehicle_mods"
--     local particleCar = GetVehiclePedIsIn(playerPed, false)
--     RequestNamedPtfxAsset(particleDict)
--     while not HasNamedPtfxAssetLoaded(particleDict) do
--         Citizen.Wait(0)
--     end
--     UseParticleFxAssetNextCall(particleDict)

--     local particles = {}

--     function removeParticles()
--         Citizen.CreateThread(function()
--             for i,v in pairs(particles) do
--                 RemoveParticleFx(v)
--             end
--             Citizen.Wait(2000)
--             for i,v in pairs(particles) do
--                 RemoveParticleFx(v)
--                 particles[i] = nil
--             end
--         end)
--     end

--     if particleCar ~= 0 and particleCar ~= false and particleCar ~= nil then
--         local pitch = GetEntityPitch(particleCar)
--         local carPos = GetEntityCoords(particleCar, false)

--         for i,v in pairs(exhausts) do
--             local bone = GetEntityBoneIndexByName(particleCar, v)
--             if bone ~= -1 then
--                 local offset = GetWorldPositionOfEntityBone(particleCar, bone)
--                 UseParticleFxAsset(particleDict)
--                 particles[#particles+1] = StartNetworkedParticleFxLoopedOnEntityBone("veh_nitrous", particleCar, 0.0,0.0,0.0 , 0.0, pitch, 0.0, bone, 1.0, false, false, false)
--             end
--         end

--         Citizen.Wait(1000)

--         for i,v in pairs(exhausts) do
--             local bone = GetEntityBoneIndexByName(particleCar, v)
--             if bone ~= -1 then
--                 local offset = GetWorldPositionOfEntityBone(particleCar, bone)
--                 UseParticleFxAsset(particleDict)
--                 particles[#particles+1] = StartNetworkedParticleFxLoopedOnEntityBone("veh_nitrous", particleCar, 0.0,0.0,0.0 , 0.0, pitch, 0.0, bone, 1.0, false, false, false)
--             end
--         end
--     end

--     Citizen.SetTimeout(1000 * nosTimeInSeconds, function()
--         removeParticles()
--         endNos()
--     end)
-- end

-- function startNos(veh)
--     disablenos = true
--     if nosCar ~= 0 and nosCar ~= false and nosCar ~= nil then
--         SetVehicleBoostActive(nosCar, 1) --Boost Sound
--     elseif veh ~= nil then
--         SetVehicleBoostActive(veh, 1)
--     end

--     Citizen.CreateThread(function()
--         local active = true

--         Citizen.SetTimeout(1000 * math.ceil(nosTimeInSeconds / 3), function()
--             active = false
--         end)

--         while active do
--             Citizen.Wait(0)
--             -- StartScreenEffect("RaceTurbo", 30.0, 0)
--             -- StartScreenEffect("ExplosionJosh3", 30.0, 0)
--         end

--         -- StartScreenEffect("RaceTurbo", 0, 0)
--         -- StartScreenEffect("ExplosionJosh3", 0, 0)
--         if nosCar ~= 0 and nosCar ~= false and nosCar ~= nil then
--             SetVehicleBoostActive(nosCar, 0)
--         end
--     end)
-- end

-- function endNos()
--     if not disablenos then
--         return
--     end

--     if nosCar ~= 0 and nosCar ~= false and nosCar ~= nil then
--         TriggerEvent("noshud", NosVehicles[nosCar], false)
--         SetVehicleHandlingField(nosCar, 'CHandlingData', 'fInitialDriveForce', nosForce)
--     end

--     nosForce = 0.0
--     disablenos = false
-- end

-- function sendServerEventForPassengers(event, value)
--     local player = PlayerPedId()
--     for i=-1, GetVehicleMaxNumberOfPassengers(currentVehicle)-1 do
--         local ped = GetPedInVehicleSeat(currentVehicle, i)
--         if ped ~= player and ped ~= 0 then
--             TriggerServerEvent(event, GetPlayerServerId(v), value)
--         end
--     end
-- end

-- function getVehicleInDirection(coordFrom, coordTo)
-- 	local offset = 0
-- 	local rayHandle
-- 	local vehicle
-- 	for i = 0, 100 do
-- 		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)
-- 		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
-- 		offset = offset - 1
-- 		if vehicle ~= 0 then break end
-- 	end
-- 	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
-- 	if distance > 25 then vehicle = nil end
--     return vehicle ~= nil and vehicle or 0
-- end

-- function toggleHarness()
--     disableControl = true
--     local finished = 0
--     if harness then
--         finished = exports["ucrp-taskbar"]:taskBar(5000,"Taking off Harness",true)
--     else
--         finished = exports["ucrp-taskbar"]:taskBar(5000,"Putting on Harness",true)
--     end
--     if (finished == 100) then
--         if playerPed == driverPed then
--             if not harness then
--                 TriggerEvent("harness", true, harnessDurability)
--                 TriggerEvent("InteractSound_CL:PlayOnOne","seatbelt",0.1)
--                 TriggerEvent("DoShortHudText",'Harness Enabled',4)
--             else
--                 TriggerEvent("harness", false, harnessDurability)
--                 TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
--                 TriggerEvent("DoShortHudText",'Harness Disabled',4)
--             end
--             harness = not harness
--             seatbelt = false
--         else
--             -- Player switched while putting it on ...
--             harnessDurability = 0.0
--             TriggerEvent("harness", false, harnessDurability)
--             TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
--             TriggerEvent("DoShortHudText",'Harness Disabled',4)
--             harness = false
--             seatbelt = false
--         end
--     end
--     disableControl = false
-- end

-- local function Info()
--     local PlayerPed = PlayerPedId()
--     local plyVeh = GetVehiclePedIsIn(PlayerPed, false)
--     local IsDriver = GetPedInVehicleSeat(plyVeh, -1) == PlayerPed
--     local returnValue = plyVeh ~= 0 and plyVeh ~= nil and IsDriver
--     return returnValue, plyVeh
-- end

-- Citizen.CreateThread(function()
--     while true do
--         local Driver, plyVeh = Info()
--         if Driver then
--             if GetVehicleCurrentGear(plyVeh) < 3 and GetVehicleCurrentRpm(plyVeh) == 1.0 and math.ceil(GetEntitySpeed(plyVeh) * 2.236936) > 50 then
--               while GetVehicleCurrentRpm(plyVeh) > 0.6 do
--                   SetVehicleCurrentRpm(plyVeh, 0.3)
--                   Citizen.Wait(1)
--               end
--               Citizen.Wait(800)
--             end
--         end
--         Citizen.Wait(500)
--     end
-- end)

-- function toggleSeatbelt()
--     if seatbelt == false then
--         TriggerEvent("seatbelt",true)
--         TriggerEvent("InteractSound_CL:PlayOnOne","seatbelt",0.1)
--         TriggerEvent("DoShortHudText",'Seat Belt Enabled',4)
--     else
--         TriggerEvent("seatbelt",false)
--         TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
--         TriggerEvent("DoShortHudText",'Seat Belt Disabled',4)
--     end
--     seatbelt = not seatbelt
-- end

-- RegisterNetEvent('NosStatus')
-- AddEventHandler('NosStatus', function()
--     if not IsToggleModOn(currentVehicle,18) then
--         TriggerEvent('DoLongHudText', 'Need a Turbo for Nos!', 2)
--         return
--     end

--     if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
--         if driverPed == playerPed then
--             NosVehicles[currentVehicle] = 100
--         end
--     end
-- end)

-- RegisterNetEvent('NetworkNos')
-- AddEventHandler('NetworkNos', function()
--     startNos(GetVehiclePedIsIn(playerPed,false))
-- end)

-- RegisterNetEvent('nos:help')
-- AddEventHandler('nos:help', function()
--     if NosVehicles[currentVehicle] == nil then
--         NosVehicles[currentVehicle] = 0
--     end

--     TriggerEvent("chatMessage", "NOS: ", {255, 255, 255}, "You have %" .. math.floor(NosVehicles[currentVehicle]) .. " left")
-- end)

-- RegisterNetEvent("carhud:ejection:client")
-- AddEventHandler("carhud:ejection:client",function(value)
--     veloc = value
--     if seatbelt then
--         if math.random(10) > 6 then
--             ejectionLUL()
--         end
--     else
--         if math.random(10) > 2 then
--             ejectionLUL()
--         end
--     end
-- end)

-- RegisterNetEvent('event:control:vehicleMod')
-- AddEventHandler('event:control:vehicleMod', function(useID)
--     if IsPedInAnyVehicle(playerPed) and not IsThisModelABike(GetEntityModel(currentVehicle)) then
--         if harnessDurability > 0.0 then
--             toggleHarness()
--         elseif harnessDurability <= 0.0 and harness then
--             TriggerEvent("harness", false, harnessDurability)
--             TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
--             TriggerEvent("DoShortHudText",'Harness Disabled',4)
--             harness = false
--         else
--             toggleSeatbelt()
--         end
--     end
-- end)

-- RegisterNetEvent("vehicleMod:setHarness")
-- AddEventHandler("vehicleMod:setHarness",function(result, isNew)
--     if result then -- player owned car
--         if tonumber(result) >= 0.0 then
--             harnessDurability = tonumber(result)
--         else
--             harnessDurability = 0.0
--         end
--     else -- local car or fake plates
--         if DecorExistOn(currentVehicle, "vehicleHarnessDur") and not isNew then
--             harnessDurability = DecorGetFloat(currentVehicle, "vehicleHarnessDur")
--         elseif isNew then
--             DecorSetFloat(currentVehicle, "vehicleHarnessDur", 1.0)
--             harnessDurability = 1.0
--         else
--             harnessDurability = 0.0
--         end
--     end
--     if currentVehicle ~= 0 and currentVehicle ~= nil and currentVehicle ~= false then
--         if driverPed == playerPed then
--             TriggerEvent("harness", harness, harnessDurability)
--         else
--             harness = false
--             harnessDurability = 0.0
--             TriggerEvent("harness", false, 0.0)
--         end
--     end
-- end)

-- RegisterNetEvent("vehicleMod:useHarnessItem")
-- AddEventHandler("vehicleMod:useHarnessItem",function()
--     TriggerServerEvent("vehicleMod:applyHarness", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)), 1.0)
-- end)

-- RegisterNetEvent("vehicleMod:resetDowngrade")
-- AddEventHandler("vehicleMod:resetDowngrade",function(targetvehicle)
--     resetdowngrade(targetvehicle)
-- end)

-- RegisterNetEvent("client:illegal:upgrades")
-- AddEventHandler("client:illegal:upgrades",function(Extractors,Filter,Suspension,Rollbars,Bored,Carbon)
--     if (IsPedInAnyVehicle(playerPed, false)) then
--         local veh = GetVehiclePedIsIn(playerPed,false)
--         if Extractors == 1 then

--             local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
--             fInitialDriveForce = fInitialDriveForce + fInitialDriveForce * 0.1
--             -- SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
--         end


--         if Filter == 1 then

--             local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
--             fInitialDriveForce = fInitialDriveForce + fInitialDriveForce * 0.1
--             -- SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
--         end

--         if Suspension == 1 then

--             local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
--             fBrakeForce = fBrakeForce + fBrakeForce * 0.3
--             -- SetVehicleHandlingField(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

--             local fSteeringLock = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock')
--             --fSteeringLock = fSteeringLock + fSteeringLock * 0.2
--             --SetVehicleHandlingField(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)

--         end

--         if Rollbars == 1 then

--             local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
--             fBrakeForce = fBrakeForce + fBrakeForce * 0.1
--             -- SetVehicleHandlingField(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

--             local fSteeringLock = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock')
--             --fSteeringLock = fSteeringLock + fSteeringLock * 0.2
--             --SetVehicleHandlingField(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)

--         end

--         if Bored == 1 then

--             local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
--             fInitialDriveForce = fInitialDriveForce + fInitialDriveForce * 0.05
--             -- SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
--         end

--         if Carbon == 1 then


--             local fMass = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fMass')
--             fMass = fMass - fMass * 0.3
--             -- SetVehicleHandlingField(veh, 'CHandlingData', 'fMass', fMass)

--             local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
--             fInitialDriveForce = fInitialDriveForce + fInitialDriveForce * 0.1

--         end
--     end
-- end)


-- Citizen.CreateThread(function()
--     local firstDrop = GetEntityVelocity(PlayerPedId())
--     local lastentSpeed = 0
--     while true do
--         Citizen.Wait(1)

--         if (IsPedInAnyVehicle(PlayerPedId(), false)) then

--             local veh = GetVehiclePedIsIn(PlayerPedId(),false)
--             if not invehicle and not IsThisModelABike(GetEntityModel(veh)) then
--                 invehicle = true
--                 TriggerEvent("InteractSound_CL:PlayOnOne","beltalarm",0.35)
--             end

--             local bicycle = IsThisModelABicycle( GetEntityModel(veh) )

--             if carsEnabled["" .. veh .. ""] == nil and not bicycle then
--                 SetVehiclePetrolTankHealth(veh, 4000.0)

--                 SetVehicleHandlingFloat(veh, 'CHandlingData', 'fWeaponDamageMult', 2.000000)

--                 local fSteeringLock = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock')

--                 fSteeringLock = math.ceil((fSteeringLock * 0.8)) + 0.1
--                 -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)
--                 -- SetVehicleHandlingField(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)

--                 local fInitialDriveMaxFlatVel = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel')
--                 if IsThisModelABike(GetEntityModel(veh)) then

--                     local fTractionCurveMin = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMin')

--                     fTractionCurveMin = fTractionCurveMin * 0.6
--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMin', fTractionCurveMin)
--                     -- SetVehicleHandlingField(veh, 'CHandlingData', 'fTractionCurveMin', fTractionCurveMin)

--                     local fTractionCurveMax = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMax')

--                     fTractionCurveMax = fTractionCurveMax * 0.6
--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMax', fTractionCurveMax)
--                     -- SetVehicleHandlingField(veh, 'CHandlingData', 'fTractionCurveMax', fTractionCurveMax)



--                     local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
--                     fInitialDriveForce = fInitialDriveForce * 2.2
--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)

--                     local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
--                     fBrakeForce = fBrakeForce * 1.4
--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSuspensionReboundDamp', 5.000000)
--                     -- SetVehicleHandlingField(veh, 'CHandlingData', 'fSuspensionReboundDamp', 5.000000)

--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSuspensionCompDamp', 5.000000)
--                     -- SetVehicleHandlingField(veh, 'CHandlingData', 'fSuspensionCompDamp', 5.000000)

--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSuspensionForce', 22.000000)
--                     -- SetVehicleHandlingField(veh, 'CHandlingData', 'fSuspensionForce', 22.000000)

--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fCollisionDamageMult', 2.500000)
--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fEngineDamageMult', 0.120000)
--                 else

--                     local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
--                     fBrakeForce = fBrakeForce * 0.5
--                     --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

--                     local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
--                     if fInitialDriveForce < 0.289 then
--                         fInitialDriveForce = fInitialDriveForce * 1.05
--                         --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
--                     else
--                         fInitialDriveForce = fInitialDriveForce * 0.8
--                         --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
--                     end
--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fEngineDamageMult', 0.100000)
--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fCollisionDamageMult', 2.900000)

--                 end

--                 SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDeformationDamageMult', 1.000000)

--                 SetVehicleHasBeenOwnedByPlayer(veh,true)
--                 carsEnabled["" .. veh .. ""] = {
--                     ["fInitialDriveMaxFlatVel"] = fInitialDriveMaxFlatVel,
--                     ["fSteeringLock"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock'),
--                     ["fTractionLossMult"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult'),
--                     ["fLowSpeedTractionLossMult"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult')
--                 }
--                 local plt = GetVehicleNumberPlateText(veh)
--                 TriggerServerEvent("request:illegal:upgrades",plt)
--             else
--                 Wait(1000)
--             end


--             if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then

--                 local coords = GetEntityCoords(PlayerPedId())
--                 local roadtest2 = IsPointOnRoad(coords.x, coords.y, coords.z, veh)
--               --  roadtest, endResult, outHeading = GetClosestVehicleNode(coords.x, coords.y, coords.z,  1, 0, -1)
--              --   endDistance = #(vector3(endResult.x, endResult.y, endResult.z) - GetEntityCoords(PlayerPedId()))
--                 local myspeed = GetEntitySpeed(veh) * 3.6
--                 local xRot = GetEntityUprightValue(veh)
--                 if not roadtest2 then
--                     if (xRot < 0.90) then
--                         offroadTimer = offroadTimer + (1 - xRot)
--                     elseif xRot > 0.90 then
--                         if offroadTimer < 1 then
--                             offroadTimer = 0
--                         else
--                             offroadTimer = offroadTimer - xRot
--                             resetdowngrade(veh)
--                         end
--                     end
--                 elseif offroadTimer > 0 or offroadTimer == 0 then
--                     offroadTimer = 0
--                     offroadVehicle = false
--                     resetdowngrade(veh)
--                 end

--                 -- if offroadTimer > 5 and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then

--                 --     for i = 1, #offroadVehicles do
--                 --         if IsVehicleModel( GetVehiclePedIsUsing(PlayerPedId()), GetHashKey(offroadVehicles[i]) ) then
--                 --             offroadVehicle = true

--                 --         end
--                 --     end

--                 --     if not offroadVehicle then
--                 --         if IsThisModelABike(GetEntityModel(veh)) then
--                 --             downgrade(veh,0.45 - xRot / 10,offroadVehicle)
--                 --         else
--                 --             downgrade(veh,0.55 - xRot / 10,offroadVehicle)
--                 --         end

--                 --     else
--                 --         downgrade(veh,0.78 - xRot / 10,offroadVehicle)
--                 --     end
--                 -- end

--                 if IsEntityInAir(veh) then
--                     firstDrop = GetEntityVelocity(veh)
--                     lastentSpeed = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())))
--                     if airtime == 1 then
--                         heightPeak = 0
--                         lasthighPeak = 0
--                         airtimeCoords = GetEntityCoords(veh)
--                         lasthighPeak = airtimeCoords.z
--                     else
--                         local AirCurCoords = GetEntityCoords(veh)
--                         heightPeak = AirCurCoords.z
--                         if tonumber(heightPeak) > tonumber(lasthighPeak) and airtime ~= 0 then
--                             lasthighPeak = heightPeak
--                             highestPoint = heightPeak - airtimeCoords.z
--                         end
--                     end
--                     airtime = airtime + 1
--                 elseif airtime > 0 then

--                     if airtime > 110 then
--                         Citizen.Wait(1)
--                         local landingCoords = GetEntityCoords(veh)
--                         local landingfactor = landingCoords.z - airtimeCoords.z
--                         local momentum = GetEntityVelocity(veh)
--                         highestPoint = highestPoint - landingfactor

--                         highestPoint = highestPoint * 0.55

--                         airtime = math.ceil(airtime * highestPoint)

--                         local xdf = 0
--                         local ydf = 0
--                         if momentum.x < 0 then
--                             xdf = momentum.x
--                             xdf = math.ceil(xdf - (xdf * 2))
--                         else
--                             xdf = momentum.x
--                         end

--                         if momentum.y < 0 then
--                             ydf = momentum.y
--                             ydf = math.ceil(ydf - (ydf * 2))
--                         else
--                             ydf = momentum.y
--                         end



--                         zdf = momentum.z
--                         lastzvel = firstDrop.z

--                         zdf = zdf - lastzvel
--                         local dirtBike = false
--                         for i = 1, #offroadbikes do
--                             if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()), GetHashKey(offroadbikes[i], _r)) then
--                                 dirtBike = true
--                             end
--                         end
--                         if dirtBike then
--                             airtime = airtime - 200
--                         end

--                         if IsThisModelABicycle(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) then
--                             local ohshit = math.ceil((zdf * 200))
--                             local entSpeed = math.ceil( GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 1.35 )

--                             if airtime > 550 then
--                                 if airtime > 550 and ohshit > airtime and ( entSpeed < lastentSpeed or entSpeed < 2.0 ) then
--                                     ejectionLUL()
--                                     --TriggerEvent("DoLongHudText","eject : " .. ohshit .. " vs " .. airtime .. " " .. entSpeed .. " vs " .. lastentSpeed)
--                                 elseif airtime > 1500 and entSpeed < lastentSpeed then
--                                     ejectionLUL()
--                                     --TriggerEvent("DoLongHudText","eject 2 : " .. ohshit .. " vs " .. airtime .. " " .. entSpeed .. " vs " .. lastentSpeed)
--                                 else
--                                 --  TriggerEvent("DoLongHudText","Good Landing" .. ohshit .. " vs " .. airtime .. " " .. entSpeed .. " vs " .. lastentSpeed)
--                                 end
--                             end

--                         elseif airtime > 950 and IsThisModelABike(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) then
--                             local ohshit = math.ceil((zdf * 200))
--                             local entSpeed = math.ceil( GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 1.15 )

--                             if airtime > 950 then
--                                 if airtime > 950 and ohshit > airtime and ( entSpeed < lastentSpeed or entSpeed < 2.0 ) then
--                                     ejectionLUL()
--                                     endNos()
--                                     --TriggerEvent("DoLongHudText","eject : " .. ohshit .. " vs " .. airtime .. " " .. entSpeed .. " vs " .. lastentSpeed)
--                                 elseif airtime > 2500 and entSpeed < lastentSpeed then
--                                     ejectionLUL()
--                                     endNos()
--                                     --TriggerEvent("DoLongHudText","eject 2 : " .. ohshit .. " vs " .. airtime .. " " .. entSpeed .. " vs " .. lastentSpeed)
--                                 else
--                                     --TriggerEvent("DoLongHudText","Good Landing" .. ohshit .. " vs " .. airtime .. " " .. entSpeed .. " vs " .. lastentSpeed)
--                                 end
--                             end

--                         end
--                     end
--                     airtimeCoords = GetEntityCoords(PlayerPedId())
--                     heightPeak = 0
--                     airtime = 0
--                     lasthighPeak = 0
--                     zDownForce = 0
--                 end

--                 --GetVehicleClass(vehicle)
--                 local ped = PlayerPedId()
--                 local roll = GetEntityRoll(veh)

--                 if IsEntityInAir(veh) and not IsThisModelABike(GetEntityModel(veh)) then
--                     DisableControlAction(0, 59)
--                     DisableControlAction(0, 60)
--                 end
--                 -- if ((roll > 75.0 or roll < -75.0) or not IsVehicleEngineOn(veh)) and not IsThisModelABike(GetEntityModel(veh)) then
--                 --     DisableControlAction(2,59,true)
--                 --     DisableControlAction(2,60,true)
--                 -- end
--             else
--                 Wait(1000)
--             end
--         else
--             if invehicle or seatbelt then
--                 if seatbelt then
--                     TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
--                 end
--                 invehicle = false
--                 seatbelt = false
--                 TriggerEvent("seatbelt",false)
--             end
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1)
--         if seatbelt then
--             DisableControlAction(0, 75)
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         local get_ped = PlayerPedId() -- current ped
--         local get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
--         if get_ped_veh ~= 0 then
--             local model = GetEntityModel(get_ped_veh)
--             local roll = GetEntityRoll(get_ped_veh)
  
--             if not IsThisModelABoat(model)
--                 and not IsThisModelAHeli(model)
--                 and not IsThisModelAPlane(model)
--                 and not IsThisModelABicycle(model)
--                 and not IsThisModelABike(model)
--                 and not IsThisModelAJetski(model)
--                 and not IsThisModelAQuadbike(model)
--                 and (IsEntityInAir(get_ped_veh) or (roll < -50 or roll > 50)) then
--                 DisableControlAction(0, 59) -- leaning left/right
--                 DisableControlAction(0, 60) -- leaning up/down
--             end
--         end
--     end
-- end)

-- -- CurrentVehicle and DriverPed Updater --
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1000)
--         playerPed = PlayerPedId()
--         local tempVehicle = GetVehiclePedIsIn(playerPed, false)
--         local tempDriver = GetPedInVehicleSeat(tempVehicle, -1)
--         if tempVehicle ~= currentVehicle then
--             harness = false
--             seatbelt = false
--             currentVehicle = tempVehicle
--             if currentVehicle == nil or currentVehicle == 0 or currentVehicle == false then
--                 TriggerEvent("DensityModifierEnable", true)
--             else
--                 driverPed = GetPedInVehicleSeat(currentVehicle, -1)
--                 if driverPed == playerPed then
--                     TriggerEvent("DensityModifierEnable", true)
--                     TriggerEvent("noshud", NosVehicles[currentVehicle], false)
--                     TriggerEvent("tuner:setDriver")
--                 else
--                     TriggerEvent("DensityModifierEnable", false)
--                 end
--                 TriggerServerEvent("vehicleMod:getHarness", GetVehicleNumberPlateText(currentVehicle))
--             end
--         elseif (tempDriver ~= driverPed and tempDriver ~= 0) or (tempDriver == 0 and driverPed == playerPed) then
--             driverPed = tempDriver
--             if driverPed == playerPed then
--                 -- Switched seat to driver
--                 if seatbelt then
--                     toggleSeatbelt()
--                 end
--                 TriggerEvent("DensityModifierEnable", true)
--                 TriggerEvent("noshud", NosVehicles[currentVehicle], false)
--                 TriggerServerEvent("vehicleMod:getHarness", GetVehicleNumberPlateText(currentVehicle))
--                 TriggerEvent("tuner:setDriver")
--             else
--                 if harness then
--                     toggleHarness()
--                 elseif seatbelt then
--                     toggleSeatbelt()
--                 else
--                     TriggerServerEvent("vehicleMod:getHarness", GetVehicleNumberPlateText(currentVehicle))
--                 end

--                 TriggerEvent("DensityModifierEnable", false)
--                 TriggerEvent("noshud", 0, false)
--             end

--             TriggerEvent("seatbelt",false)
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(2)
--         if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
--             if harness then
--                 DisableControlAction(1, 75, true)
--                 if IsDisabledControlJustPressed(1, 75) then
--                     preventVehicleExit()
--                 end
--             --elseif IsControlJustPressed(1, 75) then
--                 --endNos()
--             else
--                 Citizen.Wait(1000)
--             end
--         else
--             Citizen.Wait(5000)
--         end
--     end
-- end)

-- -- Collision Thread --
-- Citizen.CreateThread(function()
--     Citizen.Wait(1000)
--     local lastCurrentVehicleBodyHealth = 0
--     local lastCurrentVehicleSpeed = 0

--     local function eject(percent, speed, trigger)
--         if math.random(math.ceil(speed)) > percent then
--             ejectionLUL()
--             if trigger then
--           --      TriggerEvent("civilian:alertPolice",50.0,"carcrash",0)
--             end
--         end
--     end

--     while true do
--         Citizen.Wait(1)
--         if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
--             SetPedHelmet(playerPed, false)
--             if driverPed == playerPed then
--                 local currentEngineHealth = GetVehicleEngineHealth(currentVehicle)
--                 if currentEngineHealth < 0.0 then
--                     -- Dont blow up
--                     SetVehicleEngineHealth(currentVehicle,0.0)
--                 end

--                 local collision = HasEntityCollidedWithAnything(currentVehicle)
--                 if collision == false then
--                     lastCurrentVehicleSpeed = GetEntitySpeed(currentVehicle)
--                     lastCurrentVehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
--                     veloc = GetEntityVelocity(currentVehicle)
--                     if currentEngineHealth > 10.0 and (currentEngineHealth < 175.0 or lastCurrentVehicleBodyHealth < 50.0) then
--                         carCrash()
--                         stalled = true
--                         Citizen.Wait(1000)
--                     end
--                 else
--                     Citizen.Wait(100)
--                     local currentVehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
--                     local currentVehicleSpeed = GetEntitySpeed(currentVehicle)
--                     if currentEngineHealth > 0.0 and lastCurrentVehicleBodyHealth - currentVehicleBodyHealth > 15 then
--                         if lastCurrentVehicleSpeed > 30.5 and currentVehicleSpeed < (lastCurrentVehicleSpeed * 0.75) then
--                             if not IsThisModelABike(GetEntityModel(currentVehicle)) then
--                                 carCrash()
--                                 stalled = true
--                                 sendServerEventForPassengers("carhud:ejection:server", veloc)
--                                 if harness and harnessDurability > 0.0 then
--                                     harnessDurability = harnessDurability - 0.1
--                                     TriggerServerEvent("vehicleMod:updateHarness", GetVehicleNumberPlateText(currentVehicle), harnessDurability)
--                                     if DecorExistOn(currentVehicle, "vehicleHarnessDur") then
--                                         DecorSetFloat(currentVehicle, "vehicleHarnessDur", harnessDurability)
--                                     end
--                                     if harnessDurability <= 0.0 then
--                                         harnessDurability = 0.0
--                                         TriggerEvent("event:control:vehicleMod")
--                                         TriggerEvent('DoLongHudText', 'Harness Broken!', 2)
--                                     end
--                                 elseif not seatbelt then
--                                     eject(30.5, lastCurrentVehicleSpeed, true)
--                                 elseif seatbelt and lastCurrentVehicleSpeed > 41.6 then
--                                     eject(33.0, lastCurrentVehicleSpeed, false)
--                                 end
--                                 -- Buffer after crash
--                                 Citizen.Wait(1000)
--                                 lastCurrentVehicleSpeed = 0.0
--                                 lastCurrentVehicleBodyHealth = currentVehicleBodyHealth
--                             else
--                                 -- IsBike
--                                 carCrash()
--                                 stalled = true
--                                 Citizen.Wait(1000)
--                                 lastCurrentVehicleSpeed = 0.0
--                                 lastCurrentVehicleBodyHealth = currentVehicleBodyHealth
--                             end
--                         end
--                     else
--                         if currentEngineHealth > 10.0 and (currentEngineHealth < 195.0 or currentVehicleBodyHealth < 50.0) then
--                             carCrash()
--                             stalled = true
--                             Citizen.Wait(1000)
--                         end
--                         lastCurrentVehicleSpeed = currentVehicleSpeed
--                         lastCurrentVehicleBodyHealth = currentVehicleBodyHealth
--                     end
--                 end
--             else
--                 -- Not driver
--                 Citizen.Wait(1000)
--             end
--         else
--             -- Not in veh
--             currentVehicleSpeed = 0
--             lastCurrentVehicleSpeed = 0
--             lastCurrentVehicleBodyHealth = 0
--             Citizen.Wait(4000)
--         end
--     end
-- end)

-- -- NOS Thread --
-- Citizen.CreateThread(function()
--     -- Handle NOS
--     while true do
--         Citizen.Wait(200)
--         if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 and driverPed == playerPed then
--             if NosVehicles[currentVehicle] == nil then
--                 NosVehicles[currentVehicle] = 0
--             end
--             local vehModel = GetEntityModel(currentVehicle)
--             if IsControlPressed(1,209) and NosVehicles[currentVehicle] ~= nil then
--                 if not IsThisModelAHeli(vehModel) and not IsThisModelABoat(vehModel) and not IsThisModelABike(vehModel) and IsVehicleOnAllWheels(currentVehicle) and IsVehicleEngineOn(currentVehicle) then
--                     if GetEntitySpeed(currentVehicle) > 12.5 and NosVehicles[currentVehicle] > 0 then
--                         if GetEntitySpeed(currentVehicle) > 113.0 then -- 250mph
--                             -- SetVehicleEngineHealth(currentVehicle, 0.0)
--                             -- SetVehicleEngineOn(currentVehicle, false, true, true)
--                         elseif not disablenos then
--                             nosInit()
--                             TriggerEvent("noshud", NosVehicles[currentVehicle], true)
--                             NosVehicles[currentVehicle] = NosVehicles[currentVehicle] - 10
--                         end
--                     end
--                 end
--             end
--         else
--             Citizen.Wait(5000)
--         end
--     end
-- end)


