local lastMessage = ""

exports("showInteraction", function(message, type)
    if not type then type = "info" end
    lastMessage = message
    SendNUIMessage({
        action = "interactions",
        data = {
            message = message,
            show = true,
            type = type,
        }
    })
end)

exports("hideInteraction", function(type)
    type = type and type or "info"
    SendNUIMessage({
        action = "interactions",
        data = {
            message = lastMessage,
            show = false,
            type = type,
        }
    })
end)

exports("showContextMenu", function(options, position)
    SendUIMessage({
        action = "contextmenu",
        show = true,
        data = {
            options = options
        }
    })
    SetUIFocus(true, true)
end)

RegisterNUICallback("closecontext", function(data,cb)
    
    SetUIFocus(false, false)
    cb("ok")
end)


RegisterCommand("testcontextmenu", function()
    local menuData = {
        {
            title = "Lockers",
            description = "Access your personal locker",
            action = "ucrp-police:handler",
            key = "EVENTS.LOCKERS"
        },
        {
            title = "Clothing",
            description = "Gotta look Sharp",
            action = "ucrp-police:handler",
            key = "EVENTS.CLOTHING"
        },
        {
            title = "Armory",
            description = "WEF - Weapons, Equipment, Fun!",
            action = "ucrp-police:handler",
            key = "EVENTS.ARMORY"
        },
        {
            title = "Evidence",
            description = "Drop off some evidence",
            action = "ucrp-police:handler",
            key = "EVENTS.EVIDENCE",
            children = {
                { title = "Confirm Purchase", action = "ucrp-ui:rentalPurchase", key = "EVENTS.EVIDENCE" },
            },
        },
        {
            title = "Trash",
            description = "Where Spaghetti Code belongs",
            action = "ucrp-police:handler",
            key = "EVENTS.TRASH"
        },
        {
            title = "Character switch",
            description = "Go bowling with your cousin",
            action = "ucrp-police:handler",
            key = "EVENTS.SWITCHER",
            children = {
                { title = "Confirm Purchase", action = "ucrp-ui:rentalPurchase", key = "EVENTS.SWITCHER" },
            },
        },
    }
    exports["ucrp-ui"]:showContextMenu(menuData)
end)
-- Example Using This
-- type 
-- error (bg : Red) or succes ( bg : Green) or info (bg : blue)
-- Show Interaction
-- exports["ucrp-ui"]:showInteraction(msg,type)

-- Hide Interaction
-- exports["ucrp-ui"]:showInteraction(msg,type)