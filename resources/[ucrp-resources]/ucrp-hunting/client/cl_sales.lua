local carcasses = {
    { name = "huntingcarcass1", price = 250, illegal = false },
    { name = "huntingcarcass2", price = 500, illegal = false },
    { name = "huntingcarcass3", price = 1000, illegal = false },
    { name = "huntingcarcass4", price = 18, illegal = true },
}
local nightTime = false

local function sellAnimals()
    local totalCash = 0
    local totalBMarketCash = 0

    for _, carcass in pairs(carcasses) do
        local qty = exports["ucrp-inventory"]:getQuantity(carcass.name)

        if qty > 0 then
            if not carcass.illegal then
                totalCash = totalCash + (carcass.price * qty)
                TriggerEvent("inventory:removeItem", carcass.name, qty)
            elseif nightTime then
                totalBMarketCash = totalBMarketCash + (carcass.price * qty)
                TriggerEvent("inventory:removeItem", carcass.name, qty)
            end
        end
    end

    if totalCash == 0 and totalBMarketCash == 0 then
        TriggerEvent("DoLongHudText", "Nothing to sell, dummy.", 2)
    end
    
    if totalCash > 0 then
        RPC.execute("givePlayerJobPay", "hunting_sales", totalCash)
        TriggerEvent("DoLongHudText", "Added to bank!")
    end

    if totalBMarketCash > 0 then
        TriggerEvent("player:receiveItem", "band", totalBMarketCash)
    end
end

local listening = false
local function listenForKeypress()
    listening = true
    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) then
                listening = false
                exports["ucrp-ui"]:hideInteraction()
                sellAnimals()
            end
            Wait(0)
        end
    end)
end

AddEventHandler("ucrp-polyzone:enter", function(name)
    if name ~= "huntingsales" then return end
    exports["ucrp-ui"]:showInteraction("[E] Sell Animal Carcass")
    listenForKeypress()
end)
AddEventHandler("ucrp-polyzone:exit", function(name)
    if name ~= "huntingsales" then return end
    exports["ucrp-ui"]:hideInteraction()
    listening = false
end)
RegisterNetEvent("timeheader")
AddEventHandler("timeheader", function(pHour, pMinutes)
    if pHour > 19 or pHour < 5 then
        nightTime = true
    else
        nightTime = false
    end
end)
