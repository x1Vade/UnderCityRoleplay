RegisterNetEvent("mission:completed")
AddEventHandler("mission:completed", function(amount)
    local src = source
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    local remove = tonumber(amount)
    user:addMoney(remove)--- MintHavoc Change Banking
    TriggerClientEvent('isPed:UpdateCash', src, user:getCash())
end)