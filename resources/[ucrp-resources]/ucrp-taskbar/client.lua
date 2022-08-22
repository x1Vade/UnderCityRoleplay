local lockpos = false
local insidePrompt = false
-- openGui(length,math.random(1000000))
function openGui(sentLength,taskID,namesent,keepWeapon)
    if not keepWeapon then
        TriggerEvent("actionbar:setEmptyHanded")
    end
    guiEnabled = true
    SendNUIMessage({runProgress = true, Length = sentLength, Task = taskID, name = namesent})
end
function updateGui(sentLength,taskID,namesent)
    SendNUIMessage({runUpdate = true, Length = sentLength, Task = taskID, name = namesent})
end
local activeTasks = {}
function closeGuiFail()
    guiEnabled = false
    SendNUIMessage({closeFail = true})
    ClearPedTasks(PlayerPedId())
end
function closeGui()
    guiEnabled = false
    SendNUIMessage({closeProgress = true})
    ClearPedTasks(PlayerPedId())
end

function closeNormalGui()
    guiEnabled = false
end

RegisterNUICallback('taskCancel', function(data, cb)
  closeGui()
  local taskIdentifier = data.tasknum
  activeTasks[taskIdentifier] = 2
end)

RegisterNUICallback('taskEnd', function(data, cb)
  closeNormalGui()
  
  local taskIdentifier = data.tasknum
  activeTasks[taskIdentifier] = 3
end)
local coffeetimer = 0

RegisterNetEvent('coffee:drink')
AddEventHandler('coffee:drink', function()
    if coffeetimer > 0 then
        coffeetimer = 6000
        TriggerEvent("Evidence:StateSet",27,6000)
        return
    else
        TriggerEvent("Evidence:StateSet",27,6000)
        coffeetimer = 6000
    end

    while coffeetimer > 0 do
        coffeetimer = coffeetimer - 1
        Wait(1000)
    end

end)


