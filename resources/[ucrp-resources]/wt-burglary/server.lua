local robbableItems = {
  [1] = {chance = 10, id = 0, quantity = math.random(50, 300)},
  [2] = {chance = 5, id = 'plastic', quantity = math.random(1, 3)},
  [3] = {chance = 13, id = 'pistolammo', quantity = math.random(1,3)},
  [4] = {chance = 8, id = 'oxy', quantity = math.random(1,3)},
  [5] = {chance = 45, id = 'heavydutydrill', quantity = 1},
  [6] = {chance = 45, id = 'crowbar', quantity = 1},
  [7] = {chance = 9, id = 'lockpick', quantity = 1},
  [8] = {chance = 30, id = 'stolen2ctchain', quantity = math.random(1,4)},
  [9] = {chance = 31, id = 'stolen8ctchain', quantity = math.random(1,3)},
  [10] = {chance = 32, id = 'stolen10ctchain', quantity = math.random(1,2)},
  [11] = {chance = 25, id = 'decrypterenzo', quantity = 1},
  [12] = {chance = 17, id = 'pix2', quantity = 1},
  [13] = {chance = 14, id = 'rolexwatch', quantity = math.random(1,6)},
  [14] = {chance = 38, id = 'usbdevice', quantity = 1},
  [15] = {chance = 50, id = 'cuffs', quantity = 1},
  [16] = {chance = 5, id = 'aluminium', quantity = math.random(1,3)},
  [17] = {chance = 5, id = 'steel', quantity = math.random(1,3)},
  [18] = {chance = 5, id = 'maleseed', quantity = math.random(1,3)},
  [19] = {chance = 5, id = 'femaleseed', quantity = math.random(1,3)},
  [20] = {chance = 7, id = 'sandwich', quantity = math.random(1,2)},
  [21] = {chance = 7, id = 'water', quantity = math.random(1,2)},
  [22] = {chance = 5, id = 'stolengameboy', quantity = math.random(2,4)},
  [23] = {chance = 5, id = 'stoleniphone', quantity = math.random(1,2)},
  [24] = {chance = 5, id = 'stolenraybans', quantity = math.random(1,2)},
  [25] = {chance = 4, id = 'stolenpsp', quantity = math.random(3,5)},
  [26] = {chance = 5, id = 'stolenpixel3', quantity = math.random(1,2)},
  [27] = {chance = 5, id = 'stolenoakleys', quantity = math.random(1,2)},
  [28] = {chance = 5, id = 'stolennokia', quantity = math.random(1,2)},
  [29] = {chance = 5, id = 'stolencasiowatch', quantity = math.random(3,4)},
  [30] = {chance = 25, id = 'stolen5ctchain', quantity = math.random(1,2)},
  [31] = {chance = 30, id = 'wedding', quantity = math.random(1,2)},
  [32] = {chance = 27, id = 'ering', quantity = math.random(1,2)},
  [33] = {chance = 7, id = 'boomerphone', quantity = math.random(1,2)},
  [34] = {chance = 20, id = 'armor', quantity = math.random(1,2)},
  [35] = {chance = 25, id = 'zebra', quantity = 1},
  [36] = {chance = 25, id = 'wlilies', quantity = 1},
  [37] = {chance = 25, id = 'weeping', quantity = 1},
  [38] = {chance = 25, id = 'telvis', quantity = 1},
 }
 
 RegisterServerEvent('houseRobberies:removeLockpick')
 AddEventHandler('houseRobberies:removeLockpick', function()
  local source = tonumber(source)
  local user = exports["wt-base"]:getModule("Player"):GetUser(source)
  TriggerClientEvent('inventory:removeItem', source, 'lockpick', 1)
  TriggerClientEvent('DoLongHudText',  source, 'The lockpick bent out of shape' , 1)
 end)
 
 RegisterServerEvent('houseRobberies:giveMoney')
 AddEventHandler('houseRobberies:giveMoney', function()
  local source = tonumber(source)
  local user = exports["wt-base"]:getModule("Player"):GetUser(source)
  local cash = math.random(500, 850)
  user:addMoney(cash)
  TriggerClientEvent('DoLongHudText',  source, 'You found a $'..cash , 1)
  TriggerClientEvent("robbery:register:finishedLockpick", source)
  TriggerClientEvent("houseRobberies:reset", source)
 end)
 
 
 RegisterServerEvent('houseRobberies:searchItem')
 AddEventHandler('houseRobberies:searchItem', function()
  local source = tonumber(source)
  local item = {}
  local user = exports["wt-base"]:getModule("Player"):GetUser(source)
  local gotID = {}
 
  for i=1, math.random(1, 2) do
   item = robbableItems[math.random(1, #robbableItems)]
   if math.random(1, 100) >= item.chance then
     if tonumber(item.id) == 0 and not gotID[item.id] then
       gotID[item.id] = true
       user:addMoney(item.quantity)
       TriggerClientEvent('DoLongHudText',  source, 'You found $'..item.quantity , 1)
     elseif not gotID[item.id] then
       gotID[item.id] = true
       TriggerClientEvent('player:receiveItem', source, item.id, item.quantity)
       TriggerEvent("client:newStress",true, 150)
     end
   else
     TriggerClientEvent('DoLongHudText', source, 'You found nothing', 1)
     end
   end
 end)
 