RegisterNetEvent("ucrp-jobsystem:PoliceJobMenu")
AddEventHandler("ucrp-jobsystem:PoliceJobMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedPD", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:PoliceJobMenu2")
AddEventHandler("ucrp-jobsystem:PoliceJobMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedPD", valid[1].input)
    end
end)

-- DOJ------------------------------------------------------------------------------------------------------------------
--Judge-----------------------------------

RegisterNetEvent("ucrp-jobsystem:JudgeJobMenuHire")
AddEventHandler("ucrp-jobsystem:JudgeJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedJudge", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:JudgeJobMenuFire")
AddEventHandler("ucrp-jobsystem:JudgeJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedJudge", valid[1].input)
    end
end)
--DA------------------------------------

RegisterNetEvent("ucrp-jobsystem:DAJobMenuHire")
AddEventHandler("ucrp-jobsystem:DAJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedDA", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:DAJobMenuFire")
AddEventHandler("ucrp-jobsystem:DAJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedDA", valid[1].input)
    end
end)

--ADA---------------------------------------

RegisterNetEvent("ucrp-jobsystem:ADAJobMenuHire")
AddEventHandler("ucrp-jobsystem:ADAJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedADA", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:ADAJobMenuFire")
AddEventHandler("ucrp-jobsystem:ADAJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedADA", valid[1].input)
    end
end)

--Defender-------------------------------------------

RegisterNetEvent("ucrp-jobsystem:DefenderJobMenuHire")
AddEventHandler("ucrp-jobsystem:DefenderJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedDefender", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:DefenderJobMenuFire")
AddEventHandler("ucrp-jobsystem:DefenderJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedDefender", valid[1].input)
    end
end)

-- Tow Hire / Fire ----------------------------------------------------------------------------------------------------
RegisterNetEvent("ucrp-jobsystem:TowJobMenuHire")
AddEventHandler("ucrp-jobsystem:TowJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedTow", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:TowJobMenuFire")
AddEventHandler("ucrp-jobsystem:TowJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedTow", valid[1].input)
    end
end)

-- Heat Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:heatJobMenuHire")
AddEventHandler("ucrp-jobsystem:heatJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassHeat", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:heatJobMenuFire")
AddEventHandler("ucrp-jobsystem:heatJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassHeat", valid[1].input)
    end
end)

-- Bondi Boys Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:bondiJobMenuHire")
AddEventHandler("ucrp-jobsystem:bondiJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassBondi", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:bondiJobMenuFire")
AddEventHandler("ucrp-jobsystem:bondiJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassBondi", valid[1].input)
    end
end)

-- Casino Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:casinoJobMenuHire")
AddEventHandler("ucrp-jobsystem:casinoJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassCasino", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:casinoJobMenuFire")
AddEventHandler("ucrp-jobsystem:casinoJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassCasino", valid[1].input)
    end
end)


-- Real Estate Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:reJobMenuHire")
AddEventHandler("ucrp-jobsystem:reJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassRe", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:reJobMenuFire")
AddEventHandler("ucrp-jobsystem:reJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassRe", valid[1].input)
    end
end)

-- Rockford Records Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:rrJobMenuHire")
AddEventHandler("ucrp-jobsystem:rrJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassrr", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:rrJobMenuFire")
AddEventHandler("ucrp-jobsystem:rrJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassrr", valid[1].input)
    end
end)


-- Yakuza Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:yakuzaJobMenuHire")
AddEventHandler("ucrp-jobsystem:yakuzaJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassYakuza", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:yakuzaJobMenuFire")
AddEventHandler("ucrp-jobsystem:yakuzaJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassYakuza", valid[1].input)
    end
end)

-- Winery Job Menu --------------------------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:WineryJobMenuHire")
AddEventHandler("ucrp-jobsystem:WineryJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassWinery", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:WineryJobMenuFire")
AddEventHandler("ucrp-jobsystem:WineryJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassWinery", valid[1].input)
    end
end)

--- EMS --------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:EMSJobMenu")
AddEventHandler("ucrp-jobsystem:EMSJobMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedEMS", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:EMSJobMenu2")
AddEventHandler("ucrp-jobsystem:EMSJobMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedEMS", valid[1].input)
    end
end)

----AK customs Hire / Fire --------------------------

RegisterNetEvent("ucrp-jobsystem:AkJobMenuHire")
AddEventHandler("ucrp-jobsystem:AkJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassAk_customs", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:AkJobMenuFire")
AddEventHandler("ucrp-jobsystem:AkJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassAk_customs", valid[1].input)
    end
end)

---- Radical Hire / Fire --------------------------

RegisterNetEvent("ucrp-jobsystem:RadicalJobMenuHire")
AddEventHandler("ucrp-jobsystem:RadicalJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassRadical", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:RadicalJobMenuFire")
AddEventHandler("ucrp-jobsystem:RadicalJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassRadical", valid[1].input)
    end
end)

