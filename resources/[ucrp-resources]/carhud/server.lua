RegisterServerEvent('GPSTrack:Accepted')
AddEventHandler('GPSTrack:Accepted', function(x,y,z,stage)
	local srcid = source
	TriggerClientEvent("GPSTrack:Accepted",-1,x,y,z,srcid,stage)
end)


RegisterServerEvent('car:spotlight')
AddEventHandler('car:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('car:spotlight', -1, serverID, state)
end)

RegisterNetEvent("facewear:adjust")
AddEventHandler("facewear:adjust", function(pTargetId, pType, pShouldRemove)
	TriggerClientEvent("facewear:adjust", pTargetId, pType, pShouldRemove)
end)

RegisterCommand("anchor", function(source, args, rawCommand)
    TriggerClientEvent('client:anchor', source)
end)

RegisterServerEvent("actionclose")
AddEventHandler("actionclose", function(string, Coords)
	TriggerClientEvent("Do3DText", -1, string, source, Coords)
end)

RegisterServerEvent('carfill:checkmoney')
AddEventHandler('carfill:checkmoney', function(costs)
	local src = source
	local player = exports["ucrp-base"]:getModule("Player"):GetUser(src)

	if player:getCash() >= costs then --- MintHavoc Change Banking
		TriggerClientEvent("RefuelCarServerReturn", src)
		player:removeMoney(costs) --- MintHavoc Change Banking
	else
		moneyleft = costs - player:getCash()
		TriggerClientEvent('DoLongHudText', src, "Requires $" .. costs)
	end
end)



  local vehiclesKHM = {}

Citizen.CreateThread(function()
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "vehicles.json")
    vehiclesKHM = json.decode(loadFile)
end)


RegisterServerEvent("hud:server:vehiclesKHM")
AddEventHandler("hud:server:vehiclesKHM", function(plate,kmh)
    if plate and kmh and type(vehiclesKHM) == 'table' then
        vehiclesKHM[plate] = kmh
        SaveResourceFile(GetCurrentResourceName(), "vehicles.json", json.encode(vehiclesKHM), -1)
        TriggerClientEvent("hud:client:vehiclesKHM", -1, plate,kmh)
    end
end)

RegisterServerEvent("hud:server:requestTable")
AddEventHandler("hud:server:requestTable", function()
    TriggerClientEvent("hud:client:vehiclesKHMTable", source, vehiclesKHM)
end)
