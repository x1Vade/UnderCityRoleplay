local hmm = vehicleBaseRepairCost

RegisterServerEvent('ucrp-bennys:attemptPurchase')
AddEventHandler('ucrp-bennys:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= hmm then
            user:removeMoney(hmm)
            TriggerClientEvent('ucrp-bennys:purchaseSuccessful', src)

            exports["ucrp-log"]:AddLog("Bennys", 
                src, 
                "Repair", 
                { amount = tostring(hmm) })
        else
            TriggerClientEvent('ucrp-bennys:purchaseFailed', src)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('ucrp-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])

            exports["ucrp-log"]:AddLog("Bennys", 
                src, 
                "Performance", 
                { amount = tostring(vehicleCustomisationPrices[type].prices[upgradeLevel]) })
        else
            TriggerClientEvent('ucrp-bennys:purchaseFailed', src)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('ucrp-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].price)

            exports["ucrp-log"]:AddLog("Bennys", 
                src, 
                "Other", 
                { type = tostring(type), amount = tostring(vehicleCustomisationPrices[type].price) })
        else
            TriggerClientEvent('ucrp-bennys:purchaseFailed', src)
        end
    end
end)

RegisterServerEvent('ucrp-bennys:updateRepairCost')
AddEventHandler('ucrp-bennys:updateRepairCost', function(cost)
    hmm = cost
end)

RegisterServerEvent('ucrp-bennys:repairciv')
AddEventHandler('ucrp-bennys:repairciv', function(amount)
    local src = source
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    if (user:getCash() >= amount) then
        user:removeMoney(amount)
        TriggerClientEvent("bennys:civ:repair:cl", src)

        exports["ucrp-log"]:AddLog("Bennys", 
            src, 
            "Repair Civ", 
            { amount = tostring(amount) })
    end
end)