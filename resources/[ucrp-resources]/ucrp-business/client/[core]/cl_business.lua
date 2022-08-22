RegisterUICallback("ucrp-ui:createBusiness", function(data, cb)
  local success, message = RPC.execute("CreateBusiness", data)
  cb({ data = {}, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:getBusinessTypes", function(data, cb)
  local success, message = RPC.execute("GetBusinessTypes")
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:getBusinesses", function(data, cb)
  local success, message = RPC.execute("GetBusinesses")
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:getEmploymentInformation", function(data, cb)
  local success, message = RPC.execute("GetEmploymentInformation", data)
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:getBusinessEmployees", function(data, cb)
  local success, message = RPC.execute("GetBusinessEmployees", data)
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:getBusinessRoles", function(data, cb)
  local success, message = RPC.execute("GetBusinessRoles", data)
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:createBusinessRole", function(data, cb)
  local success, message = RPC.execute("CreateBusinessRole", data)
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:changeBusinessRole", function(data, cb)
  local success, message = RPC.execute("ChangeBusinessRole", data)
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:hireBusinessEmployee", function(data, cb)
  local success, message = RPC.execute("HireBusinessEmployee", data)
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:removeBusinessEmployee", function(data, cb)
  local success, message = RPC.execute("RemoveBusinessEmployee", data)
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:businessPayEmployee", function(data, cb)
  local success, message = RPC.execute("BusinessPayEmployee", data)
  cb({ data = message or {}, meta = { ok = success, message = message or "Unknown Error; check account balance" } })
end)

RegisterUICallback("ucrp-ui:businessPayExternal", function(data, cb)
  local success, message = RPC.execute("BusinessPayExternal", data)
  cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:businessChargeExternal", function(data, cb)
  RPC.execute("ChargeExternal", data)
  cb({ data = {}, meta = { ok = true, message = 'done' } })
end)
RegisterUICallback("ucrp-ui:businessChargeAccept", function(data, cb)
  local success, message = RPC.execute("BusinessChargeAccept", data)
  cb({ data = message, meta = { ok = success, message = message } })
end)
--[[RegisterNetEvent("business:chargeAcceptPrompt")
AddEventHandler("business:chargeAcceptPrompt", function(data)
  SendUIMessage({
    source = "ucrp-nui",
    app = "phone",
    data = {
      action = "charge-accept",
      data = data,
    },
  })
end)]]
