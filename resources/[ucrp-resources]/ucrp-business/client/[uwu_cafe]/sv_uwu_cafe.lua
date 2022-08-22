-- Uwu Cafe

Registers = {
    [1] = {},
    [2] = {}
}

RegisterServerEvent('uwu_cafe:OrderComplete')
AddEventHandler("uwu_cafe:OrderComplete", function(regID, price, comment)
    local insert = {
        owner = source, 
        price = price, 
        comment = comment,
        regID = regID
    }
    Registers[regID] = {}
    table.insert(Registers[regID], insert)
end)

RegisterServerEvent("uwu_cafe:retreive:receipt")
AddEventHandler("uwu_cafe:retreive:receipt", function(regID)
    local src = source
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if Registers[regID] then
        for i = 1, #Registers[regID] do
            if Registers[regID][i].regID == regID then
                local amount = Registers[regID][i].price
                if (tonumber(user:getCash()) >= tonumber(amount)) then
                    user:removeMoney(tonumber(amount))
                    local owner = exports["ucrp-base"]:getModule("Player"):GetUser(Registers[regID][i].owner)
                    local char = owner:getCurrentCharacter()
                    information = {
                        ["Price"] = tonumber(amount),
                        ["Creator"] = char.first_name .. " " ..char.last_name,
                        ["Comment"] = Registers[regID][i].comment
                    }

                    TriggerClientEvent("player:receiveItem", Registers[regID][i].owner, "ownerreceipt", 1, true, information)
                    TriggerClientEvent("player:receiveItem", src, "receipt", 1, true, {["Comment"] = "Thanks for your order at uWu Cafe"})
                    TriggerEvent("uwu_cafe:update:registers", regID)
                else
                    TriggerClientEvent("DoLongHudText", src, "You cant afford this payment", 2)
                end
            end
        end
    else
        TriggerClientEvent("DoLongHudText", src, "Payment not ready..", 2)
    end
end) 

RegisterServerEvent("uwu_cafe:update:registers")
AddEventHandler("uwu_cafe:update:registers", function(regID)
    for k, v in pairs(Registers[regID]) do
        table.remove(Registers[regID], k)
    end
end)

RegisterServerEvent("uwu_cafe:update:pay")
AddEventHandler("uwu_cafe:update:pay", function(cid)
    local src = source
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getVar("character").id
    local invname = 'ply-'..characterId
    exports.oxmysql:execute("SELECT `slot`, `information` FROM user_inventory2 WHERE name = ? AND `item_id` = ? ORDER BY slot DESC", {invname, "ownerreceipt"}, function(data)
        if data[1] then
            local slot = data[1].slot
            local jsonparse = json.decode(data[1].information)
            exports.oxmysql:execute("SELECT `paycheck` FROM characters WHERE id = ?", {characterId}, function(old)
                local before = old[1].paycheck
                exports.oxmysql:execute("UPDATE characters SET `paycheck` = @paycheck WHERE `id` = @id", {
                    ['@paycheck'] = old[1].paycheck + jsonparse["Price"],
                    ['@id'] = characterId
                })
                TriggerClientEvent('DoLongHudText', src, 'Your paycheck was updated', 1)
                TriggerClientEvent("Yougotpaid", src, characterId)
                exports.oxmysql:execute('DELETE FROM user_inventory2 WHERE `name`= ? AND `item_id`= ? AND `slot`= ?', {invname, "ownerreceipt", slot})
            end)
        else
            TriggerClientEvent("DoLongHudText", src, "You dont have any work receipts to cash in")
        end
    end)
end)

RPC.register("ucrp-jobs:addcash", function(pAmount)
    local pSrc = source
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
    if not pAmount then
        return
    end
    user:addMoney(pAmount)
end)