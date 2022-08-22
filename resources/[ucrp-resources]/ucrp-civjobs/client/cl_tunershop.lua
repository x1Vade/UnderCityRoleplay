

--// Tuner Shop Stash

DreamsTunerShopDoc = false

Citizen.CreateThread(function()
    exports["ucrp-polyzone"]:AddBoxZone("tuner_shop_docs_stash", vector3(128.46, -3014.08, 7.04), 2.5, 2.5, {
        name="tuner_shop_docs_stash",
        heading=0,
        debugPoly=false,
        minZ=5.04,
        maxZ=9.04
	})
    exports["ucrp-polyzone"]:AddBoxZone("tuner_shop_docs_stash2", vector3(128.45, -3008.05, 7.04), 2, 3.2, {
        name="tuner_shop_docs_stash2",
        heading=0,
        debugPoly=false,
        minZ=5.04,
        maxZ=9.04
    })
end)


RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    if name == "tuner_shop_docs_stash" then
        DreamsTunerShopDoc = true     
        TunerShopStash()
            local rank = exports["isPed"]:GroupRank("tuner_carshop")
            if rank > 1 then 
            exports['ucrp-ui']:showInteraction("[E] Stash")
        end
    end
end)


RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name == "tuner_shop_docs_stash" then
        DreamsTunerShopDoc = false
        exports['ucrp-ui']:hideInteraction()
    end
end)



function TunerShopStash()
	Citizen.CreateThread(function()
        while DreamsTunerShopDoc do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("tuner_carshop")
                    if rank > 1 then 
                    TriggerEvent('tuner:stash:docs')
                end
			end
		end
	end)
end

RegisterNetEvent('tuner:stash:docs')
AddEventHandler('tuner:stash:docs', function()
    local job = exports["isPed"]:GroupRank('tuner_carshop')
    if job >= 2 then
		TriggerEvent("server-inventory-open", "1", "storage-tuner-docs")
		Wait(1000)
	end
end)


--------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('ucrp-civjobs:craft-lockpick')
AddEventHandler('ucrp-civjobs:craft-lockpick', function()
    local job = exports["isPed"]:GroupRank('tuner_carshop')
    if job >= 1 and exports['ucrp-inventory']:hasEnoughOfItem('steel', 2) then
        TriggerEvent('inventory:removeItem', 'steel', 2)
        TriggerEvent('player:receiveItem', 'lockpick', 1)
        TriggerEvent('DoLongHudText', 'Successfully crafted Lockpick', 1)
    else
        TriggerEvent('DoLongHudText', 'You dont have 2x Steel', 2)
    end
end)

RegisterNetEvent('ucrp-civjobs:craft-advlockpick')
AddEventHandler('ucrp-civjobs:craft-advlockpick', function()
    local job = exports["isPed"]:GroupRank('tuner_carshop')
    if job >= 1 and exports['ucrp-inventory']:hasEnoughOfItem('refinedaluminium', 15) and exports['ucrp-inventory']:hasEnoughOfItem('refinedplastic', 12) and exports['ucrp-inventory']:hasEnoughOfItem('refinedrubber', 15) then
        TriggerEvent('inventory:removeItem', 'refinedaluminium', 15)
        TriggerEvent('inventory:removeItem', 'refinedplastic', 12)
        TriggerEvent('inventory:removeItem', 'refinedrubber', 15)
        TriggerEvent('player:receiveItem', 'advlockpick', 1)
        TriggerEvent('DoLongHudText', 'Successfully Crafted Advlockpick', 1)
    else
        TriggerEvent('DoLongHudText', 'You do not have the required materials', 2)
    end
end)

RegisterNetEvent('ucrp-civjobs:craft-repairkit')
AddEventHandler('ucrp-civjobs:craft-repairkit', function()
    local job = exports["isPed"]:GroupRank('tuner_carshop')
    if job >= 1 and exports['ucrp-inventory']:hasEnoughOfItem('electronics', 25) then
        TriggerEvent('inventory:removeItem', 'electronics', 25)
        TriggerEvent('player:receiveItem', 'repairkit', 1)
        TriggerEvent('DoLongHudText', 'Successfully crafted Repairkit', 1)
    else
        TriggerEvent('DoLongHudText', 'You dont have the required materials', 2)
    end
end)

RegisterNetEvent('ucrp-civjobs:tuner_craft')
AddEventHandler('ucrp-civjobs:tuner_craft', function()
    TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Tuner Shop Craft",
            txt = ""
        },
        {
            id = 2,
            header = "Craft Lockpick",
            txt = "Requires: 2x Steel",
            params = {
                event = "ucrp-civjobs:craft-lockpick"
            }
        },
        {
            id = 3,
            header = "Craft Advlockpick",
            txt = "Requires: 15x Refined Aluminium | 12x Refined Plastic | 15x Refined Rubber",
            params = {
                event = "ucrp-civjobs:craft-advlockpick"
            }
        },
        {
            id = 4,
            header = "Craft Repairkit",
            txt = "Requires: 25 Electronics",
            params = {
                event = "ucrp-civjobs:craft-repairkit"
            }
        },
        {
            id = 5,
            header = "Close",
            txt = "Have a good day!",
            params = {
                event = ""
            }
        },
    })
end)

--// CraftShit

DreamsCraftDocs = false

Citizen.CreateThread(function()
    exports["ucrp-polyzone"]:AddBoxZone("tuner_shop_docs_craft", vector3(144.39, -3050.88, 7.04), 4, 1.4, {
        name="tuner_shop_docs_craft",
        heading=270,
        --debugPoly=true,
        minZ=5.44,
        maxZ=9.44
    })
end)

RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    if name == "tuner_shop_docs_craft" then
        DreamsCraftDocs = true     
        TunerShopCraft()
            local rank = exports["isPed"]:GroupRank("tuner_carshop")
            if rank > 1 then 
            exports['ucrp-ui']:showInteraction("[E] Craft")
        end
    end
end)

RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name == "tuner_shop_docs_craft" then
        DreamsCraftDocs = false
        exports['ucrp-ui']:hideInteraction()
    end
end)

function TunerShopCraft()
	Citizen.CreateThread(function()
        while DreamsCraftDocs do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("tuner_carshop")
                    if rank > 0 then 
                    TriggerEvent('ucrp-civjobs:tuner_craft')
                end
			end
		end
	end)
end

