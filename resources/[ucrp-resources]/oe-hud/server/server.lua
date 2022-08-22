RegisterNetEvent("hud-getping:sv")
AddEventHandler("hud-getping:sv", function()
    local src = source 
    local ping = GetPlayerPing(src)
    TriggerClientEvent("hud-getping:cl", src, ping)
end)

RegisterServerEvent("vehicleMod:createHarness")
AddEventHandler("vehicleMod:createHarness", function(plate, durability)
    local src = source

    exports.ghmattimysql:execute("UPDATE characters_cars SET harness = @durability",
    {
--[[         ['harness'] = harness, ]]
        ['durability'] = durability
    }, function()
    end)
end)

RegisterServerEvent("vehicleMod:updateHarness")
AddEventHandler("vehicleMod:updateHarness", function(plate, durability)
    local src = source
    
    exports.ghmattimysql:execute("UPDATE characters_cars SET harness = @durability",
    {
        ['durability'] = durability
    }, function()
    end)
end)

RegisterServerEvent('ucrp-hud:UpdateStress_SV')
AddEventHandler('ucrp-hud:UpdateStress_SV',function(amount)
	local src = source
	local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
	local characterId = user:getCurrentCharacter().id
	exports.oxmysql:execute("UPDATE characters SET `stress_level` = ? WHERE id = ?",{amount, characterId})
end)

RegisterServerEvent('police:SetMeta')
AddEventHandler('police:SetMeta', function()
    local src = source
	local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.oxmysql:execute("SELECT * FROM characters WHERE id = ?", {cid}, function(result)
        TriggerClientEvent("police:setClientMeta", src, json.decode(result[1].metaData))
		TriggerClientEvent('client:updateStress', src, result[1].stress_level)
	end)
end)

RegisterServerEvent("police:update:hud")
AddEventHandler("police:update:hud", function(health, armour, thirst, hunger)
    local src = source
	local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
	local characterId = user:getCurrentCharacter().id
	if user ~= false then
		meta = { 
			["health"] = health,
			["armour"] = armour,
			["thirst"] = thirst,
			["hunger"] = hunger
		}

		local encode = json.encode(meta)
		exports.oxmysql:execute('UPDATE characters SET metaData = ? WHERE id = ?', {encode, characterId})
	end
end)

RegisterServerEvent('server:alterStress')
AddEventHandler('server:alterStress',function(positive, alteredValue)
	local src = source
	local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
	local characterId = user:getCurrentCharacter().id
	exports.oxmysql:execute("SELECT * FROM characters WHERE id = ?", {characterId}, function(result)
		local myStress = result[1].stress_level
		Citizen.Wait(500)
		if positive then
			if myStress < tonumber(10000) then
				newStress = myStress + alteredValue
				exports.oxmysql:execute("UPDATE characters SET `stress_level` = ? WHERE id = ?",{newStress, characterId})
				TriggerClientEvent('client:updateStress', src, newStress)
			end
		else
			if myStress > tonumber(1000) then
				Stress = myStress - alteredValue
				exports.oxmysql:execute("UPDATE characters SET `stress_level` = ? WHERE id = ?",{Stress, characterId})
				TriggerClientEvent('client:updateStress', src, Stress)
            else
                exports.oxmysql:execute("UPDATE characters SET `stress_level` = ? WHERE id = ?",{0, characterId})
				TriggerClientEvent('client:updateStress', src, 0)
			end
		end
	end)
end)
