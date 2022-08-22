RegisterNetEvent('ucrp-alerts:gunshotInProgress')
AddEventHandler('ucrp-alerts:gunshotInProgress', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local gunshotBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(gunshotBlip,  110)
		SetBlipColour(gunshotBlip,  1)
		SetBlipScale(gunshotBlip, 1.2)
		SetBlipAsShortRange(gunshotBlip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-71A Shots Fired')
		EndTextCommandSetBlipName(gunshotBlip)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	
	end
end)

AddEventHandler('ucrp-alerts:gunshot', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:shoot', {x = pos.x, y = pos.y, z = pos.z})
end)


---- 10-13s Officer Down ----

RegisterNetEvent('ucrp-alerts:policealertA')
AddEventHandler('ucrp-alerts:policealertA', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local policedown = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(policedown,  84)
		SetBlipColour(policedown,  1)
		SetBlipScale(policedown, 1.2)
		SetBlipAsShortRange(policedown,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-13A Officer Down')
		EndTextCommandSetBlipName(policedown)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', '10-1314', 0.2)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(policedown, alpha)

		if alpha == 0 then
			RemoveBlip(policedown)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:1013A', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:teenA', {x = pos.x, y = pos.y, z = pos.z})
end)

RegisterNetEvent('ucrp-alerts:policealertB')
AddEventHandler('ucrp-alerts:policealertB', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local policedown2 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(policedown2, 84)
		SetBlipColour(policedown2, 1)
		SetBlipScale(policedown2, 1.2)
		SetBlipAsShortRange(policedown2,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-13B Officer Down')
		EndTextCommandSetBlipName(policedown2)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(policedown2, alpha)

		if alpha == 0 then
			RemoveBlip(policedown2)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:1013B', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:teenB', {x = pos.x, y = pos.y, z = pos.z})
end)


RegisterNetEvent('ucrp-alerts:panic')
AddEventHandler('ucrp-alerts:panic', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local panic = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		SetBlipSprite(panic, 459)
		SetBlipColour(panic, 1)
		SetBlipScale(panic, 1.2)
		SetBlipAsShortRange(panic,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-78 Officer Panic Button')
		EndTextCommandSetBlipName(panic)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', '10-1314', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(panic, alpha)

		if alpha == 0 then
			RemoveBlip(panic)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:policepanic', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:teenpanic', {x = pos.x, y = pos.y, z = pos.z})
end)


---- 10-14 EMS ----

RegisterNetEvent('ucrp-alerts:tenForteenA')
AddEventHandler('ucrp-alerts:tenForteenA', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local medicDown = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(medicDown, 84)
		SetBlipColour(medicDown, 1)
		SetBlipScale(medicDown, 1.2)
		SetBlipAsShortRange(medicDown,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-14A Medic Down')
		EndTextCommandSetBlipName(medicDown)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'polalert', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(medicDown, alpha)

		if alpha == 0 then
			RemoveBlip(medicDown)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:1014A', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:fourA', {x = pos.x, y = pos.y, z = pos.z})
end)


RegisterNetEvent('ucrp-alerts:tenForteenB')
AddEventHandler('ucrp-alerts:tenForteenB', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local medicDown2 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(medicDown2, 84)
		SetBlipColour(medicDown2, 1)
		SetBlipScale(medicDown2, 1.2)
		SetBlipAsShortRange(medicDown2,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-14B Officer Down')
		EndTextCommandSetBlipName(medicDown2)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(medicDown2, alpha)

		if alpha == 0 then
			RemoveBlip(medicDown2)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:1014B', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:fourB', {x = pos.x, y = pos.y, z = pos.z})
end)

---- Down Person ----

RegisterNetEvent('ucrp-alerts:downalert')
AddEventHandler('ucrp-alerts:downalert', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(injured,  126)
		SetBlipColour(injured,  18)
		SetBlipScale(injured, 1.2)
		SetBlipAsShortRange(injured,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-47 Injured Person')
		EndTextCommandSetBlipName(injured)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'dispatch', 0.1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(injured, alpha)

		if alpha == 0 then
			RemoveBlip(injured)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:downguy', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:downperson', {x = pos.x, y = pos.y, z = pos.z})
end)

---- assistance ----
RegisterNetEvent('ucrp-alerts:assistance')
AddEventHandler('ucrp-alerts:assistance', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then	
		local alpha = 250
		local assistance = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(assistance,  126)
		SetBlipColour(assistance,  18)
		SetBlipScale(assistance, 1.2)
		SetBlipAsShortRange(assistance,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Assistance Needed')
		EndTextCommandSetBlipName(assistance)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'dispatch', 0.1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(assistance, alpha)

		if alpha == 0 then
			RemoveBlip(assistance)
		return
      end
    end
  end
end)


RegisterNetEvent('ucrp-alerts:vehiclecrash')
AddEventHandler('ucrp-alerts:vehiclecrash', function()
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local recket = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(recket,  488)
		SetBlipColour(recket,  1)
		SetBlipScale(recket, 1.2)
		SetBlipAsShortRange(recket,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-50 Vehicle Crash')
		EndTextCommandSetBlipName(recket)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(recket, alpha)

		if alpha == 0 then
			RemoveBlip(recket)
		return
      end
    end
  end
end)

---- Store Robbery ----
RegisterNetEvent('ucrp-alerts:storerobbery')
AddEventHandler('ucrp-alerts:storerobbery', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local store = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipHighDetail(store, true)
		SetBlipSprite(store, 52)
		SetBlipColour(store, 1)
		SetBlipScale(store, 1.2)
		SetBlipAsShortRange(store,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31B Robbery In Progress')
		EndTextCommandSetBlipName(store)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(store, alpha)

		if alpha == 0 then
			RemoveBlip(store)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:robstore', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:storerob', {x = pos.x, y = pos.y, z = pos.z})
end)

---- House Robbery ----

RegisterNetEvent('ucrp-alerts:houserobbery')
AddEventHandler('ucrp-alerts:houserobbery', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local burglary = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipHighDetail(burglary, true)
		SetBlipSprite(burglary,  411)
		SetBlipColour(burglary,  1)
		SetBlipScale(burglary, 1.2)
		SetBlipAsShortRange(burglary,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31A Burglary')
		EndTextCommandSetBlipName(burglary)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(burglary, alpha)

		if alpha == 0 then
			RemoveBlip(burglary)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:robhouse', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:houserob', {x = pos.x, y = pos.y, z = pos.z})
end)

---- Bank Truck ----

RegisterNetEvent('ucrp-alerts:banktruck')
AddEventHandler('ucrp-alerts:banktruck', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local truck = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(truck,  477)
		SetBlipColour(truck,  76)
		SetBlipScale(truck, 1.2)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 Bank Truck In Progress')
		EndTextCommandSetBlipName(truck)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(truck, alpha)

		if alpha == 0 then
			RemoveBlip(truck)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:bankt', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:tbank', {x = pos.x, y = pos.y, z = pos.z})
end)

---- Jewerly Store ----

RegisterNetEvent('ucrp-alerts:jewelrobbey')
AddEventHandler('ucrp-alerts:jewelrobbey', function()
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local jew = AddBlipForCoord(-634.02, -239.49, 38)

		SetBlipSprite(jew,  487)
		SetBlipColour(jew,  4)
		SetBlipScale(jew, 1.2)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 In Progress')
		EndTextCommandSetBlipName(jew)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(jew, alpha)

		if alpha == 0 then
			RemoveBlip(jew)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:jewrob', function()
	TriggerServerEvent('ucrp-alerts:robjew')
end)

RegisterNetEvent('ucrp-dispatch:fleeca:bank:receive')
AddEventHandler('ucrp-dispatch:fleeca:bank:receive', function(pCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' then
		local alpha = 250
		local pLocation = AddBlipForCoord(pCoords.x, pCoords.y, pCoords.z)

		SetBlipSprite(pLocation,  487)
		SetBlipColour(pLocation,  4)
		SetBlipScale(pLocation, 1.2)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 In Progress')
		EndTextCommandSetBlipName(pLocation)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(pLocation, alpha)

			if alpha == 0 then
				RemoveBlip(pLocation)
				return
			end
    	end
  end
end)

AddEventHandler('ucrp-dispatch:fleeca:bank', function(pCoords)
	TriggerServerEvent('ucrp-dispatch:fleeca:bank', pCoords)
end)

--drug sales--
RegisterNetEvent('ucrp-alerts:drugsales')
AddEventHandler('ucrp-alerts:drugsales', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local drugsales = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipHighDetail(drugsales, true)
		SetBlipSprite(drugsales,  51)
		SetBlipColour(drugsales,  1)
		SetBlipScale(drugsales, 1.0)
		SetBlipAsShortRange(drugsales,  0.8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-26 Drugs In Proggress')
		EndTextCommandSetBlipName(burglary)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(drugsales, alpha)

		if alpha == 0 then
			RemoveBlip(drugsales)
		return
      end
    end
  end
end)

AddEventHandler('ucrp-alerts:sellingdrugs', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('ucrp-alerts:drugsselling', {x = pos.x, y = pos.y, z = pos.z})
end)




RegisterNetEvent('ucrp-dispatch:methexplosion')
AddEventHandler("ucrp-dispatch:methexplosion",function()
  AlertMeth()
end)

RegisterNetEvent('ucrp-dispatch:pacific')
AddEventHandler("ucrp-dispatch:pacific",function()
  AlertPacific()
end)


RegisterNetEvent('ucrp-dispatch:jailbreak')
AddEventHandler("ucrp-dispatch:jailbreak",function()
  AlertJailBreak()
end)

RegisterNetEvent('ucrp-dispatch:jewelrobbery')
AddEventHandler("ucrp-dispatch:jewelrobbery",function()
  AlertJewelRob()
  return
end)


RegisterNetEvent('ucrp-dispatch:houserobbery')
AddEventHandler("ucrp-dispatch:houserobbery",function()
  AlertCheckRobbery2()
end)

RegisterNetEvent('ucrp-dispatch:drugsales')
AddEventHandler("ucrp-dispatch:drugsales",function()
	DrugSales()
end)

RegisterNetEvent('ucrp-dispatch:storerobbery')
AddEventHandler("ucrp-dispatch:storerobbery",function()
  AlertpersonRobbed(vehicle)
end)

RegisterNetEvent('ucrp-dispatch:carjacking')
AddEventHandler("ucrp-dispatch:carjacking",function()
  AlertCheckLockpick(object)
end)

RegisterNetEvent('ucrp-dispatch:downplayer')
AddEventHandler("ucrp-dispatch:downplayer",function()
	TriggerEvent("police:1047")
end)
