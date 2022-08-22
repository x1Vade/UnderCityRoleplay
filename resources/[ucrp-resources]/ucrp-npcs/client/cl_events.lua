RegisterNetEvent("ucrp-npcs:set:ped")
AddEventHandler("ucrp-npcs:set:ped", function(pNPCs)
  if type(pNPCs) == "table" then
    for _, ped in ipairs(pNPCs) do
      RegisterNPC(ped, 'ucrp-npcs')
      EnableNPC(ped.id)
    end
  else
    RegisterNPC(ped, 'ucrp-npcs')
    EnableNPC(ped.id)
  end
end)

RegisterNetEvent("ucrp-npcs:ped:giveStolenItems")
AddEventHandler("ucrp-npcs:ped:giveStolenItems", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
 -- local npcCoords = GetEntityCoords(pEntity)
  local finished = exports["ucrp-taskbar"]:taskBar(15000, "Preparing to receive goods, don't move.")
  if finished == 100 then
   -- if #(GetEntityCoords(PlayerPedId()) - npcCoords) < 2.0 then
      TriggerEvent("server-inventory-open", "1", "Stolen-Goods-1")
    else
      TriggerEvent("DoLongHudText", "You moved too far you idiot.", 105)
    end
  end)

RegisterNetEvent("ucrp-npcs:ped:exchangeRecycleMaterial")
AddEventHandler("ucrp-npcs:ped:exchangeRecycleMaterial", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
 -- local npcCoords = GetEntityCoords(pEntity)
  local finished = exports["ucrp-taskbar"]:taskBar(3000, "Preparing to exchange material, don't move.")
  if finished == 100 then
   -- if #(GetEntityCoords(PlayerPedId()) - npcCoords) < 2.0 then
      TriggerEvent("server-inventory-open", "103", "Craft");
    else
      TriggerEvent("DoLongHudText", "You moved too far you idiot.", 105)
    end
end)

RegisterNetEvent("ucrp-npcs:ped:signInJob")
AddEventHandler("ucrp-npcs:ped:signInJob", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  if #pArgs == 0 then
    local npcId = DecorGetInt(pEntity, 'NPC_ID')
    if npcId == `news_reporter` then
      TriggerServerEvent("jobssystem:jobs", "news")
    elseif npcId == `head_stripper` then
      TriggerServerEvent("jobssystem:jobs", "entertainer")
    end
  else
    TriggerServerEvent("jobssystem:jobs", "unemployed")
  end
end)

RegisterNetEvent("ucrp-npcs:ped:paycheckCollect")
AddEventHandler("ucrp-npcs:ped:paycheckCollect", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  TriggerServerEvent("server:paySlipPickup")
end)

RegisterNetEvent("ucrp-npcs:ped:receiptTradeIn")
AddEventHandler("ucrp-npcs:ped:receiptTradeIn", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  local cid = exports["isPed"]:isPed("cid")
  local accountStatus, accountTarget = RPC.execute("GetDefaultBankAccount", cid)
  if not accountStatus then return end
  RPC.execute("ucrp-inventory:tradeInReceipts", cid, accountTarget)
end)

RegisterNetEvent("ucrp-npcs:ped:sellStolenItems")
AddEventHandler("ucrp-npcs:ped:sellStolenItems", function()
  RPC.execute("ucrp-inventory:sellStolenItems")
end)

RegisterNetEvent("ucrp-npcs:ped:keeper")
AddEventHandler("ucrp-npcs:ped:keeper", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  TriggerEvent("server-inventory-open", pArgs[1], "Shop");
end)


TriggerServerEvent("ucrp-npcs:location:fetch")

AddEventHandler("ucrp-npcs:ped:weedSales", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  local result, message = RPC.execute("ucrp-npcs:weedShopOpen")
  if not result then
    TriggerEvent("DoLongHudText", message, 2)
    return
  end
  TriggerEvent("server-inventory-open", "44", "Shop");
end)

AddEventHandler("ucrp-npcs:ped:licenseKeeper", function()
  RPC.execute("ucrp-npcs:purchaseDriversLicense")
end)

