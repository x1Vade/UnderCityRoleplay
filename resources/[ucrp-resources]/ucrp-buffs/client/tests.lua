

-- local hasHealthBuffActive = false
-- local function AddHealthBuff(time, value)
--     AddBuff("super-health", time)
--     if not hasHealthBuffActive then
--         hasHealthBuffActive = true
--         CreateThread(function()
--             while HasBuff("super-health") do
--                 Wait(5000)
--                 if GetEntityHealth(PlayerPedId()) < 200 then
--                     SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + value)
--                 end
--             end
--             hasHealthBuffActive = false
--         end)
--     end
-- end exports('AddHealthBuff', AddHealthBuff)


-- local hasArmorBuffActive = false
-- local function AddArmorBuff(time, value)
--     AddBuff("super-armor", time)
--     if not hasArmorBuffActive then
--         hasArmorBuffActive = true
--         CreateThread(function()
--             while HasBuff("super-armor") do
--                 Wait(5000)
--                 if GetPedArmour(PlayerPedId()) < 100 then
--                     SetPedArmour(PlayerPedId(), GetPedArmour(PlayerPedId()) + value)
--                 end
--             end
--             hasArmorBuffActive = false
--         end)
--     end
-- end exports('AddArmorBuff', AddArmorBuff)

-- RegisterCommand("stambuff", function()
--     AddHealthBuff(50000, math.random(1,5))
--     Wait(1000)
--     AddArmorBuff(50000, math.random(1,5))
-- end)


-- exports["ucrp-buffs"]:AddHealthBuff(time in ms, buff amoount)
-- exports["ucrp-buffs"]:AddArmorBuff(time in ms, buff amoount)


-- local hasStaminaBuffActive = false
-- local function StaminaBuffEffect(time, value)
--     AddBuff("stamina", time)
--     if not hasStaminaBuffActive then 
--         hasStaminaBuffActive = true
--         CreateThread(function()
--             SetRunSprintMultiplierForPlayer(PlayerId(), value)
--             while exports['ucrp-buffs']:HasBuff("stamina") do
--                 Wait(500)
--                 SetPlayerStamina(PlayerId(), GetPlayerStamina(PlayerId()) + math.random(1,10))
--             end
--             SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
--             hasStaminaBuffActive = false
--         end)
--     end
-- end exports('StaminaBuffEffect', StaminaBuffEffect)


-- exports["ucrp-buffs"]:StaminaBuffEffect(time in ms, buff amoount)

-- local hasSwimmingBuffActive = false
-- local function SwimmingBuffEffect(time, value)
--     AddBuff("swimming", time)
--     if not hasSwimmingBuffActive then 
--         hasSwimmingBuffActive = true
--         CreateThread(function()
--             SetSwimMultiplierForPlayer(PlayerId(), value)
--             while exports['ucrp-buffs']:HasBuff("swimming") do
--                 Wait(500)
--                 SetPlayerStamina(PlayerId(), GetPlayerStamina(PlayerId()) + math.random(1,10))
--             end
--             SetSwimMultiplierForPlayer(PlayerId(), 1.0)
--             hasSwimmingBuffActive = false
--         end)
--     end
-- end exports('SwimmingBuffEffect', SwimmingBuffEffect)


-- exports["ucrp-buffs"]:SwimmingBuffEffect(time in ms, buff ammount)

-- CreateThread(function()
--     while true do
--         local sleep = 0
--         if LocalPlayer.state.isLoggedIn then
--             sleep = (1000 * 60) * QBCore.Config.UpdateInterval
--             local hungerRate = 0
--             local thirstRate = 0
--             if exports["ucrp-buffs"]:HasBuff("super-hunger") then hungerRate = QBCore.Config.Player.HungerRate/2 else hungerRate = QBCore.Config.Player.HungerRate end
--             if exports["ucrp-buffs"]:HasBuff("super-thirst") then thirstRate = QBCore.Config.Player.ThirstRate/2 else thirstRate = QBCore.Config.Player.ThirstRate end
--             TriggerServerEvent('QBCore:UpdatePlayer', hungerRate, thirstRate)
--         end
--         Wait(sleep)
--     end
-- end)

-- RegisterNetEvent('QBCore:UpdatePlayer', function(hungerRate, thirstRate)
--     print('Updating Player', hungerRate, thirstRate)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     if not Player then return end
--     local newHunger = Player.PlayerData.metadata['hunger'] - hungerRate
--     local newThirst = Player.PlayerData.metadata['thirst'] - thirstRate
--     if newHunger <= 0 then
--         newHunger = 0
--     end
--     if newThirst <= 0 then
--         newThirst = 0
--     end
--     Player.Functions.SetMetaData('thirst', newThirst)
--     Player.Functions.SetMetaData('hunger', newHunger)
--     TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)
--     Player.Functions.Save()
-- end)
-- RegisterNetEvent('QBCore:Player:UpdatePlayerData', function()
--     local hungerRate = 0
--     local thirstRate = 0
--     if exports["ucrp-buffs"]:HasBuff("super-hunger") then hungerRate = QBCore.Config.Player.HungerRate/2 else hungerRate = QBCore.Config.Player.HungerRate end
--     if exports["ucrp-buffs"]:HasBuff("super-thirst") then thirstRate = QBCore.Config.Player.ThirstRate/2 else thirstRate = QBCore.Config.Player.ThirstRate end
--     TriggerServerEvent('QBCore:UpdatePlayer', hungerRate, thirstRate)
-- end)
