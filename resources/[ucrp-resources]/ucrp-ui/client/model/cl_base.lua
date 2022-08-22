-- CLOSE APP
function SetUIFocus(hasKeyboard, hasMouse)
    --  HasNuiFocus = hasKeyboard or hasMouse
    
      SetNuiFocus(hasKeyboard, hasMouse)
    
      -- TriggerEvent("ucrp-voice:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
      -- TriggerEvent("ucrp-binds:should-execute", not HasNuiFocus)
    end
    
    exports('SetUIFocus', SetUIFocus)
    
    RegisterNUICallback("ucrp-ui:closeApp", function(data, cb)
        SetUIFocus(false, false)
        cb({data = {}, meta = {ok = true, message = 'done'}})
        Wait(800)
        TriggerEvent("attachedItems:block",false)
    end)
    
    RegisterNUICallback("ucrp-ui:applicationClosed", function(data, cb)
        TriggerEvent("ucrp-ui:application-closed", data.name, data)
        cb({data = {}, meta = {ok = true, message = 'done'}})
    end)
    
    -- FORCE CLOSE
    RegisterCommand("ucrp-ui:force-close", function()
        SendUIMessage({source = "ucrp-nui", app = "", show = false});
        SetUIFocus(false, false)
    end, false)
    
    -- SMALL MAP
    RegisterCommand("ucrp-ui:small-map", function()
      SetRadarBigmapEnabled(false, false)
    end, false)
    
    local function restartUI(withMsg)
      SendUIMessage({ source = "ucrp-nui", app = "main", action = "restart" });
      if withMsg then
        TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
      end
      Wait(5000)
      TriggerEvent("ucrp-ui:restarted")
      SendUIMessage({ app = "hud", data = { display = true }, source = "ucrp-nui" })
      local cj = exports["police"]:getCurrentJob()
      if cj ~= "unemployed" then
        TriggerEvent("ucrp-jobmanager:playerBecameJob", cj)
        TriggerServerEvent("ucrp-jobmanager:fixPaychecks", cj)
      end
      loadPublicData()
    end
    RegisterCommand("ucrp-ui:restart", function() restartUI(true) end, false)
    RegisterCommand("ui-r", function() restartUI() end, false)
    RegisterNetEvent("ucrp-ui:server-restart")
    AddEventHandler("ucrp-ui:server-restart", restartUI)
    
    RegisterCommand("ucrp-ui:debug:show", function()
        SendUIMessage({ source = "ucrp-nui", app = "debuglogs", data = { display = true } });
    end, false)
    
    RegisterCommand("ucrp-ui:debug:hide", function()
        SendUIMessage({ source = "ucrp-nui", app = "debuglogs", data = { display = false } });
    end, false)
    
    RegisterNUICallback("ucrp-ui:resetApp", function(data, cb)
        SetUIFocus(false, false)
        cb({data = {}, meta = {ok = true, message = 'done'}})
        sendCharacterData()
    end)
    
    RegisterNetEvent("ucrp-ui:server-relay")
    AddEventHandler("ucrp-ui:server-relay", function(data)
        SendUIMessage(data)
    end)
    
    RegisterNetEvent("isJudge")
    AddEventHandler("isJudge", function()
      sendAppEvent("character", { job = "judge" })
    end)
    
    RegisterNetEvent("isJudgeOff")
    AddEventHandler("isJudgeOff", function()
      sendAppEvent("character", { job = "unemployed" })
    end)
    
    RegisterNetEvent("ucrp-jobmanager:playerBecameJob")
    AddEventHandler("ucrp-jobmanager:playerBecameJob", function(job)
      sendAppEvent("character", { job = job })
    end)
    