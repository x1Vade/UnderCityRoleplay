AddEventHandler("ucrp-foodchain:silentAlarm", function()
  local finished = exports["ucrp-taskbar"]:taskBar(4000, _L("foodchain-pressing-alarm", "Pressing Alarm"))
  if finished ~= 100 then return end
  TriggerServerEvent("ucrp-foodchain:triggerSilentAlarm", GetEntityCoords(PlayerPedId()))
end)
