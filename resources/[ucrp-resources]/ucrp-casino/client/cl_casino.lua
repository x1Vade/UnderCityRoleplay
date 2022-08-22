local inCasino = false
local postGateTriggered = false
local carOnShow = `r35`
local carOnShowAppearence = json.decode('{"colors":{"primary":64,"secondary":0,"pearlescent":70,"wheels":0,"tyre":{"r":255,"g":255,"b":255},"neon":{"r":255,"g":0,"b":255},"xenon":12,"dashboard":0,"interior":0},"tint":3,"neon":{"left":false,"right":false,"front":false,"back":false},"extras":[1],"wheelType":0,"oldLivery":0,"plateIndex":0}')
local carOnShowMods = json.decode('{"Spoilers":2,"FrontBumper":6,"RearBumper":6,"SideSkirt":-1,"Exhaust":-1,"Frame":0,"Grille":-1,"Hood":0,"Fender":-1,"RightFender":-1,"Roof":-1,"Engine":-1,"Brakes":-1,"Transmission":-1,"Horns":-1,"Suspension":3,"Armor":-1,"UNK17":false,"Turbo":false,"UNK19":false,"TireSmoke":false,"UNK21":false,"XenonHeadlights":1,"FrontWheels":56,"BackWheels":-1,"PlateHolder":-1,"VanityPlates":-1,"InteriorTrim":-1,"Ornaments":-1,"Dashboard":-1,"Dials":-1,"DoorSpeakers":-1,"Seats":-1,"SteeringWheel":-1,"ShiftLeavers":-1,"Plaques":-1,"Speakers":-1,"Trunk":-1,"Hydraulics":-1,"EngineBlock":-1,"AirFilter":-1,"Struts":-1,"ArchCover":-1,"Aerials":-1,"ExteriorTrim":-1,"Tank":-1,"Windows":-1,"UNK47":-1,"Livery":-1}')
local carOnShow2 = `r1`
local carOnShow2Active = false
local polyEntryTimeout = false
local enterFirstTime = true
local entranceTeleportCoords = vector3(1089.73, 206.36, -48.99 + 0.05)
local exitTeleportCoords = vector3(934.46, 45.83, 81.1 + 0.05)
local inVRHeadset = false

local spinningObject = nil
local spinningCar = nil
local auxCar = nil

local duiList = {}
local wheelDui = nil
local tvDui = nil
--local tvUri = "https://i.imgur.com/cQ3KSpI.png"
--local tvUri = "https://i.imgur.com/FA1zej7.gif" 
local tvUri = "https://prod-gta.nopixel.net/dui/?type=video&src=https://i.imgur.com/AW6eFot.mp4&encoding=mp4"
--[[ local wheelUrl = "https://prod-gta.nopixel.net/casinowheel/?socketUrl=wss%3A%2F%2Fprod-gta.nopixel.net%2Fapi" ]]

Citizen.CreateThread(function()
  -- local isPublic = exports['novel-config']:IsPublic()
  -- if not isPublic then return end
  wheelUrl = "https://prod-gta.nopixel.net/casinowheel/?socketUrl=wss%3A%2F%2Fprod-gta.nopixel.net%2Fapi"
end)


local _isRolling = false

