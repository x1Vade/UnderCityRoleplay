---- STATUS -------

-- function hunger() 
--     -- local x 
--     -- TriggerEvent('esx_status:getStatus', 'hunger', function(hunger) 
--     --     x = hunger
--     -- end) 
--     return 50
-- end

-- function thirst() 
--     -- local y 
--     -- TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
--     --     y =  thirst 
--     -- end) 
--     return 50 
-- end

-- function stress() 
--     return 0 --exports['yp-stress']:stress() 
-- end

-- function nitrous()
--     return 0
-- end

------ COMMANDS -----

RegisterCommand("hud", function(source, args) 
    OpenMenu() 
end)

RegisterCommand("hud1", function(source, args, raw) 
    enhancements(args[1], args[2]) 
end)

RegisterCommand("dev", function(source, args, raw) 
    enhancements("dev") 
end)

RegisterCommand("debug", function(source, args, raw) 
    enhancements("debug") 
end)

--- VOICE TRIGGER --

RegisterNetEvent("oe-hud:voice")
AddEventHandler("oe-hud:voice", function(talk, mod) 
    if mod == "Whisper" then sesduzey = 1 elseif mod == "Normal" then sesduzey = 2 elseif mod == "Shouting" then sesduzey = 3 end 

    SendNUIMessage({
        action = "voice",
        radio = radio,
        voice = sesduzey,
        talking = talk
    })
end)