-- command is something we do in the loop if we want to disable more, IE a vehicle engine. --
-- return true or false, if false, gives the % completed. --
local taskInProcess = false
function taskBar(length,name,runCheck,keepWeapon,vehicle,vehCheck)
    local playerPed = PlayerPedId()
    if taskInProcess then
        return 0
    end
    if coffeetimer > 0 then
        length = math.ceil(length * 0.66)
    end
    taskInProcess = true
    local taskIdentifier = "taskid" .. math.random(1000000)
    openGui(length,taskIdentifier,name,keepWeapon)
    activeTasks[taskIdentifier] = 1

    local maxcount = GetGameTimer() + length
    local curTime
    while activeTasks[taskIdentifier] == 1 do
        Citizen.Wait(1)
        curTime = GetGameTimer()
        if curTime > maxcount or not guiEnabled then
            activeTasks[taskIdentifier] = 2
        end
        local fuck = 100 - (((maxcount - curTime) / length) * 100)
        fuck = math.min(100, fuck)
        updateGui(fuck,taskIdentifier,name)

        if runCheck then
            if IsPedClimbing(PlayerPedId()) or IsPedJumping(PlayerPedId()) or IsPedSwimming(PlayerPedId()) then
                SetPlayerControl(PlayerId(), 0, 0)
                local totaldone = math.ceil(100 - (((maxcount - curTime) / length) * 100))
                totaldone = math.min(100, totaldone)
                taskInProcess = false
                closeGuiFail()
                Citizen.Wait(1000)
                SetPlayerControl(PlayerId(), 1, 1)
                Citizen.Wait(1000)
                return totaldone
            end
        end

        if vehicle ~= nil and vehicle ~= 0 then
            local driverPed = GetPedInVehicleSeat(vehicle, -1)
            if driverPed ~= playerPed and vehCheck then
                SetPlayerControl(PlayerId(), 0, 0)
                local totaldone = math.ceil(100 - (((maxcount - curTime) / length) * 100))
                totaldone = math.min(100, totaldone)
                taskInProcess = false
                closeGuiFail()
                Citizen.Wait(1000)
                SetPlayerControl(PlayerId(), 1, 1)
                Citizen.Wait(1000)
                return totaldone
            end

            local model = GetEntityModel(playerVeh)
            if IsThisModelACar(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
                if IsEntityInAir(vehicle) then
                    Wait(1000)
                    if IsEntityInAir(vehicle) then
                        local totaldone = math.ceil(100 - (((maxcount - curTime) / length) * 100))
                        totaldone = math.min(100, totaldone)
                        taskInProcess = false
                        closeGuiFail()
                        Citizen.Wait(1000)
                        return totaldone
                    end
                end
            end
        end
    end

    local resultTask = activeTasks[taskIdentifier]
    if resultTask == 2 then
        local totaldone = math.ceil(100 - (((maxcount - curTime) / length) * 100))
        totaldone = math.min(100, totaldone)
        taskInProcess = false
        closeGuiFail()
        return totaldone
    else
        closeGui()
        taskInProcess = false
        return 100
    end 
   
end

function CheckCancels()
    if IsPedRagdoll(PlayerPedId()) then
        return true
    end
    return false
end
-- trigger this way for the timer with out stopping another thread
RegisterNetEvent('hud:taskBar')
AddEventHandler('hud:taskBar', function(length,name)
    taskBar(length,name)
end)

RegisterNetEvent('hud:insidePrompt')
AddEventHandler('hud:insidePrompt', function(bool)
    insidePrompt = bool
end)


RegisterNetEvent('event:control:taskBar')
AddEventHandler('event:control:taskBar', function(useID)
    if useID == 1 and not insidePrompt then
        TriggerEvent("radioGui")
    elseif useID == 2 and not insidePrompt then
        TriggerEvent("stereoGui") 
    -- elseif useID == 3 and not insidePrompt then
    --     TriggerEvent("phoneGui") 
    elseif useID == 4 and not insidePrompt then 
        TriggerEvent("inventory-open-request")
    elseif useID == 5 and guiEnabled then 
        closeGuiFail() 
    end
end)

local function hasPhone()
  return exports["ucrp-inventory"]:hasEnoughOfItem("mobilephone", 1, false, true) or
      exports["ucrp-inventory"]:hasEnoughOfItem("stoleniphone", 1, false, true) or
      exports["ucrp-inventory"]:hasEnoughOfItem("stolens8", 1, false, true) or
      exports["ucrp-inventory"]:hasEnoughOfItem("stolennokia", 1, false, true) or
      exports["ucrp-inventory"]:hasEnoughOfItem("stolenpixel3", 1, false, true) or
      exports["ucrp-inventory"]:hasEnoughOfItem("boomerphone", 1, false, true)
end

local function canUsePhone()
  return not isDead
      and not exports["isPed"]:isPed("disabled")
      and not exports["isPed"]:isPed("handcuffed")
end

local function hasVPN()
  return exports["ucrp-inventory"]:hasEnoughOfItem("vpnxj", 1, false, true)
end

function LoadAnimationDic(dict)
  if not HasAnimDictLoaded(dict) then
      RequestAnimDict(dict)

      while not HasAnimDictLoaded(dict) do
          Citizen.Wait(0)
      end
  end
end

function generalInventory()
  if not insidePrompt and not inventoryDisabled then
    TriggerEvent("inventory-open-request")
  end
end


function handheld() 
    if not insidePrompt then
      TriggerEvent("radioGui")
    end
  end
  
  function generalPhone()
    if not insidePrompt and hasPhone() and canUsePhone() then
      LoadAnimationDic("cellphone@")
      TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
      TriggerEvent("attachItemPhone", "phone01")
      -- local hasRaceUsbAndAlias = exports["srp-racing"]:getHasRaceUsbAndAlias()
  
      -- exports["novel-ui"]:openApplication("phone", {
      --   has_emergency_job = hasEmergencyJob(),
      --   has_vpn = hasVPN(),
      --   has_usb_fleeca = exports["sup-inventory"]:hasEnoughOfItem("heistusb4", 1, false, true),
      --   has_usb_paleto = exports["sup-inventory"]:hasEnoughOfItem("heistusb1", 1, false, true),
      --   has_usb_upper = exports["sup-inventory"]:hasEnoughOfItem("heistusb2", 1, false, true),
      --   has_usb_lower = exports["sup-inventory"]:hasEnoughOfItem("heistusb3", 1, false, true),
      --   has_usb_racing_create = hasRaceUsbAndAlias.has_usb_racing_create,
      --   has_usb_racing = hasRaceUsbAndAlias.has_usb_racing,
      --   has_usb_pd_racing = hasRaceUsbAndAlias.has_usb_pd_racing,
      --   racing_alias = hasRaceUsbAndAlias.racingAlias,
      --   identifiers = myIdentifiers
      -- })
      TriggerEvent("phoneGui2")
    end
  end
  function generalInventory()
    if not insidePrompt and not inventoryDisabled and not forceInventoryDisabled then
      TriggerEvent("inventory-open-request")
    end
  end

function generalEscapeMenu()
  if guiEnabled then
    closeGuiFail()
  end
end

Citizen.CreateThread(function()
  exports["ucrp-keybinds"]:registerKeyMapping("", "Radio", "Open", "+handheld", "-handheld", "I")
  RegisterCommand('+handheld', handheld, false)
  RegisterCommand('-handheld', function() end, false)
  
  exports["ucrp-keybinds"]:registerKeyMapping("", "Phone", "Open", "+generalPhone", "-generalPhone", "P")
  RegisterCommand('+generalPhone', generalPhone, false)
  RegisterCommand('-generalPhone', function() end, false)
  
  exports["ucrp-keybinds"]:registerKeyMapping("", "Inventory", "Open", "+generalInventory", "-generalInventory", "K")
  RegisterCommand('+generalInventory', generalInventory, false)
  RegisterCommand('-generalInventory', function() end, false)
  
  exports["ucrp-keybinds"]:registerKeyMapping("", "Player", "Escape menu", "+generalEscapeMenu", "-generalEscapeMenu", "ESCAPE")
  RegisterCommand('+generalEscapeMenu', generalEscapeMenu, false)
  RegisterCommand('-generalEscapeMenu', function() end, false)
  
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
  if not isDead then
      isDead = true
  else
      isDead = false
  end
end)

exports("taskbarDisableInventory", function(pState)
  inventoryDisabled = pState
end)