-- CAR FOR WINS
function drawCarForWins()
  if DoesEntityExist(spinningCar) then
    DeleteEntity(spinningCar)
  end
  if DoesEntityExist(auxCar) then
    DeleteEntity(auxCar)
  end
  RequestModel(carOnShow)
	while not HasModelLoaded(carOnShow) do
		Citizen.Wait(0)
  end
  RequestModel(carOnShow2)
	while not HasModelLoaded(carOnShow2) do
		Citizen.Wait(0)
  end
  SetModelAsNoLongerNeeded(carOnShow)
  if carOnShow2Active then
    SetModelAsNoLongerNeeded(carOnShow2)
  end
  spinningCar = CreateVehicle(carOnShow, 975.5, 40.41, 72.16 + 0.05, 0.0, 0, 0)
  Wait(0)
  if carOnShow2Active then
    auxCar = CreateVehicle(carOnShow2, 1007.23, 46.5, 70.47 + 0.05, 197.13, 0, 0)
  end
  if carOnShowAppearence then
    --exports['ucrp-vehicles']:SetVehicleAppearance(spinningCar, carOnShowAppearence)
  end
  if carOnShowMods then
    --exports['ucrp-vehicles']:SetVehicleMods(spinningCar, carOnShowMods)
  end
  SetVehicleDirtLevel(spinningCar, 0.0)
  SetVehicleOnGroundProperly(spinningCar)
  SetVehicleNumberPlateText(spinningCar, "SPIN2WIN")
  if carOnShow2Active then
    SetVehicleDirtLevel(auxCar, 0.0)
    SetVehicleOnGroundProperly(auxCar)
    SetVehicleNumberPlateText(auxCar, "SPIN2WIN")
    SetVehicleDoorsLocked(auxCar, 2)
    SetVehicleUndriveable(auxCar, true)
  end
  Wait(0)
  FreezeEntityPosition(spinningCar, 1)
  if carOnShow2Active then
    FreezeEntityPosition(auxCar, 1)
  end
end
-- END CAR FOR WINS

AddEventHandler("ucrp-casino:elevatorEnterCasino", function()
  enterCasino(true)
end)
AddEventHandler("ucrp-casino:elevatorExitCasino", function()
  enterCasino(false)
end)

AddEventHandler("ucrp-polyzone:enter", function(zone)
  if zone == "casino_entrance" then
    print("enter")
    enterCasino(true)
  elseif zone == "casino_exit" then
    print("enter")
    enterCasino(false)
  end
end)

function enterCasino(pIsInCasino)
  if pIsInCasino == inCasino then return end
  inCasino = pIsInCasino
  if DoesEntityExist(spinningCar) then
    DeleteEntity(spinningCar)
  end
  local function doInitStuff()
    spinMeRightRoundBaby()
    showDiamondsOnScreenBaby()
    playSomeBackgroundAudioBaby()
    doSomeTextureReplacesBruv(true)
    showThe6StrImage(true)
    TriggerServerEvent('som-casino:blackjack:getBalance')
    -- doWeaponBlock()
    -- stopRunningInMyCasino()
    -- doRaffleTickets()
  end
  -- if not pFromElevator then
  --   DoScreenFadeOut(500)
  --   Wait(500)
  --   NetworkFadeOutEntity(PlayerPedId(), true, true)
  --   Wait(300)
  --   SetPedCoordsKeepVehicle(PlayerPedId(), pCoords)
  --   SetEntityHeading(PlayerPedId(), pHeading)
  --   Citizen.CreateThread(function()
  --     -- if enterFirstTime and inCasino then
  --     --   enterFirstTime = false
  --     --   Citizen.Wait(500)
  --     --   SetPedCoordsKeepVehicle(PlayerPedId(), exitTeleportCoords)
  --     --   Citizen.Wait(500)
  --     --   SetPedCoordsKeepVehicle(PlayerPedId(), entranceTeleportCoords)
  --     -- end
  --     if inCasino then
  --       local pedCoords = RPC.execute("ucrp-casino:getSpawnedPedCoords", true)
  --       handlePedCoordsBaby(pedCoords)
  --       Citizen.Wait(250)
  --     else
  --       Citizen.Wait(800)
  --     end
  --     ClearPedTasksImmediately(PlayerPedId())
  --     SetGameplayCamRelativeHeading(0.0)
  --     NetworkFadeInEntity(PlayerPedId(), true)
  --     if inCasino then
  --       doInitStuff()
  --     end
  --     Citizen.Wait(500)
  --     DoScreenFadeIn(500)
  --   end)
  -- end
  if not inCasino then
    doSomeTextureReplacesBruv(false)
    showThe6StrImage(false)
    --RPC.execute("ucrp-casino:getSpawnedPedCoords", false)
    TriggerEvent("ucrp-casino:casinoExitedEvent")
    TriggerServerEvent('ucrp-infinity:scopes:casino', false)
    postGateTriggered = false
    return
  end
  -- local pedCoords = RPC.execute("ucrp-casino:getSpawnedPedCoords", true)
  -- handlePedCoordsBaby(pedCoords)
  doInitStuff()
  TriggerEvent("ucrp-casino:casinoEnteredEvent")
  TriggerServerEvent('ucrp-infinity:scopes:casino', true)
