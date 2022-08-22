-- gas filling
local NearGas = false
DecorRegister("CurrentFuel", 3)
Fuel = 0
local gasStations = {
    {49.41872, 2778.793, 58.04395,600},
    {263.8949, 2606.463, 44.98339,600},
    {1039.958, 2671.134, 39.55091,900},
    {1207.26, 2660.175, 37.89996,900},
    {2539.685, 2594.192, 37.94488,1500},
    {2679.858, 3263.946, 55.24057,1500},
    {2005.055, 3773.887, 32.40393,1200},
    {1687.156, 4929.392, 42.07809,900},
    {1701.314, 6416.028, 32.76395,1200},
    {179.8573, 6602.839, 31.86817,600},
    {-94.46199, 6419.594, 31.48952,600},
    {-2554.996, 2334.402, 33.07803,600},
    {-1800.375, 803.6619, 138.6512,600},
    {-1437.622, -276.7476, 46.20771,600},
    {-2096.243, -320.2867, 13.16857,600},
    {-724.6192, -935.1631, 19.21386,600},
    {-526.0198, -1211.003, 18.18483,600},
    {-70.21484, -1761.792, 29.53402,600},
    {265.6484,-1261.309, 29.29294,600},
    {819.6538,-1028.846, 26.40342,780},
    {1208.951,-1402.567, 35.22419,900},
    {1181.381,-330.8471, 69.31651,900},
    {620.8434, 269.1009, 103.0895,780},
    {2581.321, 362.0393, 108.4688,1500},
    {1785.363, 3330.372, 41.38188,1200},
    {-319.537, -1471.5116, 30.54118,600},
    {-66.58, -2532.56, 6.14, 400},
    {963.27960205078, -1750.0816650391, 21.025255203247}
}

function getVehicleInDirection(coordFrom, coordTo)
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
    
    if distance > 3000 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end
local showGasStations = false

RegisterNetEvent('CarPlayerHud:ToggleGas')
AddEventHandler('CarPlayerHud:ToggleGas', function()
    showGasStations = not showGasStations
   for _, item in pairs(gasStations) do
        if not showGasStations then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 361)
            SetBlipScale(item.blip, 0.4)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Gas")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)
    showGasStations = true
    TriggerEvent('CarPlayerHud:ToggleGas')
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end




function TargetVehicle()
    playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    return targetVehicle
end

function IsNearGasStations()
    local location = {}
    local hasFound = false
    local pos = GetEntityCoords(PlayerPedId(), false)
    for k,v in ipairs(gasStations) do
        if(Vdist(v[1], v[2], v[3], pos.x, pos.y, pos.z) < 22.0)then
            location = {v[1], v[2], v[3],v[4]}
            hasFound = true
        end
    end


    if hasFound then return location,true end
    return {},false
end




RegisterNetEvent("RefuelCarServerReturn")
AddEventHandler("RefuelCarServerReturn",function()
    local veh = TargetVehicle()
    local curFuel = DecorGetInt(veh, "CurrentFuel")
    local timer = (100 - curFuel) * 400
    refillVehicle()
    local finished = exports["ucrp-taskbar"]:taskBar(timer,"Refueling")
    local veh = TargetVehicle()

    if finished == 100 then
        DecorSetInt(veh, "CurrentFuel", 100)
    else

        local curFuel = DecorGetInt(veh, "CurrentFuel")
        local endFuel = (100 - curFuel) 
        endFuel = math.ceil(endFuel * (finished / 100) + curFuel)
        DecorSetInt(veh, "CurrentFuel", endFuel)

    end
    
    endanimation()
end)

RegisterNetEvent("RefuelCarServerReturn2")
AddEventHandler("RefuelCarServerReturn2",function()
    local veh = TargetVehicle()
    local curFuel = DecorGetInt(veh, "CurrentFuel")
    local timer = (100 - curFuel) * 400
    refillVehicle()
    local finished = exports["ucrp-taskbar"]:taskBar(timer,"Refueling")
    local veh = TargetVehicle()

    if finished == 100 then
        DecorSetInt(veh, "CurrentFuel", 100)
    else

        local curFuel = DecorGetInt(veh, "CurrentFuel")
        local endFuel = (100 - curFuel) 
        endFuel = math.ceil(endFuel * (finished / 100) + curFuel)
        DecorSetInt(veh, "CurrentFuel", endFuel)

    end
    
    endanimation()
    TriggerEvent("inventory:removeItem", "883325847", 1)
end)


