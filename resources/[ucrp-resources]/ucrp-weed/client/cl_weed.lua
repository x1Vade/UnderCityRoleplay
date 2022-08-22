local Cooldown = false
local PickingWeed = false

-- Picking Weed Event

RegisterNetEvent('ucrp-weed:pick_field')
AddEventHandler('ucrp-weed:pick_field', function()
    if not PickingWeed then
        if not Cooldown then
            PickingWeed = true
            Cooldown = true
            TriggerEvent('animation:PlayAnimation', 'kneel')
            local finished = exports['ucrp-taskbar']:taskBar(10000, 'Picking Weed')
            if finished == 100 then
                PickingWeed = false
                TriggerEvent('player:receiveItem', 'wetbud2', math.random(1, 3))
                TriggerEvent('DoLongHudText', 'Picked Wet Bud', 1)
                TriggerEvent('animation:PlayAnimation', 'e c')
                Citizen.Wait(5000)
                Cooldown = false
            end
        else
            TriggerEvent('DoLongHudText', 'You aint skilled enough for this wait a few more seconds', 2)
        end
    end
end)

-- Polyzone Pick

UCRPWeedField = false

Citizen.CreateThread(function()
    exports["ucrp-polyzone"]:AddBoxZone("ucrp_weed_field", vector3(2225.08, 5577.28, 53.89), 5, 18.4, {
        name="ucrp_weed_field",
        heading=355,
        -- debugPoly=true,
        minZ=51.69,
        maxZ=55.69
    })
end)

RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    if name == "ucrp_weed_field" then
        UCRPWeedField = true     
        UCRPWeedPick()
		exports['ucrp-ui']:showInteraction("[E] Pick Weed")
    end
end)

RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name == "ucrp_weed_field" then
        UCRPWeedField = false
        exports['ucrp-ui']:hideInteraction()
    end
end)

function UCRPWeedPick()
	Citizen.CreateThread(function()
        while UCRPWeedField do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                TriggerEvent('ucrp-weed:pick_field')
			end
		end
	end)
end

-- Polyzone Dry

UCRPWeedDry = false

Citizen.CreateThread(function()
    exports["ucrp-polyzone"]:AddBoxZone("ucrp_weed_field_dry", vector3(3802.91, 4443.25, 4.29), 10, 10, {
        name "ucrp",
        heading=0,
        --debugPoly=true,
        minZ=2.29,
        maxZ=6.29,
    })
end)

RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    if name ="ucrp" then
        UCRPWeedDry = true     
        UCRPWeedDry()
		exports['ucrp-ui']:showInteraction("[E] Dry Bud")
    end
end)

RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name ="ucrp" then
        UCRPWeedDry = false
        exports['ucrp-ui']:hideInteraction()
    end
end)

function UCRPWeedDry()
	Citizen.CreateThread(function()
        while UCRPWeedDry do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                TriggerEvent('ucrp-drugs:dry_bud')
			end
		end
	end)
end

RegisterNetEvent('ucrp-drugs:dry_bud')
AddEventHandler('ucrp-drugs:dry_bud', function()
    if exports['ucrp-inventory']:hasEnoughOfItem('wetbud2', 1) then
        local finished = exports['ucrp-taskbar']:taskBar(5000, 'Drying Bud')
        if finished == 100 then
            if exports['ucrp-inventory']:hasEnoughOfItem('wetbud2', 1) then
                TriggerEvent('inventory:removeItem', 'wetbud2', 1)
                TriggerEvent('DoLongHudText', 'Dried Bud', 1)
                TriggerEvent('player:receiveItem', 'driedbud', 1)
            end
        end
    else
        TriggerEvent('DoLongHudText', 'You dont have any bud to dry', 2)
    end
end)

-- Polyzone Sell

UCRPWeedSales = false

Citizen.CreateThread(function()
    exports["ucrp-polyzone"]:AddBoxZone("ucrp_weed_sell", vector3(-1171.7, -1571.79, 4.37), 3, 3, {
        name="ucrp_weed_sell",
        heading=35,
        -- debugPoly=true,
        minZ=1.37,
        maxZ=5.37
    })
end)

RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    if name == "ucrp_weed_sell" then
        UCRPWeedSales = true     
        UCRPWeedSell()
		exports['ucrp-ui']:showInteraction("[E] Sell Bud")
    end
end)

RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name == "ucrp_weed_sell" then
        UCRPWeedSales = false
        exports['ucrp-ui']:hideInteraction()
    end
end)

function UCRPWeedSell()
	Citizen.CreateThread(function()
        while UCRPWeedSales do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                if exports['ucrp-inventory']:hasEnoughOfItem('driedbud', 1) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    local finished = exports['ucrp-taskbar']:taskBar(5000, 'Selling Bud')
                    if finished == 100 then
                        if exports['ucrp-inventory']:hasEnoughOfItem('driedbud', 1) then
                            FreezeEntityPosition(PlayerPedId(), false)
                            TriggerEvent('inventory:removeItem', 'driedbud', 1)
                            TriggerServerEvent('ucrp-drugs:weed_sell')
                        end
                    end
                else
                    TriggerEvent('DoLongHudText', 'You dont got any Dried Bud to sell', 2)
                end
			end
		end
	end)
end