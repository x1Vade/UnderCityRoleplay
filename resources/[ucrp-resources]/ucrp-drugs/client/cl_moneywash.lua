
    
    RegisterNetEvent("rollcash:JobCheck")
    AddEventHandler("rollcash:JobCheck", function()
        local rank = exports["isPed"]:GroupRank("galaxy_nc")
        if rank > 3 then 
    TriggerEvent('rollcash:menuMINT')
    print("??")
    else
        TriggerEvent("DoShortHudText", "Idiot", 2)
    end
end)

    RegisterNetEvent("rollcash:menuMINT")
    AddEventHandler("rollcash:menuMINT", function()
        TriggerEvent('ucrp-context:sendMenu', {
            {
                id = "1",
                header = "Clean Rolls of Cash",
                txt = "Clean your Roll of cash might take awhile.",
                params = {
                    event = "wash:rollcash",
                }
            },
            {
                id = "2",
                header = "Clean Bands of Cash",
                txt = "Clean your Roll of cash might take awhile.",
                params = {
                    event = "wash:bands",
                }
            },
            {
                id = "3",
                header = "Close Menu",
                txt = "Close menu",
                params = {
                    event = "",
                }
            },
        })
    end) 


  RegisterNetEvent('wash:rollcash')
  AddEventHandler('wash:rollcash', function()
    local qty = exports["ucrp-inventory"]:getQuantity("rollcash")
    if qty and qty > 0 then
        TriggerEvent("inventory:removeItem", "rollcash", qty)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        ExecuteCommand("e type")
        local finished = exports['ucrp-taskbar']:taskBar(2500*qty, 'Washing Cash')
        if finished == 100 then

            TriggerServerEvent('mission:finished:rolls', math.random(180,250)*qty)
            FreezeEntityPosition(PlayerPedId(), false)
            ExecuteCommand("e c")
        else
            ExecuteCommand("e c")
            FreezeEntityPosition(PlayerPedId(), false)

        end

    end
end)



    
RegisterNetEvent("bands:JobCheck")
AddEventHandler("bands:JobCheck", function()
    local rank = exports["isPed"]:GroupRank("galaxy_nc")
    if rank > 3 then 
TriggerEvent('bands:menuMINT')
print("??")
else
    TriggerEvent("DoShortHudText", "Idiot", 2)
end
end)

RegisterNetEvent("bands:menuMINT")
AddEventHandler("bands:menuMINT", function()
    TriggerEvent('ucrp-context:sendMenu', {
        {
            id = "1",
            header = "Clean Band of Notes",
            txt = "Clean your Band of Notes might take awhile.",
            params = {
                event = "wash:bands",
            }
        },
        {
            id = "2",
            header = "Close Menu",
            txt = "Close menu",
            params = {
                event = "",
            }
        },
    })
end) 


RegisterNetEvent('wash:bands')
AddEventHandler('wash:bands', function()
local qty = exports["ucrp-inventory"]:getQuantity("band")
if qty and qty > 0 then
    TriggerEvent("inventory:removeItem", "band", qty)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    ExecuteCommand("e type")
    local finished = exports['ucrp-taskbar']:taskBar(4500*qty, 'Washing Cash')
    if finished == 100 then

        TriggerServerEvent('mission:finished:bands', math.random(750,1500)*qty)
        FreezeEntityPosition(PlayerPedId(), false)
        ExecuteCommand("e c")
    else
        ExecuteCommand("e c")
        FreezeEntityPosition(PlayerPedId(), false)


    end

end
end)


RegisterNetEvent("marked:JobCheck")
AddEventHandler("marked:JobCheck", function()
    local rank = exports["isPed"]:GroupRank("galaxy_nc")
    if rank > 3 then 
TriggerEvent('marked:menuMINT')
print("??")
else
    TriggerEvent("DoShortHudText", "Idiot", 2)
end
end)

RegisterNetEvent("marked:menuMINT")
AddEventHandler("marked:menuMINT", function()
    TriggerEvent('ucrp-context:sendMenu', {
        {
            id = "1",
            header = "Clean Band of Notes",
            txt = "Clean your Band of Notes might take awhile.",
            params = {
                event = "wash:marked",
            }
        },
        {
            id = "2",
            header = "Close Menu",
            txt = "Close menu",
            params = {
                event = "",
            }
        },
    })
end) 


RegisterNetEvent('wash:marked')
AddEventHandler('wash:marked', function()
local qty = exports["ucrp-inventory"]:getQuantity("band")
if qty and qty > 0 then
    TriggerEvent("inventory:removeItem", "markedbills", qty)
    FreezeEntityPosition(GetPlayerPed(),true)
    ExecuteCommand("e wash")
    local finished = exports['ucrp-taskbar']:taskBar(3500*qty, 'Washing Cash')
    if finished == 100 then

        TriggerServerEvent('mission:finished:marked', math.random(275,350)*qty)
        FreezeEntityPosition(PlayerPedId(), false)
        ExecuteCommand("e c")

    end

end
end)






----------------------Mints Tuner Shop Props-----------------------------


local Objects = {
    -- { ["x"] = 414.47, ["y"] = 268.11, ["z"] = 92.05, ["h"] = 345.14, ["model"] = "prop_washer_02" },

    -- { ["x"] = 413.05, ["y"] = 268.51, ["z"] = 92.05, ["h"] = 346.77,  ["model"] = "prop_washer_02" },

    { ["x"] = 411.5, ["y"] = 269.01, ["z"] = 92.05, ["h"] = 343.62,  ["model"] = "prop_washer_02" },

    { ["x"] = 409.57, ["y"] = 269.52, ["z"] = 92.05, ["h"] = 342.06,  ["model"] = "prop_washer_02" },

}



Citizen.CreateThread(function()
    for i = 1, #Objects, 1 do
        while not HasModelLoaded(GetHashKey(Objects[i]["model"])) do
            RequestModel(GetHashKey(Objects[i]["model"]))

            Citizen.Wait(5)
        end

        Objects[i]["objectId"] = CreateObject(GetHashKey(Objects[i]["model"]), Objects[i]["x"], Objects[i]["y"], Objects[i]["z"], false)

        PlaceObjectOnGroundProperly(Objects[i]["objectId"])
        SetEntityHeading(Objects[i]["objectId"], Objects[i]["h"])
        FreezeEntityPosition(Objects[i]["objectId"], true)
        SetEntityAsMissionEntity(Objects[i]["objectId"], true, true)
    end
 end)

-- local removeprops = {
--     "prop_washer_02",
  
-- }

-- Citizen.CreateThread(function()
--     while true do
--         for i = 1, #removeprops do 
--             local player = PlayerId()
--             local plyPed = GetPlayerPed(player)
--             local plyPos = GetEntityCoords(plyPed, false)
         
--             local prop = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z, 200.0, GetHashKey(removeprops[i]), false, 0, 0)
-- 			if prop ~= 0 then
--                 SetEntityAsMissionEntity(prop, true, true)
--                 DeleteObject(prop)
--                 SetEntityAsNoLongerNeeded(prop)
--                 print(prop .. " Prop deleted")
--             end
--         end
--         Citizen.Wait(1000)
--     end
-- end)
