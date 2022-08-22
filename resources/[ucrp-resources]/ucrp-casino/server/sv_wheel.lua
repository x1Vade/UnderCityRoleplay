local wheelEnabled = false
local wheelSpinning = false

RegisterServerEvent("ucrp-casino:wheel:toggleEnabled", function(pSource)
    wheelEnabled = not wheelEnabled
    TriggerClientEvent("DoLongHudText", pSource, "Wheel is now " .. (wheelEnabled and "active!" or "inactive"))
end)

RPC.register("ucrp-casino:wheel:spinWheel", function(pSource)
    if not wheelEnabled then
        TriggerClientEvent("DoLongHudText", pSource, "Wheel is not active", 2)
        return
    end
    if wheelSpinning then TriggerClientEvent("DoLongHudText", pSource, "Spin already in progress", 2)
        return
    end
    local user = exports['ucrp-base']:getModule("Player"):GetUser(pSource)
    local cash = user:getCash()
    if cash < 500 then
        TriggerClientEvent("DoLongHudText", pSource, "Not enough cash ($500)", 2)
        return
    end
    user:removeMoney(500)
    TriggerClientEvent("ucrp-financials:cash:give", pSource, user:getCash())
    wheelSpinning = true
    TriggerClientEvent("DoLongHudText", pSource, "Good luck!")
    Citizen.CreateThread(function()
        Citizen.Wait(30000)
        wheelSpinning = false
    end)
    TriggerClientEvent("ucrp-casino:casino:spinwheel:roll")
end)

