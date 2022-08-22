cooldownglobalPaleto = 0

RegisterServerEvent("ucrp-paleto:startcheck")
AddEventHandler("ucrp-paleto:startcheck", function(bank)
    local _source = source
    globalonactionPaleto = true
    TriggerClientEvent('ucrp-inv:removeItem', _source, 'bluetablet', 1)
    TriggerClientEvent("ucrp-paleto:outcome", _source, true, bank)
end)

RegisterServerEvent("ucrp-paleto:TimePoggers")
AddEventHandler("ucrp-paleto:TimePoggers", function()
    local _source = source
    TriggerClientEvent("ucrp-paleto:outcome", _source, false, "This bank recently robbed. You need to wait "..math.floor((paleto.cooldown - (os.time() - cooldownglobalPaleto)) / 60)..":"..math.fmod((paleto.cooldown - (os.time() - cooldownglobalPaleto)), 60))
end)

RegisterServerEvent("ucrp-paleto:DoorAccessPoggers")
AddEventHandler("ucrp-paleto:DoorAccessPoggers", function()
    local _source = source
    TriggerClientEvent("ucrp-paleto:outcome", _source, false, "There is a bank currently being robbed.")
end)

RegisterServerEvent("ucrp-paleto:lootup")
AddEventHandler("ucrp-paleto:lootup", function(var, var2)
    TriggerClientEvent("ucrp-paleto:lootup_c", -1, var, var2)
end)

RegisterServerEvent("ucrp-paleto:openDoor")
AddEventHandler("ucrp-paleto:openDoor", function(coords, method)
    TriggerClientEvent("ucrp-paleto:OpenPaletoDoor", -1)
end)

RegisterServerEvent("ucrp-paleto:closeDoor")
AddEventHandler("ucrp-paleto:closeDoor", function(coords, method)
    TriggerClientEvent("ucrp-paleto:ClosePaletoDoor", -1)
end)

RegisterServerEvent("ucrp-paleto:startLoot")
AddEventHandler("ucrp-paleto:startLoot", function(data, name)
    TriggerClientEvent("ucrp-paleto:startLoot_c", -1, data, name)
end)

RegisterServerEvent("ucrp-paleto:stopHeist")
AddEventHandler("ucrp-paleto:stopHeist", function(name)
    TriggerClientEvent("ucrp-paleto:stopHeist_c", -1, name)
end)

RegisterServerEvent("ucrp-paleto:rewardCash")
AddEventHandler("ucrp-paleto:rewardCash", function()
    local reward = math.random(2, 4)
    TriggerClientEvent("ucrp-user:receiveItem", source, "band", reward)
end)

RegisterServerEvent("ucrp-paleto:setCooldown")
AddEventHandler("ucrp-paleto:setCooldown", function(name)
    cooldownglobalPaleto = os.time()
    globalonactionPaleto = false
    TriggerClientEvent("ucrp-paleto:resetDoorState", -1, name)
end)


RegisterServerEvent("ucrp-paleto:getBanksSV")
AddEventHandler("ucrp-paleto:getBanksSV", function()
    TriggerClientEvent('ucrp-paleto:getBanks', -1, paleto.Banks)
end)

local cooldownAttemptsPaleto = 3

RegisterServerEvent("ucrp-paleto:getHitSV")
AddEventHandler("ucrp-paleto:getHitSV", function()
    TriggerClientEvent('ucrp-paleto:getHit', -1, cooldownAttemptsPaleto)
end)

RegisterServerEvent("ucrp-paleto:getHitSVSV")
AddEventHandler("ucrp-paleto:getHitSVSV", function(paletoBanksTimes)
    cooldownAttemptsPaleto = paletoBanksTimes
end)

local doorCheckPaleto = false

RegisterServerEvent("ucrp-paleto:getGetDoorStateSV")
AddEventHandler("ucrp-paleto:getGetDoorStateSV", function()
    TriggerClientEvent('ucrp-paleto:getDoorCheckCL', -1, doorCheckPaleto)
end)

RegisterServerEvent("ucrp-paleto:getGetDoorStateSVSV")
AddEventHandler("ucrp-paleto:getGetDoorStateSVSV", function(paletoBanksDoors)
    doorCheckPaleto = paletoBanksDoors
end)


RegisterServerEvent("ucrp-paleto:getTimeSV")
AddEventHandler("ucrp-paleto:getTimeSV", function()
    TriggerClientEvent('ucrp-paleto:GetTimeCL', -1, cooldownglobalPaleto)
end)

RegisterServerEvent("ucrp-paleto:getTime2SV")
AddEventHandler("ucrp-paleto:getTime2SV", function()
    TriggerClientEvent('ucrp-paleto:GetTime2CL', -1, (os.time() - paleto.cooldown))
end)

RegisterServerEvent("ucrp-paleto:getDoorAccessSV")
AddEventHandler("ucrp-paleto:getDoorAccessSV", function()
    TriggerClientEvent('ucrp-paleto:GetDoorAccessCL', -1, globalonactionPaleto)
end)