end

Citizen.CreateThread(function()
  --enterCasino(true)
  Wait(10000)

 -- RPC.execute("ucrp-casino:getCurrentInteriorSetName")
end)

local casinoRaffleThreadActive = false
function doRaffleTickets()
  if casinoRaffleThreadActive then return end
  casinoRaffleThreadActive = true
  Citizen.CreateThread(function()
    while inCasino do
      Citizen.Wait(5 * 60000)
      if inCasino and postGateTriggered then
        if hasMembership() then
          --RPC.execute("ucrp-casino:generateRaffleTicket")
        end
      end
    end
    casinoRaffleThreadActive = false
  end)
end

--First one is big screen, 2-17 are the small betting screens
--currently setup to use the 1st link for everything
--also: doing this many duis likes to crash a lot
local linkList = {
  [1] = 'https://prod-gta.nopixel.net/casinowall/',
  -- [2] = 'https://i.imgur.com/0S2zo4z.png',
  -- [3] = "https://i.imgur.com/0S2zo4z.png",
  -- [4] = "https://i.imgur.com/0S2zo4z.png",
  -- [5] = "https://i.imgur.com/0S2zo4z.png",
  -- [6] = "https://i.imgur.com/0S2zo4z.png",
  -- [7] = "https://i.imgur.com/0S2zo4z.png",
  -- [8] = "https://i.imgur.com/0S2zo4z.png",
  -- [9] = "https://i.imgur.com/0S2zo4z.png",
  -- [10] = "https://i.imgur.com/0S2zo4z.png",
  -- [11] = "https://i.imgur.com/0S2zo4z.png",
  -- [12] = "https://i.imgur.com/0S2zo4z.png",
  -- [13] = "https://i.imgur.com/0S2zo4z.png",
  -- [14] = "https://i.imgur.com/0S2zo4z.png",
  -- [15] = "https://i.imgur.com/0S2zo4z.png",
  -- [16] = "https://i.imgur.com/0S2zo4z.png",
  -- [17] = "https://i.imgur.com/0S2zo4z.png"
}

function doDuiStuffMate()
  for idx,link in ipairs(linkList) do
    if not duiList[idx] then
      local resolution = (idx == 1 and {2048, 1024} or {1280, 800})
      duiList[idx] = CreateDui(link, resolution[1], resolution[2])
    -- else
    --   SetDuiUrl(duiList[idx], link)
      local dui = GetDuiHandle(duiList[idx])
      local txd = CreateRuntimeTxd('duiTxdBetScreen_' .. idx)
      local txd2 = CreateRuntimeTextureFromDuiHandle(txd, 'duiTexBetScreen_' .. idx, dui)
    end
  end
  AddReplaceTexture('vw_vwint01_betting_screen', 'script_rt_casinoscreen_02', 'duiTxdBetScreen_1', 'duiTexBetScreen_1')
  -- for i=1,16 do
  --   local txd = tostring(i)
  --   local txn = tostring(i + 2)
  --   if i < 10 then 
  --     txd = "0" .. tostring(i) 
  --   end
  --   if i < 8 then
  --     txn = "0" .. tostring(i + 2)
  --   end
  --   --AddReplaceTexture('vw_vwint01_betting_sreen_' .. txd, 'script_rt_casinoscreen_' .. txn, 'duiTxdBetScreen_' .. tostring(i + 1), 'duiTexBetScreen_' .. tostring(i + 1))
  --   --AddReplaceTexture('vw_vwint01_betting_sreen_' .. txd, 'script_rt_casinoscreen_' .. txn, 'duiTxdBetScreen_1', 'duiTexBetScreen_1')
  -- end
end

