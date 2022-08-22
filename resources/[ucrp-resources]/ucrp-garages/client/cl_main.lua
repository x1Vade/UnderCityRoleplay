RegisterNetEvent("ucrp-garages:open")
AddEventHandler("ucrp-garages:open", function()
    local house = exports["ucrp-menu"]:NearHouseGarage()
    exports['ucrp-garages']:DeleteViewedCar()
    if house then
        RPC.execute("ucrp-garages:select", exports['ucrp-menu']:currentGarage())
    end
end)

RegisterNetEvent("ucrp-garages:open2")
AddEventHandler("ucrp-garages:open2", function()
    local house2 = exports["ucrp-menu"]:NearHouseGarage2()
    exports['ucrp-garages']:DeleteViewedCar()
    if house2 then
        RPC.execute("ucrp-garages:selectShared", exports['ucrp-menu']:currentGarage())
    end
end)

RegisterNetEvent("ucrp-garages:attempt:spawn", function(data, pRealSpawn)
    for ind, value in pairs(data) do
        if pRealSpawn then
        local house = exports["ucrp-menu"]:NearHouseGarage()
            if house then
                RPC.execute("ucrp-garages:attempt:sv", value.id)
                SpawnVehicle(value.model, exports['ucrp-menu']:currentGarage(), value.fuel, value.data, value.license_plate, true)
            end
        else
            SpawnVehicle(value.model, exports['ucrp-menu']:currentGarage(), value.fuel, value.data, value.license_plate, false)
        end
    end
end)

RegisterNetEvent("ucrp-garages:attempt:spawn2", function(data, pRealSpawn)
    for ind, value in pairs(data) do
        if pRealSpawn then
        local house2 = exports["ucrp-menu"]:NearHouseGarage2()
            if house2 then
                RPC.execute("ucrp-garages:attempt:sv2", value.id)
                SpawnVehicle(value.model, exports['ucrp-menu']:currentGarage(), value.fuel, value.data, value.license_plate, true)
            end
        else
            SpawnVehicle(value.model, exports['ucrp-menu']:currentGarage(), value.fuel, value.data, value.license_plate, false)
        end
    end
end)

RegisterNetEvent("ucrp-garages:takeout", function(pData)
    local house = exports["ucrp-menu"]:NearHouseGarage()
    if house then
        RPC.execute("ucrp-garages:spawned:get", pData)
    end
end)

RegisterNetEvent("ucrp-garages:takeout2", function(pData)
    local house2 = exports["ucrp-menu"]:NearHouseGarage2()
    if house2 then
        RPC.execute("ucrp-garages:spawned:getShared", pData)
    end
end)

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
    }
  
    local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
  
function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end
  
function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end
  
function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
  
function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

RegisterNetEvent("ucrp-garages:resetcartoimpound", function(plate)
    local found = false
    for vehicle in EnumerateVehicles() do
        if plate == GetVehicleNumberPlateText(vehicle) then
            found = true
        end

        if not found then
            TriggerServerEvent("ucrp-garages:resetcartoimpound",plate)
        end
    end
end)


RegisterNetEvent("ucrp-garages:store", function()
    local pos = GetEntityCoords(PlayerPedId())
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local curVeh = exports['ucrp-garages']:getVehicleInDirection(coordA, coordB)
    if (curVeh ~= 0) then
        local Stored = RPC.execute("ucrp-garages:states", "In", exports["ucrp-garages"]:NearVehicle("plate"), exports['ucrp-menu']:currentGarage(), exports["ucrp-garages"]:NearVehicle("Fuel"))
        if Stored then
            DeleteVehicle(curVeh)
            DeleteEntity(curVeh)
            TriggerEvent('keys:remove', exports["ucrp-garages"]:NearVehicle("plate"))
            TriggerEvent("DoLongHudText", "Vehicle stored in garage: " ..exports['ucrp-menu']:currentGarage())
        else
            TriggerEvent("DoLongHudText", "You cant store local cars!", 2)
        end
    else
        TriggerEvent("DoLongHudText", "You need to look at the vehicle in order to store it!", 2)
    end
end)

RegisterNetEvent("ucrp-garages:resetpdgarage", function()
    local myJob = exports["isPed"]:isPed("myJob")
    if myJob == "police" then
        TriggerServerEvent("ucrp-garages:resetpdgarage")
    else
        TriggerEvent("DoLongHudText", "Only for police officers!", 2)
    end
end)

Citizen.CreateThread(function()
    for _, item in pairs(Garages) do
        if item.blip ~= nil then
            Garage = AddBlipForCoord(item.blip.x, item.blip.y, item.blip.z)

            SetBlipSprite (Garage, 357)
            SetBlipDisplay(Garage, 4)
            SetBlipScale  (Garage, 0.5)
            SetBlipAsShortRange(Garage, true)
            SetBlipColour(Garage, 3)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(item.name)
            EndTextCommandSetBlipName(Garage)
        end
    end
end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(10000)
--         TriggerServerEvent("garages:carisout")
--     end
-- end)

exports("NearVehicle", function(pType)
    if pType == "Distance" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return true
        else
            return false
        end
    elseif pType == "plate" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return GetVehicleNumberPlateText(vehicle)
        else
            return false
        end
    elseif pType == "Fuel" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return  GetVehicleFuelLevel(vehicle)
        else
            return false
        end
    elseif pType == "sittingplate" then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            return GetVehicleNumberPlateText(vehicle)
        else
            return false
        end
    end
end)

exports("getVehicleInDirection", function(coordA, coordB)
    return getVehicleInDirection(coordA, coordB)
end)

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
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

-- PolyZone stuff
AddEventHandler("ucrp-polyzone:enter", function(zone, data)
    if zone ~= "Police Shared" then return end
    local plyPed = PlayerPedId()
    local job = exports["isPed"]:isPed("myJob")

    if plyPed then
        if job == "police" or job == "doc" or job == "judge" then
            exports["ucrp-ui"]:showInteraction("Shared PD")
        end
    end
end)

AddEventHandler("ucrp-polyzone:exit", function(zone)
    if zone ~= "Police Shared" then return end
    exports["ucrp-ui"]:hideInteraction()
end)



    