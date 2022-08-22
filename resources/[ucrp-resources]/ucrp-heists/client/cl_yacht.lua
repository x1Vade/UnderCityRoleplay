YACHT_HEIST_ACTIVE = false
YACHT_HEIST_SETTINGS = {}
local duiConfs = {}

function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(0)
  end
end

function getContextId(pContext)
  if (not pContext) or (not pContext.zones) or (not pContext.zones["heist_yacht_target"]) or (not pContext.zones["heist_yacht_target"].id) then
    return -1
  end
  return pContext.zones["heist_yacht_target"].id
end

-- processing envelope
local activeEnvelope = nil
RegisterUICallback("ucrp-ui:heists:submitYachtRangeValue", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  exports["ucrp-ui"]:closeApplication("range-picker")
  function compareRange(idx)
    return tonumber(data.ranges[idx]) == tonumber(activeEnvelope.gameValue[idx])
  end
  local success = (compareRange(1) and compareRange(2) and compareRange(3)) and true or false
  RPC.execute("ucrp-heists:yacht:submitTargetGameResult", success)
end)
RegisterUICallback("ucrp-ui:heists:submitYachtTextValue", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = "done" } })
  exports['ucrp-ui']:closeApplication('textbox')
  RPC.execute("ucrp-heists:yacht:submitTargetGameResult", data.values.code == activeEnvelope.gameValue[1])
end)
RegisterUICallback("ucrp-ui:heists:submitYachtLaptopTextValue", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = "done" } })
  exports['ucrp-ui']:closeApplication('textbox')
  if data.values.code == activeEnvelope.gameValue[1] then
    exports["ucrp-ui"]:openApplication("minigame-captcha", {
      gameFinishedEndpoint = "ucrp-ui:heists:submitYachtLaptopResultValue",
      gameDuration = 5000,
      gameRoundsTotal = 10,
      numberOfShapes = 5,
    })
    return
  end
end)
RegisterUICallback("ucrp-ui:heists:submitYachtLaptopResultValue", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = "done" } })
  RPC.execute("ucrp-heists:yacht:submitTargetGameResult", data.success)
  TriggerServerEvent("ucrp-heists:hack:track", data.success, "laptop")
end)

function processEnvelope(pEnvelope)
  activeEnvelope = pEnvelope
  if pEnvelope.gameType == "range" then
    exports["ucrp-ui"]:openApplication("range-picker", {
      submitUrl = "ucrp-ui:heists:submitYachtRangeValue",
    })
  end
  if pEnvelope.gameType == "textbox" then
    exports['ucrp-ui']:openApplication('textbox', {
      callbackUrl = 'ucrp-ui:heists:submitYachtTextValue',
      key = 1,
      items = {
        {
          icon = "user-secret",
          label = "Code",
          name = "code",
        },
      },
      show = true,
    })
  end
  if pEnvelope.gameType == "laptop" then
    exports['ucrp-ui']:openApplication('textbox', {
      callbackUrl = 'ucrp-ui:heists:submitYachtLaptopTextValue',
      key = 1,
      items = {
        {
          icon = "user-secret",
          label = "Code",
          name = "code",
        },
      },
      show = true,
    })
  end
end

AddEventHandler("ucrp-heists:yacht:targetEntry", function(p1, p2, pContext)
  local id = getContextId(pContext)
  if id == -1 then
    TriggerEvent("DoLongHudText", "Try again.", 2)
    return
  end
  if YACHT_STASH_NAMES[id] then
    ClearPedTasksImmediately(PlayerPedId())
    TriggerEvent("animation:runtextanim", "search")
    local finished = exports["ucrp-taskbar"]:taskBar(math.random(5000, 10000), "Searching...")
    ClearPedTasksImmediately(PlayerPedId())
    if finished ~= 100 then return end
    RPC.execute("ucrp-heists:yacht:searchStash", id)
    return
  end
  local isTarget, envelope = RPC.execute("ucrp-heists:yacht:isActiveTarget", id)
  if not isTarget then return end
  processEnvelope(envelope)
end)

