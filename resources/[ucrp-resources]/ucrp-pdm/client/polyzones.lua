local nearRepo = false

Citizen.CreateThread(function()
    exports["ucrp-polyzone"]:AddBoxZone("veh_shop_repo", vector3(-239.27, -1183.79, 23.04), 8.6, 5, {
        name="veh_shop_repo",
        heading=270,
        --debugPoly=true,
        minZ=22.04,
        maxZ=24.44
    }) 
end)


RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    if name == "veh_shop_repo" then
        local job = exports["isPed"]:isPed("myjob")
        if job == "car_shop" then
            nearRepo = true
            AtRepo()
            TriggerEvent('ucrp-textui:ShowUI', 'show', ("[E] %s"):format("Repo Vehicle"))
        end
    end
end)

RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name == "veh_shop_repo" then
        local job = exports["isPed"]:isPed("myjob")
        if job == "car_shop" then
            nearRepo = false
            TriggerEvent('ucrp-textui:HideUI')
        end
    end
end)

function AtRepo()
	Citizen.CreateThread(function()
        while nearRepo do
            Citizen.Wait(5)
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if vehicle ~= 0 then
                local plate = GetVehicleNumberPlateText(vehicle)
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("ucrp-vehicleshop:repo", plate)
                end
            end
        end
    end)
end