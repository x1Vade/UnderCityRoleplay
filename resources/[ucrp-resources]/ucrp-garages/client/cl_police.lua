local nearBuy = false

Citizen.CreateThread(function()
    exports["ucrp-polyzone"]:AddBoxZone("police_buy", vector3(442.92, -973.83, 25.7), 3, 3, {
        name="police_buy",
        heading=310,
        --debugPoly=true,
        minZ=22.5,
        maxZ=26.5
    }) 
end)

RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    if name == "police_buy" then
		local job = exports["isPed"]:isPed("myJob")
		if job == 'police' then
            nearBuy = true
            AtPoliceBuy()
            exports["ucrp-ui"]:showInteraction("[E] Buy Vehicle")
        end
    end
end)

RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name == "police_buy" then
        nearBuy = false
    end
    exports["ucrp-ui"]:hideInteraction()
end)

function AtPoliceBuy()
	Citizen.CreateThread(function()
        while nearBuy do
            Citizen.Wait(5)
            local plate = GetVehicleNumberPlateText(vehicle)
            local job = exports["isPed"]:isPed("myJob")
            if job == 'police' then
                if IsControlJustReleased(0, 38) then
                    TriggerEvent('ucrp-garages:openBuyMenu')
                end
            end
        end
    end)
end

RegisterNetEvent('ucrp-garages:openBuyMenu')
AddEventHandler('ucrp-garages:openBuyMenu', function()
    TriggerEvent('ucrp-context:sendMenu', {
		{
			id = 1,
			header = "Crown Vic",
			txt = "Purchase for $5000",
			params = {
				event = "ucrp-garages:PurchasedGDEvoke"
			}
		},
        -- {
		-- 	id = 2,
		-- 	header = "Ranger Blazer",
		-- 	txt = "Purchase for $10000",
		-- 	params = {
		-- 		event = "ucrp-garages:PurchasedGDEvokeW"
		-- 	}
		-- },
        {
			id = 2,
			header = "Explorer",
			txt = "Purchase for $15000",
			params = {
				event = "ucrp-garages:PurchasedGDterritory"
			}
		},
        -- {
		-- 	id = 4,
		-- 	header = "Bike Interceptor",
		-- 	txt = "Purchase for $15000",
		-- 	params = {
		-- 		event = "ucrp-garages:PurchasedGDsonata"
		-- 	}
		-- },
        -- {
		-- 	id = 5,
		-- 	header = "Mustang Interceptor",
		-- 	txt = "Purchase for $65000",
		-- 	params = {
		-- 		event = "ucrp-garages:PurchasedGDgts"
		-- 	}
		-- },
        -- {
		-- 	id = 6,
		-- 	header = "Corvette Interceptor",
		-- 	txt = "Purchase for $75000",
		-- 	params = {
		-- 		event = "ucrp-garages:PurchasedGDdog"
		-- 	}
		-- },
        -- {
		-- 	id = 7,
		-- 	header = "Challenger",
		-- 	txt = "Purchase for $85000",
		-- 	params = {
		-- 		event = "ucrp-garages:PurchasedGDranger"
		-- 	}
		-- },
        -- {
		-- 	id = 8,
		-- 	header = "Charger",
		-- 	txt = "Purchase for $30000",
		-- 	params = {
		-- 		event = "ucrp-garages:PurchasedGDlandy"
		-- 	}
		-- },
        
	})
end)

