Doors = {
    ["P1"] = {{loc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), txtloc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), state = nil, locked = true}},
}

RegisterServerEvent("ucrp-paleto:startcheck")
AddEventHandler("ucrp-paleto:startcheck", function(bank)
    local src = source

    if not Paleto.Banks[bank].onaction == true then
        if (os.time() - Paleto.cooldown) > Paleto.Banks[bank].lastrobbed then
            Paleto.Banks[bank].onaction = true
            TriggerClientEvent("ucrp-paleto:outcome", src, true, bank)
            TriggerClientEvent("ucrp-paleto:policenotify", -1, bank)
        else
            TriggerClientEvent("ucrp-paleto:outcome", src, false, "This bank recently robbed. You need to wait "..math.floor((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)), 60))
        end
    else
        TriggerClientEvent("ucrp-paleto:outcome", src, false, "This bank is currently being robbed.")
    end
end)

-- RegisterCommand("testy", function()
--     local src = source
--     local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
-- 	if Paleto.blackmoney then
--         TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
--         -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
--     else
--         if Paleto.blackmoney then
--             TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
--             -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
--         end
--     end
-- end)

RegisterServerEvent("ucrp-paleto:lootup")
AddEventHandler("ucrp-paleto:lootup", function(var, var2)
    TriggerClientEvent("ucrp-paleto:lootup_c", -1, var, var2)
end)

RegisterServerEvent("ucrp-paleto:toggleVault")
AddEventHandler("ucrp-paleto:toggleVault", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("ucrp-paleto:toggleVault", -1, key, state)
end)

RegisterServerEvent("ucrp-paleto:updateVaultState")
AddEventHandler("ucrp-paleto:updateVaultState", function(key, state)
    Doors[key][1].state = state
end)

RegisterServerEvent("ucrp-paleto:startLoot")
AddEventHandler("ucrp-paleto:startLoot", function(data, name, players)
    local src = source

    for i = 10, #players, 10 do
        TriggerClientEvent("ucrp-paleto:startLoot_c", players[i], data, name)
    end
    TriggerClientEvent("ucrp-paleto:startLoot_c", src, data, name)
end)

RegisterServerEvent("ucrp-paleto:stopHeist")
AddEventHandler("ucrp-paleto:stopHeist", function(name)
    TriggerClientEvent("ucrp-paleto:stopHeist_c", -1, name)
end)

RegisterServerEvent("ucrp-paleto:rewardCash")
AddEventHandler("ucrp-paleto:rewardCash", function()
    local src = source
    local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
	if Paleto.blackmoney then
        TriggerClientEvent("player:receiveItem", src, "markedbills", 250)
    else
        TriggerClientEvent("player:receiveItem", src, "markedbills", 425)
    end
end)

RegisterServerEvent("ucrp-paleto:setCooldown")
AddEventHandler("ucrp-paleto:setCooldown", function(name)
    Paleto.Banks[name].lastrobbed = os.time()
    Paleto.Banks[name].onaction = false
    TriggerClientEvent("ucrp-paleto:resetDoorState", -1, name)
end)

RPC.register("ucrp-paleto:getBanks", function(source)
    return Paleto.Banks, Doors
end)

 RegisterCommand("aan", function()
     TriggerClientEvent('ucrp-paleto:UseGreenLapTop', source)
 end)

-- RegisterServerEvent('rick:removeLaptop')
-- AddEventHandler('rick:removeLaptop', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     Player.Functions.RemoveItem('green-laptop', 1)
-- end)


local doorCheckPaleto = false

RegisterServerEvent("ucrp-paleto:getGetDoorStateSV")
AddEventHandler("ucrp-paleto:getGetDoorStateSV", function()
    TriggerClientEvent('ucrp-paleto:getDoorCheckCL', -1, doorCheckPaleto)
end)

RegisterServerEvent("ucrp-paleto:getGetDoorStateSVSV")
AddEventHandler("ucrp-paleto:getGetDoorStateSVSV", function(paletoBanksDoors)
    doorCheckPaleto = paletoBanksDoors
end)

RegisterServerEvent("ucrp-paleto:openDoor")
AddEventHandler("ucrp-paleto:openDoor", function(coords, method)
    TriggerClientEvent("ucrp-paleto:OpenPaletoDoor", -1)
end)

RegisterServerEvent("ucrp-paleto:closeDoor")
AddEventHandler("ucrp-paleto:closeDoor", function(coords, method)
    TriggerClientEvent("ucrp-paleto:ClosePaletoDoor", -1)
end)