function refillVehicle()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "weapon@w_sp_jerrycan" ) 
    TaskPlayAnim( PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    
end

function endanimation()
    shiftheld = false
    ctrlheld = false
    tabheld = false
    ClearPedTasksImmediately(PlayerPedId())
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function TargetVehicle()
    playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    return targetVehicle
end




function round( n )
    return math.floor( n + 0.5 )
end

Fuel = 45
DrivingSet = false
LastVehicle = nil
lastupdate = 0
local fuelMulti = 0

RegisterNetEvent("carHud:FuelMulti")
AddEventHandler("carHud:FuelMulti",function(multi)
    fuelMulti = multi
end)


alarmset = false

RegisterNetEvent("CarFuelAlarm")
AddEventHandler("CarFuelAlarm",function()
    if not alarmset then
        alarmset = true
        local i = 5
        TriggerEvent("DoLongHudText", "Low fuel.",1)
        while i > 0 do
            PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
            i = i - 1
            Citizen.Wait(300)
        end
        Citizen.Wait(60000)
        alarmset = false
    end
end)
function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end



-- local nos = 0
-- local nosEnabled = false
-- RegisterNetEvent("noshud")
-- AddEventHandler("noshud", function(_nos, _nosEnabled)
--     if _nos == nil then
--         nos = 0
--     else
--         nos = _nos
--     end
--     nosEnabled = _nosEnabled
-- end)


RegisterNetEvent("ucrp-jobmanager:playerBecameJob")
AddEventHandler("ucrp-jobmanager:playerBecameJob", function(job, name)
    if job ~= "police" then isCop = false else isCop = true end
end)
local time = "12:00"




local counter = 0
local Mph = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936
local uiopen = false
local colorblind = false
local compass_on = false
local WaitTime = 50


RegisterNetEvent('option:colorblind')
AddEventHandler('option:colorblind',function()
    colorblind = not colorblind
end)

RegisterNetEvent('unwind-hud:changefps')
AddEventHandler('unwind-hud:changefps',function(Value)
    if Value == 60 then
        WaitTime = 50
    elseif Value == 15 then
        WaitTime = 300
    elseif Value == 30 then
        WaitTime = 150
    elseif Value == 45 then
        WaitTime = 100
    end
end)

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(WaitTime)
        local player = PlayerPedId()
        local veh = GetVehiclePedIsIn(player, false)
        if IsVehicleEngineOn(veh) then          
            local x, y, z = table.unpack(GetEntityCoords(player, true))
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
            local time = CalculateTimeToDisplay()
            
            local zone = tostring(GetNameOfZone(x, y, z))
            local area = GetLabelText(zone)
            local playerStreetsLocation = area

            if not zone then
                zone = "UNKNOWN"
            end

            
            local veh = GetVehiclePedIsIn(player, false)
            if IsVehicleEngineOn(veh) then          

                if not uiopen then
                    uiopen = true
                    SendNUIMessage({
                    open = 1,
                    }) 
                end
                Mph = math.ceil(GetEntitySpeed(veh) * 2.236936)
                local atl = false
                if IsPedInAnyPlane(player) or IsPedInAnyHeli(player) then
                    atl = string.format("%.1f", GetEntityHeightAboveGround(veh) * 3.28084)
                end
                local engine = false
                if GetVehicleEngineHealth(veh) < 400.0 then
                    engine = true
                end
                local GasTank = false
                if GetVehiclePetrolTankHealth(veh) < 3002.0 then
                    GasTank = true
                end
                
                SendNUIMessage({
                open = 2,
                mph = Mph,
                fuel = math.ceil(Fuel),
                time = time.hour .. ':' .. time.minute,
                colorblind = colorblind,
                atl = atl,
                engine = engine,
                GasTank = GasTank,
                }) 
            else

                if uiopen and not compass_on then
                    SendNUIMessage({
                    open = 3,
                    }) 

                    uiopen = false
                end
            end
        else
            -- if not compass_on then

            SendNUIMessage({
                open = 3,
                }) 

                uiopen = false
            Citizen.Wait(1000)
            -- end
        end
    end
    Citizen.Wait(WaitTime)
end)

function CalculateTimeToDisplay()
    hour = GetClockHours()
    minute = GetClockMinutes()

    local obj = {}

    if hour <= 12 then
        obj.ampm = 'AM'
    elseif hour >= 13 then
        obj.ampm = 'PM'
        hour = hour - 12
    end

    if minute <= 9 then
        minute = "0" .. minute
    end

    obj.hour = hour
    obj.minute = minute

    return obj
end