function doSomeTextureReplacesBruv(apply)
  if not apply then
    RemoveReplaceTexture('vw_prop_vw_luckywheel_01a', 'script_rt_casinowheel')
    exports["ucrp-lib"]:releaseDui(wheelDui.id)
    wheelDui = nil
    return
  end
  if wheelDui == nil then
    wheelDui = exports["ucrp-lib"]:getDui(wheelUrl, 1024, 1024)
    AddReplaceTexture('vw_prop_vw_luckywheel_01a', 'script_rt_casinowheel', wheelDui.dictionary, wheelDui.texture)
    local retval = GetEntityRotation(wheelUrl, 1)
    print("ROT",retval)
  else
    exports["ucrp-lib"]:changeDuiUrl(wheelDui.id, wheelUrl)
    local retval2 = GetEntityRotation(wheelUrl, 1)
    print("ROT2",retval2)
  end
end

function showThe6StrImage(apply)
  if not apply then
    RemoveReplaceTexture('vw_prop_vw_cinema_tv_01', 'script_rt_tvscreen')
    exports["ucrp-lib"]:releaseDui(tvDui.id)
    tvDui = nil
    return
  end
  if tvDui == nil then
    tvDui = exports["ucrp-lib"]:getDui(tvUri, 512, 256)
    AddReplaceTexture('vw_prop_vw_cinema_tv_01', 'script_rt_tvscreen', tvDui.dictionary, tvDui.texture)
  else
    exports["ucrp-lib"]:changeDuiUrl(tvDui.id, tvUri)
  end
end

function doWeaponBlock()
  Citizen.CreateThread(function()
    while inCasino do
      Citizen.Wait(1500)
      if IsPedArmed(PlayerPedId(), 7) then
        SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
      end
    end
  end)
end

function stopRunningInMyCasino()
  Citizen.CreateThread(function()
    while inCasino do
      DisableControlAction(0, 21, true) -- disable sprint
      Citizen.Wait(0)
    end
  end)
end

function spinMeRightRoundBaby()
  Citizen.CreateThread(function()
    while inCasino do
      if not spinningObject or spinningObject == 0 or not DoesEntityExist(spinningObject) then
        spinningObject = GetClosestObjectOfType(974.22, 39.76, 72.16, 10.0, -1561087446, 0, 0, 0)
        drawCarForWins()
      end
      if spinningObject ~= nil and spinningObject ~= 0 then
        local curHeading = GetEntityHeading(spinningObject)
        local curHeadingCar = GetEntityHeading(spinningCar)
        if curHeading >= 360 then
          curHeading = 0.0
          curHeadingCar = 0.0
        elseif curHeading ~= curHeadingCar then
          curHeadingCar = curHeading
        end
        SetEntityHeading(spinningObject, curHeading + 0.075)
        SetEntityHeading(spinningCar, curHeadingCar + 0.075)
      end
      Wait(0)
    end
    spinningObject = nil
  end)
end

-- Casino Screens
local Playlists = {
  "CASINO_DIA_PL", -- diamonds
  "CASINO_SNWFLK_PL", -- snowflakes
  "CASINO_WIN_PL", -- win
  "CASINO_HLW_PL", -- skull
}
-- Render
function CreateNamedRenderTargetForModel(name, model)
  local handle = 0
  if not IsNamedRendertargetRegistered(name) then
    RegisterNamedRendertarget(name, 0)
  end
  if not IsNamedRendertargetLinked(model) then
    LinkNamedRendertarget(model)
  end
  if IsNamedRendertargetRegistered(name) then
    handle = GetNamedRendertargetRenderId(name)
  end
  return handle
end
-- render tv stuff
function showDiamondsOnScreenBaby()
  Citizen.CreateThread(function()
    local propNames = {"vw_vwint01_video_overlay", "gbz_casino_video_overlay"}
    for _, propName in pairs(propNames) do
      Citizen.CreateThread(function()
        local model = GetHashKey(propName)
        local timeout = 21085 -- 5000 / 255
        local casinoScreenStr = propName == "vw_vwint01_video_overlay" and "CasinoScreen_01" or "CasinoScreen_02"
        local handle = CreateNamedRenderTargetForModel(casinoScreenStr, model)
        --print(model, propName, casinoScreenStr, handle)
        RegisterScriptWithAudio(0)
        SetTvChannel(-1)
        SetTvVolume(0)
        SetScriptGfxDrawOrder(4)
        SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
        SetTvChannel(2)
        EnableMovieSubtitles(1)

        function doAlpha()
          Citizen.SetTimeout(timeout, function()
            SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
            SetTvChannel(2)
            if inCasino then
              doAlpha()
            end
          end)
        end
        doAlpha()

        Citizen.CreateThread(function()
          while inCasino do
            SetTextRenderId(handle)
            DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            Citizen.Wait(0)
          end
          SetTvChannel(-1)
          ReleaseNamedRendertarget(GetHashKey(casinoScreenStr))
          SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        end)
      end)
    end
  end)
