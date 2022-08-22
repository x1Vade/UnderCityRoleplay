function isPlayerHayes()
    local mypasses = exports["isPed"]:isPed("passes")
    for i=1, #mypasses do
        if mypasses[i]["pass_type"] == "hayes_autos" then

            return true
            
        end
    end
    return false
end


Citizen.CreateThread(function()

    exports["ucrp-polytarget"]:AddBoxZone("ucrp-hayes:storage", vector3(-1408.22, -448.01, 35.91), 5, 1, {
        heading=300,       
        minZ=35.91-1,
        maxZ=35.91+1,
    })
    exports["ucrp-polytarget"]:AddBoxZone("ucrp-hayes:craft", vector3(-1414.77, -452.06, 35.91), 5, 1, {
        heading=300,       
        minZ=35.91-1,
        maxZ=35.91+1,
    })

end)


RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    local isHayes = isPlayerHayes()

    if name == "ucrp-hayes:storage" and isHayes then
        HayesStorageSpot = true
        exports["ucrp-ui"]:showInteraction("[E] Storage")
        HayesSorageFunction()
    elseif name == "ucrp-hayes:craft" and isHayes then
        HayesCraftSpot = true
        exports["ucrp-ui"]:showInteraction("[E] Craft")
        CraftFunction()
    end
end)

RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name == "ucrp-hayes:storage" then
        HayesStorageSpot = false
    elseif name == "ucrp-hayes:craft" then
        HayesCraftSpot = false
    end
    exports["ucrp-ui"]:hideInteraction()
end)

function CraftFunction()
    Citizen.CreateThread(function()
        while HayesCraftSpot do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                local finished = exports["ucrp-taskbar"]:taskBar(2000,"Opening Craft")
                if finished == 100 then
                    TriggerEvent("server-inventory-open", "515", "Craft")
                    HayesCraftSpot = false
                    exports["ucrp-ui"]:hideInteraction()
                end
            end
        end
    end)
end


function HayesSorageFunction()
    Citizen.CreateThread(function()
        while HayesStorageSpot do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                local finished = exports["ucrp-taskbar"]:taskBar(2000,"Opening Storage")
                if finished == 100 then
                    TriggerEvent("server-inventory-open", "1", "Hayes-stash")
                    HayesStorageSpot = false
                    exports["ucrp-ui"]:hideInteraction()
                end
            end
        end
    end)
end

local degHealth = {
	["breaks"] = 0,-- has neg effect
	["axle"] = 0,	-- has neg effect
	["radiator"] = 0, -- has neg effect 
	["clutch"] = 0,	-- has neg effect
	["transmission"] = 0, -- has neg effect
	["electronics"] = 0, -- has neg effect
	["fuel_injector"] = 0, -- has neg effect
	["fuel_tank"] = 0 -- has neg effect
}

RegisterNetEvent("mech:tools")
AddEventHandler("mech:tools", function(material, amount)
    local shop = exports["isPed"]:isPed("myJob")
    if exports["ucrp-inventory"]:hasEnoughOfItem(material, amount,false) then
        TriggerServerEvent("mech:add:materials", material, amount, shop)
    else
        TriggerEvent('DoLongHudText', 'You don\'t have the materials', 2)
    end
end)


RegisterNetEvent("mech:tools:cl")
AddEventHandler("mech:tools:cl", function(materials, amount, deg, plate)
    local shop = exports["isPed"]:isPed("myJob")
    TriggerServerEvent("mech:remove:materials", materials, amount, deg, plate, shop)
end)

