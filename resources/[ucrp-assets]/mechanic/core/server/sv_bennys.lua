local koil = vehicleBaseRepairCost

RegisterServerEvent('mechanic:attemptPurchase')
AddEventHandler('mechanic:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= koil then --- MintHavoc Change Banking
            user:removeMoney(koil) --- MintHavoc Change Banking
            TriggerClientEvent('mechanic:purchaseSuccessful', source)
        else
            TriggerClientEvent('mechanic:purchaseFailed', source)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then --- MintHavoc Change Banking
            TriggerClientEvent('mechanic:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel]) --- MintHavoc Change Banking
        else
            TriggerClientEvent('mechanic:purchaseFailed', source)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then --- MintHavoc Change Banking
            TriggerClientEvent('mechanic:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].price) --- MintHavoc Change Banking
        else
            TriggerClientEvent('mechanic:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('mechanic:updateRepairCost')
AddEventHandler('mechanic:updateRepairCost', function(cost)
    koil = cost
end)