end

function showDiamondsOnInsideTrackScreenBaby()
  Citizen.CreateThread(function()
    local model = GetHashKey("vw_vwint01_betting_screen")
    local timeout = 21085 -- 5000 / 255

    local handle = CreateNamedRenderTargetForModel("CasinoScreen_02", model)

    RegisterScriptWithAudio(0)
    SetTvChannel(-1)
    SetTvVolume(0)
    SetScriptGfxDrawOrder(4)
    SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
    SetTvChannel(2)
    EnableMovieSubtitles(1)

    function doAlpha()
      Citizen.SetTimeout(timeout, function()
        SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
        SetTvChannel(2)
        if inCasino then
          doAlpha()
        end
      end)
    end
    doAlpha()

    Citizen.CreateThread(function()
      while inCasino do
        SetTextRenderId(handle)
        DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        Citizen.Wait(0)
      end
      SetTvChannel(-1)
      ReleaseNamedRendertarget(GetHashKey("CasinoScreen_02"))
      SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    end)
  end)
end

function playSomeBackgroundAudioBaby()
  Citizen.CreateThread(function()
    local function audioBanks()
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", false, -1) do
        Citizen.Wait(0)
      end
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", false, -1) do
        Citizen.Wait(0)
      end
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", false, -1) do
        Citizen.Wait(0)
      end
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", false, -1) do
        Citizen.Wait(0)
      end
      -- while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_INTERIOR_STEMS", false, -1) do
      --   print('load 5')
      --   Wait(0)
      -- end
    end
    audioBanks()
    while inCasino do
      if inVRHeadset and IsStreamPlaying() then
        StopStream()
      end
      if inVRHeadset and IsAudioSceneActive("DLC_VW_Casino_General") then
        StopAudioScene("DLC_VW_Casino_General")
      end
      if not inVRHeadset and not IsStreamPlaying() and LoadStream("casino_walla", "DLC_VW_Casino_Interior_Sounds") then
        PlayStreamFromPosition(996.13,38.48,71.07)
      end
      if not inVRHeadset and IsStreamPlaying() and not IsAudioSceneActive("DLC_VW_Casino_General") then
        StartAudioScene("DLC_VW_Casino_General")
      end
      Citizen.Wait(1000)
    end
    if IsStreamPlaying() then
      StopStream()
    end
    if IsAudioSceneActive("DLC_VW_Casino_General") then
      StopAudioScene("DLC_VW_Casino_General")
    end
  end)
end