RegisterNetEvent("mech:tools:cl2")
AddEventHandler("mech:tools:cl2", function(input)
    local isHayes = isPlayerHayes()
    if isHayes then
        local degname = string.lower(input)
        local itemname = "vehrepairitem"
        local current = 100



        if degname == "body" then
            degname = "body"
        end

        if degname == "engine" then
            degname = "engine"
        end

        if degname == "brakes" then
            degname = "breaks"
            current = degHealth["breaks"]
        end

        if  degname == "axle" then
            degname = "axle"
            current = degHealth["axle"]
        end

        if degname == "radiator" then
            degname = "radiator"
            current = degHealth["radiator"]
        end

        if degname == "clutch" then
            degname = "clutch"
            current = degHealth["clutch"]
        end

        if degname == "electronics" then
            degname = "electronics"
            current = degHealth["electronics"]
        end

        if degname == "fuel" then
            degname = "fuel_tank"
            current = degHealth["fuel_tank"]
        end

        if degname == "transmission"then
            current = degHealth["transmission"]
        end

        if degname == "injector" then
            degname = "fuel_injector"
            current = degHealth["fuel_injector"]
        end

        
        if exports["ucrp-inventory"]:hasEnoughOfItem(itemname,1,false) then
            RequestAnimDict("mp_car_bomb")
            TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)
            Wait(100)
            TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports["ucrp-taskbar"]:taskBar(35000,"Repairing")
            local coordA = GetEntityCoords(PlayerPedId(), 1)
            local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
            local targetVehicle = getVehicleInDirection(coordA, coordB)
            local plate = GetVehicleNumberPlateText(targetVehicle)
            if finished == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                if targetVehicle ~= 0 then
                    if itemname ~= "" then
                        TriggerServerEvent('scrap:towTake', degname, itemname, plate)
                    else
                        TriggerEvent('DoLongHudText', 'Vehicle Part does not exist!', 2)
                    end
                else
                    TriggerEvent('DoLongHudText', 'No Vehicle!', 2)
                end
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        else
            TriggerEvent('DoLongHudText', "You are missing a repair item", 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You need a hayes worker', 2)
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


RegisterNetEvent('towgarage:repairamount')
AddEventHandler('towgarage:repairamount', function(data)
	local playerped = PlayerPedId()
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	local plate = GetVehicleNumberPlateText(targetVehicle)
	local part = data.part
	if #(vector3(-1417.2585449219, -446.45681762695, 35.470108032227) - GetEntityCoords(PlayerPedId())) < 35 then
        local isHayes = isPlayerHayes()
		if isHayes then
			TriggerEvent('mech:tools:cl2', part)
        else
            TriggerEvent("DoLongHudText","You can't do that!",1)
        end
	end
end)

RegisterNetEvent('ucrp-towjob:StoreMaterialsMain')
AddEventHandler('ucrp-towjob:StoreMaterialsMain', function()
	-- if #(vector3(128.89631652832, -3008.9848632813, 7.0401978492737) - GetEntityCoords(PlayerPedId())) < 35 then
        -- local job = exports["isPed"]:GroupRank('auto_bodies')
		-- if job >= 1 then
		local keyboard = exports["ucrp-applications"]:KeyboardInput({
				header = "Store Materials",
				rows = {
				{
					id = 0, 
					txt = "Material Name"
				},
                {
					id = 1, 
					txt = "Amount"
				}
			}
		})
        if keyboard ~= nil then
			if keyboard[1].input == nil then return end
				TriggerEvent('mech:tools', keyboard[1].input, keyboard[2].input)
			end
		-- end
	
end)

RegisterNetEvent("mech:check:internal:storage")
AddEventHandler("mech:check:internal:storage", function()
    -- local job = exports["isPed"]:GroupRank('auto_bodies')
    -- if job >= 1 then
        TriggerServerEvent("mech:check:materials", 'tuner_mech')
    -- else 
    --     TriggerEvent('DoLongHudText', 'You are not a ak customs worker!', 2)
    -- end
end)

RegisterNetEvent("mech:check:internal:storagehayes")
AddEventHandler("mech:check:internal:storagehayes", function()
    -- local job = exports["isPed"]:GroupRank('auto_bodies')
    -- if job >= 1 then
        TriggerServerEvent("mech:check:materials", 'auto_bodies')
    -- else 
    --     TriggerEvent('DoLongHudText', 'You are not a ak customs worker!', 2)
    -- end
end)

RegisterNetEvent("mech:check:internal:storageharmony")
AddEventHandler("mech:check:internal:storageharmony", function()
    -- local job = exports["isPed"]:GroupRank('auto_bodies')
    -- if job >= 1 then
        TriggerServerEvent("mech:check:materials", 'repairs_harmony')
    -- else 
    --     TriggerEvent('DoLongHudText', 'You are not a ak customs worker!', 2)
    -- end
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
    end
end)


---------
-- local degHealth = {
-- 	["breaks"] = 0,-- has neg effect
-- 	["axle"] = 0,	-- has neg effect
-- 	["radiator"] = 0, -- has neg effect 
-- 	["clutch"] = 0,	-- has neg effect
-- 	["transmission"] = 0, -- has neg effect
-- 	["electronics"] = 0, -- has neg effect
-- 	["fuel_injector"] = 0, -- has neg effect
-- 	["fuel_tank"] = 0 -- has neg effect
-- }

-- RegisterNetEvent("mech:tools")
-- AddEventHandler("mech:tools", function(material, amount)
--     local shop = exports["isPed"]:isPed("myJob")
--     if exports["ucrp-inventory"]:hasEnoughOfItem(material, amount,false) then
--         TriggerServerEvent("mech:add:materials", material, amount, shop)
--     else
--         TriggerEvent('DoLongHudText', 'You don\'t have the materials', 2)
--     end
-- end)


-- RegisterNetEvent("mech:tools:cl")
-- AddEventHandler("mech:tools:cl", function(materials, amount, deg, plate)
--     local shop = exports["isPed"]:isPed("myJob")
--     TriggerServerEvent("mech:remove:materials", materials, amount, deg, plate, shop)
-- end)

-- RegisterNetEvent("mech:tools:cl2")
-- AddEventHandler("mech:tools:cl2", function(input, input2)
--     local job = exports["isPed"]:GroupRank('ak_customs')
--     if job >= 1 then
--         local degname = string.lower(input)
--         local amount = tonumber(input2)
--         local itemname = ""
--         local current = 100

--         if not amount then
--             TriggerEvent('DoLongHudText', 'Error: You need to do re enter a amount!', 2)
--             return
--         end

--         if degname == "body" then
--             TriggerEvent('DoLongHudText', 'This part is not degrading please repair it through the menu!', 2)
--         end

--         if degname == "engine" then
--             TriggerEvent('DoLongHudText', 'This part is not degrading please repair it through the menu!', 2)
--         end

--         if degname == "brakes" then
--             itemname = "rubber"
--             degname = "breaks"
--             current = degHealth["breaks"]
--         end

--         if  degname == "axle" then
--             degname = "axle"
--             itemname = "scrapmetal"
--             current = degHealth["axle"]
--         end

--         if degname == "radiator" then
--             degname = "radiator"
--             itemname = "scrapmetal"
--             current = degHealth["radiator"]
--         end

--         if degname == "clutch" then
--             degname = "clutch"
--             itemname = "scrapmetal"
--             current = degHealth["clutch"]
--         end

--         if degname == "electronics" then
--             degname = "electronics"
--             itemname = "plastic"
--             current = degHealth["electronics"]
--         end

--         if degname == "fuel" then
--             itemname = "steel"
--             degname = "fuel_tank"
--             current = degHealth["fuel_tank"]
--         end

--         if degname == "transmission"then
--             itemname = "aluminium"
--             current = degHealth["transmission"]
--         end

--         if degname == "injector" then
--             itemname = "copper"
--             degname = "fuel_injector"
--             current = degHealth["fuel_injector"]
--         end

--         if amount <= 10 then
--             RequestAnimDict("mp_car_bomb")
--             TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)
--             Wait(100)
--             TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)
--             FreezeEntityPosition(PlayerPedId(), true)
--             local finished = exports["ucrp-taskbar"]:taskBar(35000,"Repairing")
--             local coordA = GetEntityCoords(PlayerPedId(), 1)
--             local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
--             local targetVehicle = getVehicleInDirection(coordA, coordB)
--             local plate = GetVehicleNumberPlateText(targetVehicle)
--             if finished == 100 then
--                 FreezeEntityPosition(PlayerPedId(), false)
--                 if targetVehicle ~= 0 then
--                     if itemname ~= "" then
--                         TriggerServerEvent('scrap:towTake', degname, itemname, plate, amount, amount)
--                     else
--                         TriggerEvent('DoLongHudText', 'Vehicle Part does not exist!', 2)
--                     end
--                 else
--                     TriggerEvent('DoLongHudText', 'No Vehicle!', 2)
--                 end
--             else
--                 FreezeEntityPosition(PlayerPedId(), false)
--             end
--         else
--             TriggerEvent('DoLongHudText', 'You cant repair anything higher then 10!', 2)
--         end
       