AddEventHandler("ucrp-heists:yacht:loot", function(p1, p2, pContext)
  ClearPedTasksImmediately(PlayerPedId())
  TriggerEvent("animation:runtextanim", "search")
  local finished = exports["ucrp-taskbar"]:taskBar(math.random(5000, 10000), "Searching...")
  ClearPedTasksImmediately(PlayerPedId())
  if finished ~= 100 then return end
  local id = pContext.zones["heist_yacht_loot"].id
  if not id then return end
  RPC.execute("ucrp-heists:yacht:lootTarget", id)
end)

RegisterUICallback("ucrp-ui:yachtheist:openEnvelope", function(data, cb)
  local usedResult = RPC.execute("ucrp-heists:yacht:envelopeUsed", data)
  cb({ data = usedResult, meta = { ok = true, message = 'done' }})
end)

AddEventHandler("ucrp-inventory:itemUsed", function(pItem, pInfo)
  if pItem ~= "heistmicroenvelope" then return end
  local info = json.decode(pInfo)
  exports["ucrp-ui"]:openApplication("yacht-envelope", info)
end)

AddEventHandler("ucrp-heists:yacht:startHeist", function()
  local hasItem = exports["ucrp-inventory"]:hasEnoughOfItem("heistpadyacht", 1, false, true)
  if not hasItem then return end
  loadAnimDict("amb@prop_human_atm@male@idle_a")
  ClearPedTasksImmediately(PlayerPedId())
  TaskPlayAnim(PlayerPedId(), "amb@prop_human_atm@male@idle_a", "idle_b", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
  local finished = exports["ucrp-taskbar"]:taskBar(3000, "Attaching PixelPad")
  ClearPedTasksImmediately(PlayerPedId())
  if finished ~= 100 then return end
  TriggerServerEvent("ucrp-heists:yacht:heistStart")
end)

RegisterNetEvent("ucrp-heists:yacht:updateGameDuiPanels")
AddEventHandler("ucrp-heists:yacht:updateGameDuiPanels", function(pType, pValue)
  if #(GetEntityCoords(PlayerPedId()) - vector3(-2055.93, -1027.5, 2.59)) > 100 then return end
  Citizen.CreateThread(function()
    local timeoutEnabled = false
    local duiOptions = {
      {
        endLetter = "S",
        endLetterW = "D",
        letter = "O",
        tx = "1",
      },
      {
        endLetter = "H",
        endLetterW = "O",
        letter = "V",
        tx = "2",
      },
      {
        endLetter = "U",
        endLetterW = "O",
        letter = "E",
        tx = "3",
      },
      {
        endLetter = "T",
        endLetterW = "R",
        letter = "R",
        tx = "4",
      },
      {
        endLetter = "D",
        endLetterW = "O",
        letter = "R",
        tx = "5",
      },
      {
        endLetter = "O",
        endLetterW = "P",
        letter = "I",
        tx = "6",
      },
      {
        endLetter = "W",
        endLetterW = "E",
        letter = "D",
        tx = "7",
      },
      {
        endLetter = "N",
        endLetterW = "N",
        letter = "E",
        tx = "8",
      },
    }
    for _, conf in pairs(duiConfs) do
      RemoveReplaceTexture(conf.txd, conf.tex)
      exports["ucrp-lib"]:releaseDui(conf.dui.id)
      conf.dui = nil
    end
    if pType == "override" then
      local url = "https://prod-gta.nopixel.net/dui/?type=text&fontSize=10em&text="
      local confs = {}
      for _, opt in pairs(duiOptions) do
        local conf = {
          tex = "Yacht_Screen_0" .. opt.tx,
          txd = "hei_mph_yachteng_servers",
          dui = nil,
        }
        local cUrl = url .. opt.letter
        conf.dui = exports["ucrp-lib"]:getDui(cUrl, 256, 256)
        AddReplaceTexture(conf.txd, conf.tex, conf.dui.dictionary, conf.dui.texture)
        confs[#confs + 1] = conf
      end
      duiConfs = confs
    end
    if pType == "fail" then
      local url = "https://prod-gta.nopixel.net/dui/?type=text&fontSize=10em&text="
      local confs = {}
      for _, opt in pairs(duiOptions) do
        local conf = {
          tex = "Yacht_Screen_0" .. opt.tx,
          txd = "hei_mph_yachteng_servers",
          dui = nil,
        }
        local cUrl = url .. opt.endLetter
        conf.dui = exports["ucrp-lib"]:getDui(cUrl, 256, 256)
        AddReplaceTexture(conf.txd, conf.tex, conf.dui.dictionary, conf.dui.texture)
        confs[#confs + 1] = conf
      end
      duiConfs = confs
      timeoutEnabled = true
    end
    if pType == "complete" then
      local url = "https://prod-gta.nopixel.net/dui/?type=text&fontSize=10em&text="
      local confs = {}
      for _, opt in pairs(duiOptions) do
        local conf = {
          tex = "Yacht_Screen_0" .. opt.tx,
          txd = "hei_mph_yachteng_servers",
          dui = nil,
        }
        local cUrl = url .. opt.endLetterW
        conf.dui = exports["ucrp-lib"]:getDui(cUrl, 256, 256)
        AddReplaceTexture(conf.txd, conf.tex, conf.dui.dictionary, conf.dui.texture)
        confs[#confs + 1] = conf
      end
      duiConfs = confs
      timeoutEnabled = true
    end
    if pType == "countdown" then
      local url = "https://prod-gta.nopixel.net/dui/?type=countdown&fontSize=5em&seconds="
      local confs = {}
      for _, opt in pairs(duiOptions) do
        local conf = {
          tex = "Yacht_Screen_0" .. opt.tx,
          txd = "hei_mph_yachteng_servers",
          dui = nil,
        }
        local cUrl = url .. tostring(pValue)
        conf.dui = exports["ucrp-lib"]:getDui(cUrl, 256, 256)
        AddReplaceTexture(conf.txd, conf.tex, conf.dui.dictionary, conf.dui.texture)
        confs[#confs + 1] = conf
      end
      duiConfs = confs
    end
    if pType == "clues" then
      local url = "https://prod-gta.nopixel.net/dui/?type=yacht-clue"
      local confs = {}
      for _, opt in pairs(duiOptions) do
        local settings = nil
        for _, v in pairs(YACHT_HEIST_SETTINGS) do
          if tostring(v.matrixIndex) == opt.tx then
            settings = v
          end
        end
        local conf = {
          tex = "Yacht_Screen_0" .. opt.tx,
          txd = "hei_mph_yachteng_servers",
          dui = nil,
        }
        local cUrl = url .. "&clueIcon=" .. settings.clueIcon
          .. "&arrowUp=" .. settings.matrixUp
          .. "&arrowRight=" .. settings.matrixRight
          .. "&arrowDown=" .. settings.matrixDown
          .. "&arrowLeft=" .. settings.matrixLeft
        conf.dui = exports["ucrp-lib"]:getDui(cUrl, 256, 256)
        AddReplaceTexture(conf.txd, conf.tex, conf.dui.dictionary, conf.dui.texture)
        confs[#confs + 1] = conf
      end
      duiConfs = confs
    end
    if timeoutEnabled then
      Citizen.Wait(60000)
      for _, conf in pairs(duiConfs) do
        RemoveReplaceTexture(conf.txd, conf.tex)
        exports["ucrp-lib"]:releaseDui(conf.dui.id)
        conf.dui = nil
      end
    end
  end)
end)

-- RegisterCommand("rmdui", function()
--   for _, conf in pairs(duiConfs) do
--     RemoveReplaceTexture(conf.txd, conf.tex)
--     exports["ucrp-lib"]:releaseDui(conf.dui.id)
--     conf.dui = nil
--   end
-- end)

--
Citizen.CreateThread(function()
  YACHT_HEIST_ACTIVE, YACHT_HEIST_SETTINGS = RPC.execute("ucrp-heists:yacht:isHeistActive")
end)
RegisterNetEvent("ucrp-heists:yacht:setHeistActive")
AddEventHandler("ucrp-heists:yacht:setHeistActive", function(pActive, pSettings)
  YACHT_HEIST_ACTIVE = pActive
  YACHT_HEIST_SETTINGS = pSettings
  -- Citizen.CreateThread(function()
  --   for k, v in pairs(YACHT_STASH_NAMES) do
  --     RPC.execute("ucrp-heists:yacht:searchStash", k)
  --     Citizen.Wait(50)
  --   end
  -- end)
end)
