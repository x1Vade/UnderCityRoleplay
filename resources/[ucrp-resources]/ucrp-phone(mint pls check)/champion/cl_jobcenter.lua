local status = false
RegisterNUICallback('importados', function()
  SendNUIMessage({ openSection = "importados", showCarPaymentsOwed = showCarPayments, vehicleData = parsedVehicleData})
end)

RegisterNUICallback('job-center', function(data, cb)
  -- local idle = RPC.execute("ucrp-phone:getIdleGroup")
  -- local myG = RPC.execute("ucrp-phone:getMyGroup")
  -- local data, members = RPC.execute("ucrp-phone:getGroupSanitation")
  -- local myGroup = RPC.execute('ucrp-phone:getMyGroup',exports['isPed']:isPed('cid'))
  -- local members = RPC.execute("ucrp-phone:get_groupsMem")
  SendNUIMessage({
    openSection = "job-center",
    idle = idle,
    myG = myG,
    members = members,
    mysrc = GetPlayerServerId(PlayerId())
  })
end)

RegisterNetEvent('refreshJobCenter')
AddEventHandler('refreshJobCenter', function()
  -- local idle = RPC.execute("ucrp-phone:getIdleGroup")
  -- local myG = RPC.execute("ucrp-phone:getMyGroup")
  -- local data, members = RPC.execute("ucrp-phone:getGroupSanitation")
  -- -- print(json.encode(data),data)
  -- local myGroup = RPC.execute('ucrp-phone:getMyGroup',exports['isPed']:isPed('cid'))
  -- local members = RPC.execute("ucrp-phone:get_groupsMem")
  SendNUIMessage({
    openSection = "job-center",
    -- idle = idle,
    -- myG = myG,
    -- members = members,
    mysrc = GetPlayerServerId(PlayerId())
  })
end)

RegisterNUICallback('setwaypointImpound', function()
  SetNewWaypoint(1587.6922607422, 3841.8198242188)
end)

RegisterNUICallback('c_group', function()
  local create = RPC.execute("ucrp-phone:c_group")
end)

RegisterNUICallback('j_group', function(data)
  local gId = data.gId
  RPC.execute("ucrp-phone:j_group", gId)
end)

RegisterNUICallback('group_status', function(data)
  status = data.status
  local gId = data.gid
  RPC.execute("ucrp-phone:g_ready",status,id)
end)

RegisterNUICallback('leave_group', function(data)
  local gId = data.gid
  RPC.execute('ucrp-phone:leave_group', gId)
end)

RegisterCommand('group', function()
  local members = RPC.execute("ucrp-phone:get_groupsMem")
end)