--     end
-- end)

-- exports("getVehicleInDirection", function(coordA, coordB)
--     return getVehicleInDirection(coordA, coordB)
-- end)

-- function getVehicleInDirection(coordFrom, coordTo)
--     local offset = 0
--     local rayHandle
--     local vehicle

--     for i = 0, 100 do
--         rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
--         a, b, c, d, vehicle = GetRaycastResult(rayHandle)
--         offset = offset - 1
--         if vehicle ~= 0 then break end
--     end
    
--     local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
--     if distance > 25 then vehicle = nil end
--     return vehicle ~= nil and vehicle or 0
-- end

-- RegisterNetEvent('towgarage:repairamount')
-- AddEventHandler('towgarage:repairamount', function(data)
-- 	local playerped = PlayerPedId()
-- 	local coordA = GetEntityCoords(playerped, 1)
-- 	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
-- 	local targetVehicle = getVehicleInDirection(coordA, coordB)
-- 	local plate = GetVehicleNumberPlateText(targetVehicle)
--     local job = exports["isPed"]:GroupRank('ak_customs')

-- 	local part = data.part
-- 	if #(vector3(841.25274658203,-974.61096191406,26.482788085938) - GetEntityCoords(PlayerPedId())) < 35 then
-- 		if job >= 1 then
-- 			local keyboard = exports["ucrp-applications"]:KeyboardInput({
-- 				header = "Repair: ".. part,
-- 				rows = {
-- 				{
-- 					id = 0, 
-- 					txt = "Amount"
-- 				}
-- 			}
-- 		})
		
-- 		if keyboard ~= nil then
-- 			if keyboard[1].input == nil then return end
-- 				TriggerEvent('mech:tools:cl2', part, keyboard[1].input)
-- 			end
-- 		end
-- 	elseif #(vector3(1179.3099365234, 2635.9252929688, 184.25196838379) - GetEntityCoords(PlayerPedId())) < 160 then
-- 		if job >= 1 then
-- 			local keyboard = exports["ucrp-applications"]:KeyboardInput({
-- 				header = "Repair: ".. part,
-- 				rows = {
-- 				{
-- 					id = 0, 
-- 					txt = "Amount"
-- 				}
-- 			}
-- 		})
		
-- 		if keyboard ~= nil then
-- 			if keyboard[1].input == nil then return end
-- 				TriggerEvent('mech:tools:cl2', part, keyboard[1].input)
-- 			end
-- 		end
-- 	end
-- end)

