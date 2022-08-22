RegisterServerEvent("ucrp-alerts:teenA")
AddEventHandler("ucrp-alerts:teenA",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:policealertA', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:teenB")
AddEventHandler("ucrp-alerts:teenB",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:policealertB', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:teenpanic")
AddEventHandler("ucrp-alerts:teenpanic",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:panic', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:fourA")
AddEventHandler("ucrp-alerts:fourA",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:tenForteenA', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:fourB")
AddEventHandler("ucrp-alerts:fourB",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:tenForteenB', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:downperson")
AddEventHandler("ucrp-alerts:downperson",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:downalert', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:shoot")
AddEventHandler("ucrp-alerts:shoot",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:gunshotInProgress', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:storerob")
AddEventHandler("ucrp-alerts:storerob",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:storerobbery', -1, targetCoords)
	return
end)


RegisterServerEvent("ucrp-alerts:houserob")
AddEventHandler("ucrp-alerts:houserob",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:houserobbery', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:drugsselling")
AddEventHandler("ucrp-alerts:drugsselling",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:drugsales', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:tbank")
AddEventHandler("ucrp-alerts:tbank",function(targetCoords)
    TriggerClientEvent('ucrp-alerts:banktruck', -1, targetCoords)
	return
end)

RegisterServerEvent("ucrp-alerts:robjew")
AddEventHandler("ucrp-alerts:robjew",function()
    TriggerClientEvent('ucrp-alerts:jewelrobbey', -1)
	return
end)


RegisterServerEvent("ucrp-dispatch:fleeca:bank")
AddEventHandler("ucrp-dispatch:fleeca:bank",function(pCoords)
    TriggerClientEvent('ucrp-dispatch:fleeca:bank:receive', -1, pCoords)
end)

