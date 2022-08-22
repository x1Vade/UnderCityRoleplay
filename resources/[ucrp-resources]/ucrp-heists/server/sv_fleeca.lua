local banks = {
    [1] = {x = 146.88589477539, y = -1046.0769042969, z = 29.368082046509, h = 244.70774841309, robbing = false, rob = {}},
    [2] = {x = -1210.7919921875, y = -336.4977722168, z = 37.781051635742, h = 296.38696289062, robbing = false, rob = {}},
    [3] = {x = -2956.5356445312, y = 481.47354125977, z = 15.69708442688, h = 358.35528564453, robbing = false, rob = {}},
    [4] = {x = 311.11526489258, y = -284.50228881836, z = 54.164810180664, h = 248.95367431641, robbing = false, rob = {}},
    [5] = {x = -353.90893554688, y = -55.3796043396, z = 49.036602020264, h = 251.66346740723, robbing = false, rob = {}},
    [6] = {x = 1176.0682373047, y = 2712.8735351562, z = 38.088050842285, h = 87.942642211914, robbing = false, rob = {}}
}

RegisterNetEvent('ucrp-robbery:smallBankAttempt')
AddEventHandler('ucrp-robbery:smallBankAttempt', function(bId)
    if banks[bId] == nil then return end
    if banks[bId]['robbing'] then
        TriggerClientEvent('DoLongHudText', source, 'This bank is already robbed.', 2)
        return
    end

    banks[bId]['robbing'] = true
    TriggerClientEvent('ucrp-robbery:updateBankData', -1, banks)
end)

RegisterNetEvent('ucrp-robbery:sBankBox')
AddEventHandler('ucrp-robbery:sBankBox', function(bId, iType)

    banks[bId]['rob'][iType] = true
    TriggerClientEvent('ucrp-robbery:updateBankData', -1, banks)
    TriggerClientEvent('ucrp-robbery:sBankLoot', source)
end)

RegisterNetEvent('ucrp-robbery:PoliceNotifyFleeeee')
AddEventHandler('ucrp-robbery:PoliceNotifyFleeeee', function()

    TriggerClientEvent("ucrp-fleeca:policenotify", -1, bank)

end)