Citizen.CreateThread(function()

    while true do

        Citizen.Wait(500)
        local player = PlayerPedId()

        if (IsPedInAnyVehicle(player, false)) then

            local veh = GetVehiclePedIsIn(player,false)

            if GetPedInVehicleSeat(veh, -1) == player then

                if not DrivingSet then


                    if LastVehicle ~= veh then
                        if not DecorExistOn(veh, "CurrentFuel") then
                            Fuel = math.random(80,100)
                        else
                            Fuel = DecorGetInt(veh, "CurrentFuel")
                        end
                    else
                        Fuel = DecorGetInt(veh, "CurrentFuel")
                    end

                    DrivingSet = true
                    LastVehicle = veh
                    lastupdate = 0

                    if not DecorExistOn(veh, "CurrentFuel") then 
                        Fuel = math.random(80,100)
                        DecorSetInt(veh, "CurrentFuel", round(Fuel))
                    end

                else

                    if Fuel > 105 then
                        Fuel = DecorGetInt(veh, "CurrentFuel")
                    end                     
                    if Fuel == 101 then
                        Fuel = DecorGetInt(veh, "CurrentFuel")
                    end

                end

                if ( lastupdate > 300) then
                    DecorSetInt(veh, "CurrentFuel", round(Fuel))
                    lasteupdate = 0
                end

                lastupdate = lastupdate + 1

                if Fuel > 0 then
                    if IsVehicleEngineOn(veh) then
                        local fueltankhealth = GetVehiclePetrolTankHealth(veh)
                        if fueltankhealth == 1000.0 then
                            SetVehiclePetrolTankHealth(veh, 4000.0)
                        end
                        local algofuel = GetEntitySpeed(GetVehiclePedIsIn(player, false)) * 2.4
                        if algofuel > 160 then
                            algofuel = algofuel * 1.8
                        else
                            algofuel = algofuel / 2.0
                        end
                        algofuel = algofuel / 15000

                        if algofuel == 0 then
                            algofuel = 0.0001
                        end

                        --TriggerEvent('chatMessage', '', { 0, 0, 0 }, '' .. algofuel .. '')
                        if IsPedInAnyBoat(PlayerPedId()) then
                            algofuel = 0.0090
                        end
                        if fuelMulti == 0 then fuelMulti = 1 end
                        local missingTankHealth = (4000 - fueltankhealth) / 1000

                        if missingTankHealth > 1 then
                            missingTankHealth = missingTankHealth * (missingTankHealth * missingTankHealth * 12)
                        end

                        local factorFuel = (algofuel + fuelMulti / 10000) * (missingTankHealth+1)
                        Fuel = Fuel - factorFuel
                        
                    end
                end



                if Fuel <= 4 and Fuel > 0 then
                    if not IsThisModelABike(GetEntityModel(veh)) then
                        local decayChance = math.random(20,100)
                        if decayChance > 90 then
                            SetVehicleEngineOn(veh,0,0,1)
                            SetVehicleUndriveable(veh,true)
                            Citizen.Wait(100)
                            SetVehicleEngineOn(veh,1,0,1)
                            SetVehicleUndriveable(veh,false)
                        end
                    end
                     
                end

                if Fuel < 15 then
                    if not IsThisModelABike(GetEntityModel(veh)) then
                        TriggerEvent("CarFuelAlarm")
                    end
                end

                if Fuel < 1 then

                    if Fuel ~= 0 then
                        Fuel = 0
                        DecorSetInt(veh, "CurrentFuel", round(Fuel))
                    end

                    if IsVehicleEngineOn(veh) or IsThisModelAHeli(GetEntityModel(veh)) then
                        SetVehicleEngineOn(veh,0,0,1)
                        SetVehicleUndriveable(veh,false)
                    end

                end

            end

        else

            if DrivingSet then
                DrivingSet = false
                DecorSetInt(LastVehicle, "CurrentFuel", round(Fuel))
            end
            Citizen.Wait(1500)
        end
    end
    Citizen.Wait(100)

end)