local myPeds = {}
function handlePedCoordsBaby(pPedCoords)
  if not pPedCoords or not inCasino then return end
  for _, pedData in pairs(pPedCoords) do
    RequestModel(pedData.model)
    while not HasModelLoaded(pedData.model) do
      Wait(0)
    end
    SetModelAsNoLongerNeeded(pedData.model)
    local ped = CreatePed(pedData._pedType, pedData.model, pedData.coords, pedData.heading, 1, 1)
    while not DoesEntityExist(ped) do
      Wait(0)
    end
    SetPedRandomComponentVariation(ped, 0)
    local pedNetId = 0
    while NetworkGetNetworkIdFromEntity(ped) == 0 do
      Wait(0)
    end
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    pedNetId = NetworkGetNetworkIdFromEntity(ped)
    SetNetworkIdCanMigrate(ped, true)
    myPeds[#myPeds + 1] = { entity = ped, scenario = pedData.scenario, netId = pedNetId }
    Wait(0)
  end
 -- RPC.execute("ucrp-casino:handoffPedData", myPeds)
  Citizen.CreateThread(function()
    while inCasino do
      for _, ped in pairs(myPeds) do
        if IsPedDeadOrDying(ped.entity, 1) then
          DeleteEntity(ped.entity)
        elseif math.random() < 0.002 then
          TaskWanderStandard(ped.entity)
        elseif not IsPedActiveInScenario(ped.entity) then
          ClearPedTasks(ped.entity)
          TaskStartScenarioInPlace(ped.entity, ped.scenario, 0, 1)
        end
      end
      Wait(15000)
    end
  end)
  -- debug
  -- Citizen.CreateThread(function()
  --   while inCasino do
  --     for _, ped in pairs(myPeds) do
  --       if #(GetEntityCoords(ped.entity) - GetEntityCoords(PlayerPedId())) < 1.2 then
  --         print(ped.entity, ped.scenario)
  --       end
  --     end
  --     Wait(1000)
  --   end
  -- end)
end

AddEventHandler("ucrp-casino:purchaseDrinks", function(data)
  if hasMembership() then
    TriggerEvent("server-inventory-open", "46", "Shop")
  else
    TriggerEvent("DoLongHudText", "Members Only", 2)
  end
end)

function hasMembership(hrOnly)
  if not exports['ucrp-inventory']:hasEnoughOfItem("casinomember", 1, false, true) and not exports['ucrp-inventory']:hasEnoughOfItem("casinovip", 1, false, true) then
    return false
  else
    return true
  end
end

exports('hasMembership', hasMembership)

AddEventHandler("ucrp-casino:inVRHeadset", function(pInVRHeadset)
  inVRHeadset = pInVRHeadset
end)

--[[ RegisterNetEvent("ucrp-casino:do:spinwheel")
AddEventHandler("ucrp-casino:do:spinwheel", function()
  TriggerServerEvent("ucrp-casino:wheel:spinWheel", pSource)
end) ]]

RegisterCommand("wheel", function()
  TriggerEvent("ucrp-casino:casino:spinwheel:roll")
end)

RegisterNetEvent("ucrp-casino:casino:spinwheel:roll")
AddEventHandler("ucrp-casino:casino:spinwheel:roll", function(_priceIndex) 
    _isRolling = true
    -- exports["ucrp-lib"]:changeDuiUrl(wheelDui.id, wheelUrl)
    -- SetEntityHeading(wheelUrl, -30.0)
    -- SetEntityRotation(wheelUrl, 0.0, 0.0, 0.0, 1, true)
    Citizen.CreateThread(function()
        local speedIntCnt = 1
        local rollspeed = 1.0
        local _priceIndex = math.random(1, 20)
        local _winAngle = (_priceIndex - 1) * 18
        local _rollAngle = _winAngle + (360 * 8)
        local _midLength = (_rollAngle / 2)
        local intCnt = 0
        while speedIntCnt > 0 do
            local retval = GetEntityRotation(wheelUrl.id, 1)
            if _rollAngle > _midLength then
                speedIntCnt = speedIntCnt + 1
            else
                speedIntCnt = speedIntCnt - 1
                if speedIntCnt < 0 then
                    speedIntCnt = 0
                    
                end
            end
            intCnt = intCnt + 1
            rollspeed = speedIntCnt / 10
            local _y = retval.y - rollspeed
            _rollAngle = _rollAngle - rollspeed
             if _rollAngle < 5.0 then
                 if _y > _winAngle then
                     _y = _winAngle
                 end
             end
             print(_y)
            SetEntityRotation(wheelUrl.id, 0.0, _y, 0.0, 1, true)
            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent("ucrp-luckywheel:rollFinished")
AddEventHandler("ucrp-luckywheel:rollFinished", function() 
    _isRolling = false
end)

-- Havocx's Shit

-- chips
-- purchase, transfer, cashout
RegisterNetEvent("ucrp-casino:purchaseChipsAction")
AddEventHandler("ucrp-casino:purchaseChipsAction", function(pArgs)
  local action = pArgs[1]
  if exports['ucrp-inventory']:hasEnoughOfItem("casinomember", 1) then
    if action == "purchase" then
      Wait(100)
      local purchase = exports["ucrp-input"]:showInput({
        {
            icon = "dollar-sign",
            label = "Purchase Amount",
            name = "amount",
        },
      })

      if purchase["amount"] then
        TriggerEvent("player:receiveItem", "redchip", purchase["amount"])
        TriggerServerEvent("ucrp-casino:purchaseChipsAction", purchase["amount"] * 10)
      end
    elseif action == "withdraw:cash" then
      local chipsAmount = exports["ucrp-inventory"]:getQuantity("redchip")
      TriggerServerEvent("ucrp-casino:withdraw","cash",chipsAmount)
    elseif action == "withdraw:bank" then
      local chipsAmount = exports["ucrp-inventory"]:getQuantity("redchip")
      TriggerServerEvent("ucrp-casino:withdraw","bank",chipsAmount)
    elseif action == "transfer" then
      Wait(100)
      local transfer = exports["ucrp-input"]:showInput({
        {
            icon = "user",
            label = "State ID",
            name = "state_id",
        },
        {
            icon = "dollar-sign",
            label = "Amount",
            name = "amount",
        },
      })

      if transfer["state_id"] and transfer["amount"] then
        if exports["ucrp-inventory"]:hasEnoughOfItem("redchip",1,false) then
          TriggerEvent("inventory:removeItem", "redchip", transfer["amount"])
          TriggerServerEvent("ucrp-casino:transferChips", transfer["state_id"])
        else
          TriggerEvent("DoLongHudText", "You dont have any chips to transfer!", 2)
        end
      end
    end
  else
    TriggerEvent("DoLongHudText", "Members Only", 2)
    return
  end
end)


-- MemberShip Giver

RegisterNetEvent("ucrp-casino:membercard:get", function()
  TriggerEvent("player:receiveItem", "membercard")
end)

RegisterNetEvent("ucrp-casino:purchaseMembershipCard")
AddEventHandler("ucrp-casino:purchaseMembershipCard", function()
  hasMembership = false
  TriggerServerEvent("ucrp-casino:purchase:MembershipCard")
  if not hasMembership then
    TriggerEvent("DoLongHudText", "Not Enough Money In The Bank!", 2)
  else
    TriggerEvent("player:receiveItem", "membercard")
  end
end)

-- have these three check job, if casino then open input and allow them to give anyone access to get these cards

RegisterNetEvent("ucrp-casino:purchaseMembership")
AddEventHandler("ucrp-casino:purchaseMembership", function()
  TriggerEvent("DoLongHudText", "Please talk to a member of floor staff", 2)
end)

AddEventHandler("ucrp-casino:getLoyaltyCard", function()
  local characterId = exports["isPed"]:isPed("cid")
  local jobAccess = RPC.execute("IsEmployedAtBusiness", { character = { id = characterId }, business = { id = "casino"} })
  if not jobAccess then
    TriggerEvent("DoLongHudText", "Please talk to a member of floor staff", 2)
    return
  end
  TriggerEvent("player:receiveItem", "casinoloyalty", 1, false, { state_id = characterId }, { state_id = characterId })
end)

AddEventHandler("ucrp-casino:getHotelVIPCard", function()
  local characterId = exports["isPed"]:isPed("cid")
  local jobAccess = RPC.execute("IsEmployedAtBusiness", { character = { id = characterId }, business = { id = "casino"} })
  if not jobAccess then
    TriggerEvent("DoLongHudText", "Please talk to a member of floor staff", 2)
    return
  end
  TriggerEvent("player:receiveItem", "casinovip", 1, false, { state_id = characterId }, { state_id = characterId })
end)

AddEventHandler("ucrp-casino:getHotelVIPCard", function()
  local characterId = exports["isPed"]:isPed("cid")
  local jobAccess = RPC.execute("IsEmployedAtBusiness", { character = { id = characterId }, business = { id = "casino"} })
  if not jobAccess then
    TriggerEvent("DoLongHudText", "Please talk to a member of floor staff", 2)
    return
  end
  TriggerEvent("player:receiveItem", "casinovip", 1, false, { state_id = characterId }, { state_id = characterId })
end)
