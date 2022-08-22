local guiEnabled = false
local pTabletOpen = false

function pNotify()
  return phoneNotifications
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent("phoneEnabled")
AddEventHandler("phoneEnabled", function(phoneopensent)
  phoneopen = phoneopensent
end)

function LoadAnimationDic(dict)
  if not HasAnimDictLoaded(dict) then
      RequestAnimDict(dict)

      while not HasAnimDictLoaded(dict) do
          Citizen.Wait(0)
      end
  end
end

function getCardinalDirectionFromHeading()
  local heading = GetEntityHeading(PlayerPedId())
  if heading >= 315 or heading < 45 then
      return "North Bound"
  elseif heading >= 45 and heading < 135 then
      return "West Bound"
  elseif heading >= 135 and heading < 225 then
      return "South Bound"
  elseif heading >= 225 and heading < 315 then
      return "East Bound"
  end
end

local function playAnimation()
  LoadAnimationDic("amb@code_human_in_bus_passenger_idles@female@tablet@base")
  TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@base", "base", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
  TriggerEvent("attachItemPhone", "tablet01")
end

RegisterNetEvent("ucrp-racing:openGUI")
AddEventHandler("ucrp-racing:openGUI", function()
  openGui()
end)

RegisterCommand('open', function()
    openGui()
end)

function openGui()
  if recentopen then
    return
  end
  pTabletOpen = true
  playAnimation()
  GiveWeaponToPed(PlayerPedId(), 0xA2719263, 0, 0, 1)
  guiEnabled = true
  SetNuiFocus(false,false)
  SetNuiFocus(true,true)
  local decrypt = false
  SendNUIMessage({openPhone = true, pOpenPhone = true, playerId = GetPlayerServerId(PlayerId())})
  recentopen = false
end

-- Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false,false)
  SendNUIMessage({openPhone = false})
  StopAnimTask(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@base", "base", 1.0)
  TriggerEvent("destroyPropPhone")
  guiEnabled = false
  pTabletOpen = false
  recentopen = true
  Citizen.Wait(500)
  recentopen = false
end

RegisterNetEvent('ucrp-racing:UpdateStatePhone')
AddEventHandler('ucrp-racing:UpdateStatePhone', function()
    Wait(5)
    if callStatus == isCallInProgress then 
      SendNUIMessage({openSection = "phonemedio"}) 
    end
end)

function closeGui2()
  SetNuiFocus(false,false)
  SendNUIMessage({openPhone = false})
  guiEnabled = false
  recentopen = true
  Citizen.Wait(500)
  recentopen = false  
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
  TriggerEvent('AttachWeapons')
end)

RegisterNetEvent('phone:close')
AddEventHandler('phone:close', function(number, message)
  closeGui()
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end