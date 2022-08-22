NPX.SpawnManager = {}

RegisterServerEvent('ucrp-base:spawnInitialized')
AddEventHandler('ucrp-base:spawnInitialized', function()
    local src = source
    TriggerClientEvent('ucrp-base:spawnInitialized', src)
end)