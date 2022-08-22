function GetSociety(name)
    local result = MySQL.Sync.fetchAll('SELECT * FROM society WHERE name= ?', {name}) --exports['ghmattimysql']:execute("SELECT * FROM `society` WHERE `name` ='"..name.."' ")
    local data = result[1]

    return data
end


RegisterNetEvent('banking:society:server:WithdrawMoney')
AddEventHandler('banking:society:server:WithdrawMoney', function(pSource, a, n)
    local src = pSource
    if not src then return end

    local player = ucrp-base.Functions.GetPlayer(src)
    if not player then return end

    if not a then return end
    if not n then return end

    local s = GetSociety(n)
    local sMoney = tonumber(s.money)
    local amount = tonumber(a)
    local withdraw = sMoney - amount

    local setter = MySQL.Sync.fetchAll("UPDATE society SET money =  ? WHERE name = ?", {withdraw, n})
end)

RegisterServerEvent('banking:society:server:DepositMoney')
AddEventHandler('banking:society:server:DepositMoney', function(pSource, a, n)
    local src = pSource
    if not src then return end

    local player = ucrp-base.Functions.GetPlayer(src)
    if not player then return end

    if not a then return end
    if not n then return end

    local s = GetSociety(n)
    local sMoney = tonumber(s.money)
    local amount = tonumber(a)
    local deposit = sMoney + amount

    
    local setter = MySQL.Sync.fetchAll("UPDATE society SET money =  ? WHERE name = ?", {deposit, n})
end)