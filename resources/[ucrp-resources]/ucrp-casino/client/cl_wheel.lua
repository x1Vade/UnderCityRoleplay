-- local _wheel = nil
-- local _lambo = nil
-- local _isShowCar = false
-- local _wheelPos = vector3(1109.76, 227.89, -49.64)
-- local _baseWheelPos = vector3(1111.05, 229.81, -50.38)

AddEventHandler("ucrp-casino:wheel:toggleEnable", function()
  local characterId = exports["isPed"]:isPed("cid")
  local jobAccess = RPC.execute("IsEmployedAtBusiness", { character = { id = characterId }, business = { id = "casino" } })
  if not jobAccess then
    TriggerEvent("DoLongHudText", "You cannot do that", 2)
    return
  end
  RPC.execute("ucrp-casino:wheel:toggleEnabled")
end)

AddEventHandler("ucrp-casino:wheel:spinWheel", function()
  if not hasMembership(false) then
    TriggerEvent("DoLongHudText", "You must have a membership", 2)
    return
  end
  -- local info = (exports["ucrp-inventory"]:GetInfoForFirstItemOfName("casinoloyalty") or { information = "{}" })
  -- RPC.execute("ucrp-casino:wheel:spinWheel", false, json.decode(info.information).state_id)
  TriggerServerEvent("ucrp-luckywheel:getLucky")
end)

AddEventHandler("ucrp-casino:wheel:spinWheelTurbo", function()
  if not hasMembership(false) then
    TriggerEvent("DoLongHudText", "You must have a membership", 2)
    return
  end
  local info = (exports["ucrp-inventory"]:GetInfoForFirstItemOfName("casinoloyalty") or { information = "{}" })
  RPC.execute("ucrp-casino:wheel:spinWheel", true, json.decode(info.information).state_id)
end)
AddEventHandler("np-casino:wheel:toggleEnable", function()
  local characterId = exports["isPed"]:isPed("cid")
  local jobAccess = RPC.execute("IsEmployedAtBusiness", { character = { id = characterId }, business = { id = "casino" } })
  if not jobAccess then
    TriggerEvent("DoLHudText", 2, "casino-cannot-do-that", "You cannot do that")
    return
  end
  RPC.execute("np-casino:wheel:toggleEnabled")
end)

AddEventHandler("np-casino:wheel:spinWheelOmega", function()
  if not hasMembership(false) then
    TriggerEvent("DoLHudText", 2, "casino-must-membership", "You must have a membership")
    return
  end
  local info = (exports["np-inventory"]:GetInfoForFirstItemOfName("casinoloyalty") or { information = "{}" })
  RPC.execute("np-casino:wheel:spinWheel", "omega", json.decode(info.information).state_id)
end)