RegisterNetEvent('ucrp-garages:PurchasedGDEvoke')
AddEventHandler('ucrp-garages:PurchasedGDEvoke', function()
    if exports["isPed"]:isPed("mycash") >= 5000 then
        --TriggerServerEvent('banking:removeMoney', 5000)
        TriggerServerEvent('yorktax:vic')
        TriggerEvent('ucrp-garages:PurchasedVeh', 'Crown Vic', 'npolvic', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedGDEvokeW')
AddEventHandler('ucrp-garages:PurchasedGDEvokeW', function()
    if exports["isPed"]:isPed("mycash") >= 10000 then
        --TriggerServerEvent('banking:removeMoney', 10000)
        TriggerServerEvent('yorktax:blazer')
        TriggerEvent('ucrp-garages:PurchasedVeh', 'Ranger QuadBike', 'npolblazer', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedGDterritory')
AddEventHandler('ucrp-garages:PurchasedGDterritory', function()
    if exports["isPed"]:isPed("mycash") >= 15000 then
        --TriggerServerEvent('banking:removeMoney', 15000)
        TriggerServerEvent('yorktax:exp')
        TriggerEvent('ucrp-garages:PurchasedVeh', 'Ford Explorer', 'npolexp', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedGDsonata')
AddEventHandler('ucrp-garages:PurchasedGDsonata', function()
    if exports["isPed"]:isPed("mycash") >= 15000 then
        --TriggerServerEvent('banking:removeMoney', 15000)
        TriggerServerEvent('yorktax:mm')
        TriggerEvent('ucrp-garages:PurchasedVeh', 'Police Bike', 'npolmm', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedGDdog')
AddEventHandler('ucrp-garages:PurchasedGDdog', function()
    if exports["isPed"]:isPed("mycash") >= 80000 then
        --TriggerServerEvent('banking:removeMoney', 80000)
        TriggerServerEvent('yorktax:vette')
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HeatUnit Corvette', 'npolvette', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money or you are not Heat Unit", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedGDranger')
AddEventHandler('ucrp-garages:PurchasedGDranger', function()
    if exports["isPed"]:isPed("mycash") >= 60000 then
        --TriggerServerEvent('banking:removeMoney', 60000)
        TriggerServerEvent('yorktax:chal')
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HeatUnit Challenger', 'npolchal', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedGDgts')
AddEventHandler('ucrp-garages:PurchasedGDgts', function()
    if exports["isPed"]:isPed("mycash") >= 75000 then
        --TriggerServerEvent('banking:removeMoney', 75000)
        TriggerServerEvent('yorktax:stang')
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HeatUnit Mustang', 'npolstang', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedGDlandy')
AddEventHandler('ucrp-garages:PurchasedGDlandy', function()
    if exports["isPed"]:isPed("mycash") >= 30000 then
        --TriggerServerEvent('banking:removeMoney', 30000)
        TriggerServerEvent('yorktax:char')
        TriggerEvent('ucrp-garages:PurchasedVeh', 'Police Charger', 'npolchar', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedGDbzcom')
AddEventHandler('ucrp-garages:PurchasedGDbzcom', function()
    if exports["isPed"]:isPed("mycash") >= 40000 then
        TriggerServerEvent('banking:removeMoney', 40000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'GD Holden BZ Commodore', 'NSWZBS', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedHWPe63')
AddEventHandler('ucrp-garages:PurchasedHWPe63', function()
    if exports["isPed"]:isPed("mycash") >= 40000 then
        TriggerServerEvent('banking:removeMoney', 40000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HWP Mercedes-benz E63', 'fatale63', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedHWPgts')
AddEventHandler('ucrp-garages:PurchasedHWPgts', function()
    if exports["isPed"]:isPed("mycash") >= 45000 then
        TriggerServerEvent('banking:removeMoney', 45000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HWP Holden GTS', 'HWPGTS', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedHWP530d')
AddEventHandler('ucrp-garages:PurchasedHWP530d', function()
    if exports["isPed"]:isPed("mycash") >= 45000 then
        TriggerServerEvent('banking:removeMoney', 45000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HWP BMW 530D', 'hwy21', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedHWPbike')
AddEventHandler('ucrp-garages:PurchasedHWPbike', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HWP Yamaha 1300', 'hwpbike', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedHWvfss')
AddEventHandler('ucrp-garages:PurchasedHWvfss', function()
    if exports["isPed"]:isPed("mycash") >= 55000 then
        TriggerServerEvent('banking:removeMoney', 55000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HWP Holden VF SS', 'hwpvf2', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedHWP300c')
AddEventHandler('ucrp-garages:PurchasedHWP300c', function()
    if exports["isPed"]:isPed("mycash") >= 60000 then
        TriggerServerEvent('banking:removeMoney', 60000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HWP Chrysler 300c', 'hwpsrtcore', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedHWPhellcat')
AddEventHandler('ucrp-garages:PurchasedHWPhellcat', function()
    if exports["isPed"]:isPed("mycash") >= 65000 then
        TriggerServerEvent('banking:removeMoney', 65000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HWP Dodge Charger', 'hellcatRB', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedPORSlandcruiser')
AddEventHandler('ucrp-garages:PurchasedPORSlandcruiser', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'PORS Toyota Landcruiser', 'PORSLandy', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedPORSriot')
AddEventHandler('ucrp-garages:PurchasedPORSriot', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'PORS Armored Truck', 'riot', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedUCstinger')
AddEventHandler('ucrp-garages:PurchasedUCstinger', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HWP Kia Stinger', 'h1stinger', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedUC530d')
AddEventHandler('ucrp-garages:PurchasedUC530d', function()
    if exports["isPed"]:isPed("mycash") >= 60000 then
        TriggerServerEvent('banking:removeMoney', 60000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'HWP BMW 530D', 'UM21', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedUCzb')
AddEventHandler('ucrp-garages:PurchasedUCzb', function()
    if exports["isPed"]:isPed("mycash") >= 60000 then
        TriggerServerEvent('banking:removeMoney', 60000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'UC Holden ZB Commodore', 'NSWZBSUM', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedUClandcruiser')
AddEventHandler('ucrp-garages:PurchasedUClandcruiser', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'UC Toyota Landcruiser', 'UCLandcruiser', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('ucrp-garages:PurchasedUCprado')
AddEventHandler('ucrp-garages:PurchasedUCprado', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('ucrp-garages:PurchasedVeh', 'UC Toyota Prado', 'NSWPrado', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

    

RegisterNetEvent('ucrp-garages:PurchasedVeh')
AddEventHandler('ucrp-garages:PurchasedVeh', function(name, veh, price)
    local ped = PlayerPedId()
    local name = name    
    local vehicle = veh
    local price = price        
    local model = veh
    local colors = table.pack(GetVehicleColours(veh))
    local extra_colors = table.pack(GetVehicleExtraColours(veh))

    local mods = {}

    for i = 0,24 do
        mods[i] = GetVehicleMod(veh,i)
    end

    FreezeEntityPosition(ped,false)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    personalvehicle = CreateVehicle(model,435.80545043945, -975.96203613281, 25.699991226196,88.239898681641,true,false)
    SetEntityHeading(personalvehicle, 88.239898681641)
    SetModelAsNoLongerNeeded(model)

    for i,mod in pairs(mods) do
        SetVehicleModKit(personalvehicle,0)
        SetVehicleMod(personalvehicle,i,mod)
    end

    SetVehicleOnGroundProperly(personalvehicle)

    local plate = GetVehicleNumberPlateText(personalvehicle)
    SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
    local id = NetworkGetNetworkIdFromEntity(personalvehicle)
    SetNetworkIdCanMigrate(id, true)
    Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
    SetVehicleColours(personalvehicle,colors[1],colors[2])
    SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
    TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
    SetEntityVisible(ped,true)            
    local primarycolor = colors[1]
    local secondarycolor = colors[2]    
    local pearlescentcolor = extra_colors[1]
    local wheelcolor = extra_colors[2]
    --local VehicleProps = exports['ucrp-base']:FetchVehProps(personalvehicle)
    local model = GetEntityModel(personalvehicle)
    local vehname = GetDisplayNameFromVehicleModel(model)
    TriggerEvent("keys:addNew",personalvehicle, plate)
    TriggerServerEvent('ucrp-garages:FinalizedPur', plate, name, vehicle, price)
    Citizen.Wait(100)
    exports['ucrp-textui']:hideInteraction()
end)

RegisterNetEvent('PDSpawnVeh33')
AddEventHandler('PDSpawnVeh33', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Police Garage",
            txt = ""
        },
        {
            id = 2,
            header = "PolAir",
			txt = "Eye in the sky",
			params = {
                event = "spawn:veh:pd33",
				args = {
					vehicle = "maverick2"
				}
            }
        },
	
    })
end)

RegisterNetEvent('spawn:veh:pd33')
AddEventHandler('spawn:veh:pd33', function(type)
	SpawnVehPD33(type.vehicle)	
end)

function SpawnVehPD33(name)
	Citizen.CreateThread(function()

        local hash = GetHashKey(name)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD33(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 449.27819824219, -981.24462890625, 43.691368103027, 353.6337890625, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        applyMaxUpgrades(vehicle)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end

function applyMaxUpgrades(veh)
	SetVehicleModKit(veh, 0)
    SetVehicleMod(veh, 11, 3, false)
    SetVehicleMod(veh, 12, 2, false)
    SetVehicleMod(veh, 13, 2, false)
    SetVehicleMod(veh, 15, 3, false)
    SetVehicleMod(veh, 16, 4, false)
end

function findClosestSpawnPointPD33(pCurrentPosition)
	local coords = vector3(449.27819824219, -981.24462890625, 43.691368103027)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end