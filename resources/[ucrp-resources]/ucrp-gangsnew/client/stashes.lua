StashSpot = false
StashName = nil

Citizen.CreateThread(function()
    for k,v in pairs(Config["Gangs"]) do
        exports["ucrp-polyzone"]:AddBoxZone(k.."-stash", Config["Gangs"][k].stash_coords, 1.15, 2, {
            name = k.."-stash",
            heading = 30,
            minZ = Config["Gangs"][k].stash_coords - 1,
            maxZ = Config["Gangs"][k].stash_coords + 1
        }) 
    end
end)


RegisterNetEvent('ucrp-polyzone:enter')
AddEventHandler('ucrp-polyzone:enter', function(name)
    local MyGang = RPC.execute("unwind-gangs:server:getgang")
    if MyGang ~= nil then
        local GangName = MyGang.gang
        if name == "mandem-stash" and GangName == "mandem" then
            StashName = "Gang"
            StashSpot = true
            exports["ucrp-ui"]:showInteraction("[E] Stash")
            OpenStash(name)
        elseif name == "sosa-stash" and GangName == "sosa" then
            StashName = "sosa"
            StashSpot = true
            exports["ucrp-ui"]:showInteraction("[E] Stash")
            OpenStash(name)
        elseif name == "gambinos-stash" and GangName == "gambinos" then
            StashName = "gambinos"
            StashSpot = true
            exports["ucrp-ui"]:showInteraction("[E] Stash")
            OpenStash(name)
        elseif name == "saigons-stash" and GangName == "saigons" then
            StashName = "saigons"
            StashSpot = true
            exports["ucrp-ui"]:showInteraction("[E] Stash")
            OpenStash(name)
        elseif name == "black_mafia-stash" and GangName == "black_mafia" then
            StashName = "black_mafia"
            StashSpot = true
            exports["ucrp-ui"]:showInteraction("[E] Stash")
            OpenStash(name)
        elseif name == "hoa-stash" and GangName == "hoa" then
            StashName = "hoa"
            StashSpot = true
            exports["ucrp-ui"]:showInteraction("[E] Stash")
            OpenStash(name)
        end
    end
end)


RegisterNetEvent('ucrp-polyzone:exit')
AddEventHandler('ucrp-polyzone:exit', function(name)
    if name == "cartel-stash" or name == "sosa-stash" or name == "black_mafia-stash" or name == "gambinos-stash" or name == "mandem-stash" or name =="saigons-stash" or name =="hoa-stash" then
        StashSpot = false
        StashName = nil
    end
   exports["ucrp-ui"]:hideInteraction()
end)


function OpenStash(stash)
    Citizen.CreateThread(function()
        while StashSpot do
            if StashSpot then
                Citizen.Wait(5)
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("server-inventory-open", "1", StashName)
                    exports["ucrp-ui"]:hideInteraction()
                    Citizen.Wait(500)
                end
            end
        end
    end)
end