----AOD Hire / Fire --------------------------

RegisterNetEvent("ucrp-jobsystem:AodJobMenuHire")
AddEventHandler("ucrp-jobsystem:AodJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassAod", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:AodJobMenuFire")
AddEventHandler("ucrp-jobsystem:AodJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassAod", valid[1].input)
    end
end)
---- Pearls customs Hire / Fire ----------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:PearlsJobMenuHire")
AddEventHandler("ucrp-jobsystem:PearlsJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassPearls", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:PearlsJobMenuFire")
AddEventHandler("ucrp-jobsystem:PearlsJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassPearls", valid[1].input)
    end
end)

----VU Hire / Fire --------------------------

RegisterNetEvent("ucrp-jobsystem:VUJobMenuHire")
AddEventHandler("ucrp-jobsystem:VUJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassVU", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:VUJobMenuFire")
AddEventHandler("ucrp-jobsystem:VUJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassVU", valid[1].input)
    end
end)

--PDM -------------------------------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:PDMJobMenu")
AddEventHandler("ucrp-jobsystem:PDMJobMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedPDM", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:PDMJobMenu2")
AddEventHandler("ucrp-jobsystem:PDMJobMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedPDM", valid[1].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:NoodleJobMenu")
AddEventHandler("ucrp-jobsystem:NoodleJobMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedNoodle", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:NoodleJobMenu2")
AddEventHandler("ucrp-jobsystem:NoodleJobMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedNoodle", valid[1].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:BSJobMenuHire")
AddEventHandler("ucrp-jobsystem:BSJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassBS", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:BSJobMenuFire")
AddEventHandler("ucrp-jobsystem:BSJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassBS", valid[1].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:SandersJobMenu")
AddEventHandler("ucrp-jobsystem:SandersJobMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedSanders", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:SandersJobMenu2")
AddEventHandler("ucrp-jobsystem:SandersJobMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedSanders", valid[1].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:TowJobMenu")
AddEventHandler("ucrp-jobsystem:TowJobMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedTow", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:TowJobMenu2")
AddEventHandler("ucrp-jobsystem:TowJobMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedTow", valid[1].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:releaseVehicle")
AddEventHandler("ucrp-jobsystem:releaseVehicle", function()
    local ped = PlayerPedId()
	local dist = #(GetEntityCoords(ped)-vector3(-193.37142944336,-1162.4571533203,23.668823242188))
	if dist <= 2.5 then 
        local valid = exports["ucrp-keyboard"]:KeyboardInput({
            header = "Release Vehicle Menu",
            rows = {
                {
                    id = 0,
                    txt = "Plate Number"
                },
            }
        })
        if valid then
            TriggerServerEvent("ucrp-jobsystem:releaseVehicle", valid[1].input)
        end
    else
        exports['ucrp-notification']:Alert({style = 'error', duration = 3000, message = 'You need to be at the front desk at the tow union to release the vehicle!'})
    end
end)

RegisterNetEvent("ucrp-jobsystem:WeedMenu")
AddEventHandler("ucrp-jobsystem:WeedMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedWeed", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:WeedMenu2")
AddEventHandler("ucrp-jobsystem:WeedMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedWeed", valid[1].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:GalMenu")
AddEventHandler("ucrp-jobsystem:GalMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedGal", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:GalMenu2")
AddEventHandler("ucrp-jobsystem:GalMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedGal", valid[1].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:LostMenu")
AddEventHandler("ucrp-jobsystem:LostMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedLost", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:LostMenu2")
AddEventHandler("ucrp-jobsystem:LostMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedLost", valid[1].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:RedMenu")
AddEventHandler("ucrp-jobsystem:RedMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedRed", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:RedMenu2")
AddEventHandler("ucrp-jobsystem:RedMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedRed", valid[1].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:UGMenu")
AddEventHandler("ucrp-jobsystem:UGMenu", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addJobWhitelsitedUG", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:UGMenu2")
AddEventHandler("ucrp-jobsystem:UGMenu2", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:fireJobWhitelsitedUG", valid[1].input)
    end
end)

-- Suits Job Menu --------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:suitsJobMenuHire")
AddEventHandler("ucrp-jobsystem:suitsJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassSuits", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("ucrp-jobsystem:suitsJobMenuFire")
AddEventHandler("ucrp-jobsystem:suitsJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassSuits", valid[1].input)
    end
end)

-- UG Casino Job Menu --------------------------------------------------------------------------------------

RegisterNetEvent("ucrp-jobsystem:ugCasinoJobMenuHire")
AddEventHandler("ucrp-jobsystem:ugCasinoJobMenuHire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:addCharacterPassUgCasino", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("ucrp-jobsystem:ugCasinoJobMenuFire")
AddEventHandler("ucrp-jobsystem:ugCasinoJobMenuFire", function()
    local valid = exports["ucrp-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("ucrp-jobsystem:removeCharacterPassUgCasino", valid[1].input)
    end
end)