-- RegisterNetEvent('ucrp-towjob:StoreMaterialsMain')
-- AddEventHandler('ucrp-towjob:StoreMaterialsMain', function()
-- 	if #(vector3(841.25274658203,-974.61096191406,26.482788085938) - GetEntityCoords(PlayerPedId())) < 35 or #(vector3(1179.3099365234, 2635.9252929688, 184.25196838379) - GetEntityCoords(PlayerPedId())) < 160 then
--         local job = exports["isPed"]:GroupRank('ak_customs')
-- 		if job >= 1 then
-- 			local keyboard = exports["ucrp-applications"]:KeyboardInput({
-- 				header = "Store Materials",
-- 				rows = {
-- 				{
-- 					id = 0, 
-- 					txt = "Material Name"
-- 				},
--                 {
-- 					id = 1, 
-- 					txt = "Amount"
-- 				}
-- 			}
-- 		})
--         if keyboard ~= nil then
-- 			if keyboard[1].input == nil then return end
-- 				TriggerEvent('mech:tools', keyboard[1].input, keyboard[2].input)
-- 			end
-- 		end
-- 	end
-- end)

-- RegisterNetEvent("mech:check:internal:storage")
-- AddEventHandler("mech:check:internal:storage", function()
--     local job = exports["isPed"]:GroupRank('ak_customs')
--     if job >= 1 then
--         TriggerServerEvent("mech:check:materials", 'ak_customs')
--     else
--         TriggerEvent('DoLongHudText', 'You are not a ak customs worker!', 2)
--     end
-- end)

-- function GetPlayers()
--     local players = {}

