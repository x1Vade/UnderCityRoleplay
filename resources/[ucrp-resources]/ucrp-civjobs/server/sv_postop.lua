

RegisterServerEvent('dreams-civjobs:post-op-payment')
AddEventHandler('dreams-civjobs:post-op-payment', function()
    local src = tonumber(source)
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    local payment = math.random(1250, 1500)
    user:addBank(payment)
    TriggerClientEvent('DoLongHudText', src, 'You completed the delivery and got $'..payment , 1)

    exports["ucrp-log"]:AddLog("Civ Jobs", 
        src, 
        "PostOp Payment", 
        { amount = tostring(payment) })
end)