Controlkey = {["generalUse"] = {38,"E"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
    Controlkey["generalUse"] = table["generalUse"]
end)

function NearGasFn()
    return NearGas
end


Citizen.CreateThread(function()
    local bool = false
    local counter = 0
    while true do
        Citizen.Wait(500)

        if counter == 0 then
            loc,bool = IsNearGasStations()
            counter = 5
        end
        counter = counter - 1
        if bool == true then

            -- local veh = TargetVehicle()

            -- if DoesEntityExist(veh) and IsEntityAVehicle(veh) and #(GetEntityCoords(veh) - GetEntityCoords(PlayerPedId())) < 5.0 then

                -- curFuel = DecorGetInt(veh, "CurrentFuel")
                -- costs = (100 - curFuel)
                -- if costs < 0 then
                --     costs = 0
                -- end
                NearGas = true
                --info = string.format("Press ~g~"..Controlkey["generalUse"][2].."~s~ to refuel your vehicle | ~g~$%s + tax", costs)
                --local crd = GetEntityCoords(veh)
                --DrawMarker(2,crd["x"],crd["y"],crd["z"]+1.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 100, 15, 15, 130, 0, 0, 0, 0)
                --DisplayHelpText(info)
                -- if IsControlJustPressed(1, Controlkey["generalUse"][1]) then
                --     if curFuel >= 100 then
                --         PlaySound(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
                --         TriggerEvent('customNotification', "You are already full!") 
                --     else
                --         costs = math.ceil(costs)
                --         TriggerServerEvent("carfill:checkmoney",costs,loc)
                --     end
                -- end
            -- end
            Citizen.Wait(1)
        else
            NearGas = false
            Citizen.Wait(500)
        end

    end
    Citizen.Wait(100)
end)




-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(8)
--         local player = PlayerPedId()
--         local targetVehicle = GetVehiclePedIsIn(player, false) 
--         if IsPedInAnyVehicle(PlayerPedId(), false) then
--             if seatbelt then 
--                 DisableControlAction(0,23,true)
--             else
                
--             end
--         end
--     end
-- end)


local speedBuffer  = {}
local velBuffer    = {}
local wasInCar     = false
local carspeed = 0
local speed = 0

-- Citizen.CreateThread(function()
--  Citizen.Wait(500)
--   while true do
--    local ped = GetPlayerPed(-1)
--    local car = GetVehiclePedIsIn(ped)
--    if not IsPedInAnyVehicle(ped, false) then
--         cruiseIsOn = false
--    end
--    if car ~= 0 and (wasInCar or IsCar(car)) then
--     wasInCar = true

    

--     speedBuffer[2] = speedBuffer[1]
--     speedBuffer[1] = GetEntitySpeed(car)
--     if speedBuffer[2] ~= nil and GetEntitySpeedVector(car, true).y > 1.0 and speedBuffer[2] > 18.00 and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[2] * 0.465) then
--     local co = GetEntityCoords(ped, true)
--     local fw = Fwv(ped)
--     SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z, true, true, true)
--     SetEntityVelocity(ped, velBuffer[2].x-10/2, velBuffer[2].y-10/2, velBuffer[2].z-10/4)
--     Citizen.Wait(1)
--     SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
--    end
--     velBuffer[2] = velBuffer[1]
--     velBuffer[1] = GetEntityVelocity(car)

--    elseif wasInCar then
--     wasInCar = false
--     speedBuffer[1], speedBuffer[2] = 0.0, 0.0
--    end
--    Citizen.Wait(5)
--    speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6)
--   end
-- end)

function IsCar(veh)
 local vc = GetVehicleClass(veh)
 return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end

function Fwv(entity)
 local hr = GetEntityHeading(entity) + 90.0
 if hr < 0.0 then hr = 360.0 + hr end
 hr = hr * 0.0174533
 return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end


RegisterNetEvent("vehicle:refuel:menu")
AddEventHandler("vehicle:refuel:menu", function()
    local veh = TargetVehicle()
    local curFuel = DecorGetInt(veh, "CurrentFuel")
    local costs = (200 - curFuel)
    if costs < 0 then
        costs = 0
    end
    if DoesEntityExist(veh) and IsEntityAVehicle(veh) and #(GetEntityCoords(veh) - GetEntityCoords(PlayerPedId())) < 5.0 then
        if curFuel >= 100 then
            TriggerEvent("DoLongHudText", "You are already full !",6)
        else
            costs = costs + costs * (0.5)
            costs = math.ceil(costs)
            TriggerEvent('ucrp-context:sendMenu', {
                {
                    id = 1,
                    header = 'Gas Station',
                    txt = 'The total cost is going to be $' .. costs..", including 10% taxes.",
                    params = {
                        event = "vehicle:refuel:pay",
                        args = costs
                    }
                },
            })
        end
    end
end)

RegisterNetEvent("vehicle:refuel:pay")
AddEventHandler("vehicle:refuel:pay", function(costs)
    costs = math.ceil(costs)
    TriggerServerEvent("carfill:checkmoney",costs)
end)
        
