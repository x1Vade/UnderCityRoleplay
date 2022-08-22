--[[

    Variables

]]

local success = {}
local await = false

--[[

    Functions

]]

function showInput(data)
    if not data or await then return end

    success = {}

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data,
    })

    await = true
    while await do Wait(0) end

    if success ~= nil and next(success) ~= nil then
        return success
    end

    return {}
end

--[[

    Exports

]]

exports("showInput", showInput)

--[[

    NUI

]]

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    success = data.data
    await = false
    cb("ok")
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
    success = nil
    await = false
end)

--[[

    Threads

]]

--[[ RegisterNetEvent(pParams)
    Citizen.CreateThread(function()
        Citizen.Wait(500)

        local keyboard = showInput({
            {
                id = stateid,
                icon = "user",
                label = "State ID",
                name = "stateid",
                parameters = {
                    class = "state_id"
                }
            },
            {
                id = amount,
                icon = "bill",
                label = "Amount",
                name = "amount",
                parameters = {
                    class = "amount_id"
                }
            },
        })

        print(json.encode(keyboard))
        if keyboard["stateid"] and keyboard["amount"] then
            TriggerEvent("casino:chipstransfer", keyboard["stateid"], keyboard["amount"], pParams.class)
        end
    end)
end)

RegisterNetEvent("casino:chipstransfer")
AddEventHandler("casino:chipstransfer", function()
    if pClass == "state_id" then
        TriggerEvent("DoLongHudText", stateid, 1)

    elseif pClass == "amount_id" then
        TriggerEvent("DoLongHudText", amount, 1)
    end
end) ]]