--     for i = 0, 255 do
--         if NetworkIsPlayerActive(i) then
--             players[#players+1]= i
--         end
--     end

--     return players
-- end

-- exports("NearVehicle", function(pType)
--     if pType == "Distance" then
--         local coords = GetEntityCoords(PlayerPedId())
--         if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
--             vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
--             return true
--         else
--             return false
--         end
--     elseif pType == "plate" then
--         local coords = GetEntityCoords(PlayerPedId())
--         if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
--             vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
--             return GetVehicleNumberPlateText(vehicle)
--         else
--             return false
--         end
--     elseif pType == "Fuel" then
--         local coords = GetEntityCoords(PlayerPedId())
--         if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
--             vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
--             return  GetVehicleFuelLevel(vehicle)
--         else
--             return false
--         end
--     end
-- end)

CurrentNetworkId, CurrentVehicle, CurrentSeat, IsDriving = nil, nil, nil, false

AddEventHandler('baseevents:enteredVehicle', function(pVehicle, pSeat, pName, pClass)
    CurrentSeat = pSeat
    CurrentVehicle = pVehicle
    CurrentNetworkId = NetworkGetNetworkIdFromEntity(pVehicle)

    IsDriving = pSeat == -1
end)

AddEventHandler('baseevents:leftVehicle', function(pVehicle, pSeat, pName, pClass)
    CurrentSeat = nil
    CurrentVehicle = nil
    CurrentNetworkId = nil
    IsDriving = false
end)

AddEventHandler('baseevents:vehicleChangedSeat', function(pVehicle, pCurrentSeat, pPreviousSeat)
    CurrentSeat = pCurrentSeat
    CurrentVehicle = pVehicle
    CurrentNetworkId = NetworkGetNetworkIdFromEntity(pVehicle)
    IsDriving = pCurrentSeat == -1
end)

AddEventHandler('baseevents:vehicleHotreload', function(pVehicle, pSeat, pEngineOn)
    CurrentSeat = pSeat
    CurrentVehicle = pVehicle
    CurrentNetworkId = NetworkGetNetworkIdFromEntity(pVehicle)
    IsDriving = pSeat == -1
end)


exports("HotwireVehicle",HotwireVehicle)

function GetVehicleIdentifier(pVehicle)
    local plat = GetVehicleNumberPlateText(pVehicle)
    return plat
end

exports("GetVehicleIdentifier",GetVehicleIdentifier)

function HasVehicleKey(pVehicle)
    --print("HasVehicleKey",pVehicle,GetVehicleNumberPlateText(pVehicle))
    return true
end

exports("HasVehicleKey",HasVehicleKey)

function GetVehicleDegradation(pVehicle)
    --print("GetVehicleDegradation",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("GetVehicleDegradation",GetVehicleDegradation)

function GetVehicleFuel(pVehicle)
    --print("GetVehicleFuel",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("GetVehicleFuel",GetVehicleFuel)

function CurrentFuel(pVehicle)
    print("CurrentFuel",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("CurrentFuel",CurrentFuel)

function IsOnParkingSpot(pEntity, pEntity, pRadius)
    return false
end

exports("IsOnParkingSpot",IsOnParkingSpot)

function VehicleHasHarness(pVehicle)
    print("VehicleHasHarness",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("VehicleHasHarness",VehicleHasHarness)

function GetHarnessLevel(pVehicle)
    --print("GetHarnessLevel",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("GetHarnessLevel",GetHarnessLevel)

--[[ function Harness(value)
    value = value
end

exports("Harness",Harness) ]]

function IsUsingNitro()
    return false
end

exports("IsUsingNitro",IsUsingNitro)

function VehicleHasNitro(pVehicle)
    print("VehicleHasNitro",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("VehicleHasNitro",VehicleHasNitro)

function GetNitroLevel(pVehicle)
   -- print("GetNitroLevel",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("GetNitroLevel",GetNitroLevel)

function GetVehicleMetadata(pVehicle, pKey)
   -- print("GetVehicleMetadata",pVehicle,pKey,GetVehicleNumberPlateText(pVehicle))
    return true
end

exports("GetVehicleMetadata",GetVehicleMetadata)

function TurnOnEngine(pVehicle, pInstant)
   -- print("TurnOnEngine",pVehicle,pInstant,GetVehicleNumberPlateText(pVehicle))
end

exports("TurnOnEngine",TurnOnEngine)

function TurnOffEngine(pVehicle, pInstant)
    --print("TurnOffEngine",pVehicle,pInstant,GetVehicleNumberPlateText(pVehicle))
end

exports("TurnOffEngine",TurnOffEngine)

function SwapVehicleSeat(pSeat, pVehicle)
   -- print("SwapVehicleSeat",pVehicle,pSeat,GetVehicleNumberPlateText(pVehicle))
end

exports("SwapVehicleSeat",SwapVehicleSeat)

function IsVinScratched(pVehicle)
   -- print("IsVinScratched",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("IsVinScratched",IsVinScratched)

RegisterNetEvent("vehicle:swapSeat")
AddEventHandler("vehicle:swapSeat", function(pSeatIndex)
  local playerPed = PlayerPedId();
  local pVehicle = GetVehiclePedIsIn(playerPed, false);
  if (pVehicle and IsVehicleSeatFree(pVehicle, pSeatIndex) or 1) then
    SetPedIntoVehicle(playerPed, pVehicle, pSeatIndex);
  end
end)


