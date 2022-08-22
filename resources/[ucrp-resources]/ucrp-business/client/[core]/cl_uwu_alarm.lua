AddEventHandler("ucrp-uwucafee:silentAlarm", function()
  local finished = exports["ucrp-taskbar"]:taskBar(4000, _L("uwucafee-pressing-alarm", "Pressing Alarm"))
  if finished ~= 100 then return end
  TriggerServerEvent("ucrp-uwucafee:triggerSilentAlarm", GetEntityCoords(PlayerPedId()))
end)
