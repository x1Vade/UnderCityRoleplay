local plateChanges = {}

local function findPlate(plate)
    for k,v in pairs(plateChanges) do
        if plate == v then
            return k
        end
    end
    return nil
end



RegisterServerEvent("carhud:ejection:server")
AddEventHandler("carhud:ejection:server", function(value)
    TriggerClientEvent("carhud:ejection:client", source, value)
end)

RegisterServerEvent("vehicleMod:getHarness")
AddEventHandler("vehicleMod:getHarness", function(plate)
    local src = source
    
    if plateChanges[plate] ~= nil then
        plate = plateChanges[plate]
    end 
    exports.ghmattimysql:execute("SELECT harness FROM characters_cars WHERE license_plate = @plate", {['plate'] = plate}, function(result)
        if (result ~= nil and result[1] ~= nil) then
            TriggerClientEvent("vehicleMod:setHarness", src, result[1].harness, false)
        else
            TriggerClientEvent("vehicleMod:setHarness", src, false, false)
        end
    end)
end)

RegisterServerEvent("vehicleMod:applyHarness")
AddEventHandler("vehicleMod:applyHarness", function(plate, durability)
    local src = source
    
    if plateChanges[plate] ~= nil then
        plate = plateChanges[plate]
    end

    exports.ghmattimysql:execute("UPDATE characters_cars SET harness = @durability WHERE license_plate = @plate",
    {
        ['plate'] = plate,
        ['durability'] = durability
    }, function(result)
        if result ~= nil and result.changedRows ~= 0 then
            TriggerClientEvent("vehicleMod:setHarness", src, durability, true)
        else
            TriggerClientEvent("vehicleMod:setHarness", src, false, true)
        end
    end)
end)

--[[ RegisterServerEvent("vehicleMod:updateHarness")
AddEventHandler("vehicleMod:updateHarness", function(plate, durability)
    local src = source
    
    if plateChanges[plate] ~= nil then
        plate = plateChanges[plate]
    end
    
    exports.ghmattimysql:execute("UPDATE characters_cars SET harness = @durability WHERE license_plate = @plate",
    {
        ['plate'] = plate,
        ['durability'] = durability
    }, function()
    end)
end)
 ]]
RegisterServerEvent("vehicleMod:breakHarness")
AddEventHandler("vehicleMod:breakHarness", function(plate)
    local src = source
    
    if plateChanges[plate] ~= nil then
        plate = plateChanges[plate]
    end
    
    exports.ghmattimysql:execute("UPDATE characters_cars SET harness = @durability WHERE license_plate = @plate",
    {
        ['plate'] = plate,
        ['durability'] = 0
    }, function()
    end)
end)

RegisterServerEvent("NetworkNos")
AddEventHandler("NetworkNos", function()
    local pSrc = source
    TriggerClientEvent("NetworkNos", tonumber(pSrc))
end)




local plateChangesReturn = {}




RegisterServerEvent('fakeplate:change')
AddEventHandler('fakeplate:change', function(plate)
	local src = source
	if not plateChangesReturn[plate] then
		local newplate = ""
		for i = 1, 8 do 
			local entry = math.random(50) >= 25 and string.char(math.random(65, 90)) or tostring(math.random(0, 9))
			newplate = newplate .. entry
		end
		newplate = string.upper(tostring(newplate))
		plateChanges[plate] = newplate
		TriggerEvent("fakeplates:changed",newplate)
		plateChangesReturn[newplate] = plate
		TriggerEvent("vehicleMod:changePlate", newplate, true, plate)
		TriggerClientEvent("fakeplate:accepted",src,newplate,true,plate)
	else
		local oldPlate = plateChangesReturn[plate]
		TriggerEvent("vehicleMod:changePlate", oldPlate, false)
		TriggerClientEvent("fakeplate:accepted",src,oldPlate,false)
		plateChanges[oldPlate] = nil
		plateChangesReturn[plate] = nil
	end
end)
-- Fake Plate

RegisterServerEvent("transfer:attempt:send")
AddEventHandler("transfer:attempt:send", function(plate, target)
    local pSrc = source
    local pUser = exports["ucrp-base"]:getModule("Player"):GetUser(pSrc)
    local pChar = pUser:getCurrentCharacter().id
    local pSteam = GetPlayerIdentifiers(pSrc)[1]

    -- target shit
    local tUser = exports["ucrp-base"]:getModule("Player"):GetUser(target)
    local tChar = tUser:getCurrentCharacter().id
    local tSteam = GetPlayerIdentifiers(target)[1]
    local tChar2 = tUser:getCurrentCharacter()
    local tName = tChar2.first_name.. ' ' ..tChar2.last_name

    exports.ghmattimysql:execute("SELECT * FROM characters_cars WHERE cid = ? AND license_plate = ?",{pChar, plate}, function(data)
        if data[1] then
            exports.ghmattimysql:execute("UPDATE characters_cars SET `cid` = @cid, `owner` = @owner WHERE license_plate = @license_plate", {
                ['cid'] = tChar, 
                ['owner'] = tName,
                ['license_plate'] = plate
            })
            TriggerClientEvent("DoLongHudText", pSrc, "You have successfully transfered this vehicle!")
            TriggerClientEvent("DoLongHudText", target, "You have successfully received keys to your new ride!")
            TriggerClientEvent("keys:remove", pSrc, plate)
            TriggerClientEvent('keys:received', target, plate)
        else
            TriggerClientEvent("DoLongHudText", pSrc, "You dont own this vehicle", 2)
        end

    end)
end)

