


RegisterNetEvent('uwu_cafe_stash')
AddEventHandler('uwu_cafe_stash', function()
    local rank = exports["isPed"]:GroupRank("uwu_cafe")
     if rank > 1 then 
        TriggerEvent("server-inventory-open", "1", "storage-tuner-docs")
        Wait(1000)
    end
end)

RegisterNetEvent('uwu_cafe_craft')
AddEventHandler('uwu_cafe_craft', function()
   local rank = exports["isPed"]:GroupRank("uwu_cafe")
    if rank > 1 then 
       TriggerEvent('server-inventory-open', '7777', 'Craft')
       Wait(1000)
   end
end)


exports["ucrp-polyzone"]:AddBoxZone("uwu_cafe_reg",  vector3(146.62, -3014.06, 7.00), 1, 0.8, {
    heading=181.6,
    minZ=5.2,
    maxZ=7.3
})

-- UwU Cafe Tray -- 
exports["ucrp-polyzone"]:AddBoxZone("uwu_cafe_tray1", vector3(148.07, -3014.12, 7.00), 1, 0.8, {
    heading=181.6,
    minZ=5.2,
    maxZ=7.3

})

  --UwU Cafe Shop Register 1
        exports["ucrp-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_reg", {
            {
                event = "tunershop:get:receipt",
                id = "tuner_shop_reg",
                icon = "cash-register",
                label = "Make Payment",
                parameters = 'uwu_cafe_reg',
            },
            {
                event = "tunershop:register",
                id = "uwu_cafe_reg_charge",
                icon = "cash-register",
                label = "Charge Customer",
                parameters = 'uwu_cafe_reg',
            },
        }, {
            distance = { radius = 2.5 },
        });


exports["ucrp-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_tray1", {{
    event = "ucrp-jobs:TunerShopTray-1",
    id = "tuner_shop_tray_1",
    icon = "hand-holding",
    label = "Grab Items",
    parameters = {},
}}, {
    distance = { radius = 3.5 },
});


exports["ucrp-polyzone"]:AddBoxZone("uwu_music_player", vector3(123.61, -3028.19, 7.04), 1, 1, {
    heading=70,
    minZ=6.61,
    maxZ=7.02
})

exports["ucrp-interact"]:AddPeekEntryByPolyTarget("uwu_music_player", {{
    event = "uwu_cafe:music",
    id = "uwu_music_player",
    icon = "circle",
    label = "Music Player",
    parameters = {},
},
}, {
    distance = { radius = 2.5 },
});




exports["ucrp-polyzone"]:AddBoxZone("uwu_cafe_craft", vector3(147.17, -3010.57, 7.04), 0.8, 2, {
    heading=70,
    minZ=6.61,
    maxZ=7.02
})

exports["ucrp-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_craft", {{
    event = "uwu_craft_event",
    id = "uwu_cafe_craft",
    icon = "wrench",
    label = "Crafting",
    parameters = {},
},
}, {
    distance = { radius = 2.5 },
});


exports["ucrp-interact"]:AddPeekEntryByPolyTarget("uwu_craft_event2", {{
    event = "uwu_craft_event2",
    id = "uwu_craft_event2",
    icon = "circle",
    label = "Crafting O.o",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});


exports["ucrp-polyzone"]:AddBoxZone("uwu_craft_event2", vector3(125.3, -3014.95, 7.00), 1, 1, {
    heading=70,
    minZ=6.61,
    maxZ=7.02
})

--// Registers

RegisterNetEvent("uwu_cafe:register")
AddEventHandler("uwu_cafe:register", function(registerID)
    local rank = exports["isPed"]:GroupRank("uwu_cafe")
    if rank >= 1 then 
        local order = exports["ucrp-applications"]:KeyboardInput({
            header = "Create Receipt",
            rows = {
                {
                    id = 0,
                    txt = "Amount"
                },
                {
                    id = 1,
                    txt = "Comment"
                }
            }
        })
        if order then
            TriggerServerEvent("uwu_cafe:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)

RegisterNetEvent("uwu_cafe:get:receipt")
AddEventHandler("uwu_cafe:get:receipt", function(registerid)
    TriggerServerEvent('uwu_cafe:retreive:receipt', registerid)
end)

RegisterNetEvent('uwu_cafe:cash:in')
AddEventHandler('uwu_cafe:cash:in', function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("uwu_cafe:update:pay", cid)
end)