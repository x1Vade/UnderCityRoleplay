-- Green Tablet

RegisterNetEvent('ucrp-robberies:geenGTabletSV')
AddEventHandler('ucrp-robberies:geenGTabletSV', function()
    local src = source
    local cid = exports["ucrp-exports"]:GetPlayerCid(src)
    exports.ghmattimysql:execute('SELECT * FROM tablet_queue WHERE cid = ?', {cid}, function(result2)
        if result2[1] ~= nil then
            TriggerClientEvent('ucrp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are already in queue or you were recently in queue!'})
        else
            exports.ghmattimysql:execute("INSERT INTO tablet_queue (cid, type) VALUES (@cid, @type)", {['@cid'] = cid, ['@type'] = 'geentablet'})
            TriggerClientEvent('ucrp-robberies:getGTablet', src)
            TriggerClientEvent('ucrp-notification:client:Alert', src, {style = 'info', duration = 3000, message = 'You have been placed in a queue!'})
        end
    end)
end)

RegisterNetEvent('ucrp-robberies:removeQueueGreen')
AddEventHandler('ucrp-robberies:removeQueueGreen', function()
    local src = source
    local cid = exports["ucrp-exports"]:GetPlayerCid(src)
	exports.ghmattimysql:execute("DELETE FROM tablet_queue WHERE cid = @cid", {['cid'] = cid})
    TriggerClientEvent('ucrp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You have been removed from the queue!'})
end)

--- Blue Tablet --

RegisterNetEvent('ucrp-robberies:blueBTabletSV')
AddEventHandler('ucrp-robberies:blueBTabletSV', function()
    local src = source
    local cid = exports["ucrp-exports"]:GetPlayerCid(src)
    exports.ghmattimysql:execute('SELECT * FROM tablet_queue WHERE cid = ?', {cid}, function(result2)
        if result2[1] ~= nil then
            TriggerClientEvent('ucrp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are already in queue or you were recently in queue!'})
        else
            exports.ghmattimysql:execute("INSERT INTO tablet_queue (cid, type) VALUES (@cid, @type)", {['@cid'] = cid, ['@type'] = 'bluetablet'})
            TriggerClientEvent('ucrp-robberies:getBTablet', src)
            TriggerClientEvent('ucrp-notification:client:Alert', src, {style = 'info', duration = 3000, message = 'You have been placed in a queue!'})
        end
    end)
end)

RegisterNetEvent('ucrp-robberies:removeQueueBlue')
AddEventHandler('ucrp-robberies:removeQueueBlue', function()
    local src = source
    local cid = exports["ucrp-exports"]:GetPlayerCid(src)
	exports.ghmattimysql:execute("DELETE FROM tablet_queue WHERE cid = @cid", {['cid'] = cid})
    TriggerClientEvent('ucrp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You have been removed from the queue!'})
end)

--- Red Tablet --

RegisterNetEvent('ucrp-robberies:redTabletSV')
AddEventHandler('ucrp-robberies:redTabletSV', function()
    local src = source
    local cid = exports["ucrp-exports"]:GetPlayerCid(src)
    exports.ghmattimysql:execute('SELECT * FROM tablet_queue WHERE cid = ?', {cid}, function(result2)
        if result2[1] ~= nil then
            TriggerClientEvent('ucrp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are already in queue or you were recently in queue!'})
        else
            exports.ghmattimysql:execute("INSERT INTO tablet_queue (cid, type) VALUES (@cid, @type)", {['@cid'] = cid, ['@type'] = 'redtablet'})
            TriggerClientEvent('ucrp-robberies:getRedTablet', src)
            TriggerClientEvent('ucrp-notification:client:Alert', src, {style = 'info', duration = 3000, message = 'You have been placed in a queue!'})
        end
    end)
end)

RegisterNetEvent('ucrp-robberies:removeQueueRed')
AddEventHandler('ucrp-robberies:removeQueueRed', function()
    local src = source
    local cid = exports["ucrp-exports"]:GetPlayerCid(src)
	exports.ghmattimysql:execute("DELETE FROM tablet_queue WHERE cid = @cid", {['cid'] = cid})
    TriggerClientEvent('ucrp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You have been removed from the queue!'})
end)

AddEventHandler('onResourceStart', function(resourceName)
    exports.ghmattimysql:execute('DELETE FROM tablet_queue', {}, function (result) end)
end)