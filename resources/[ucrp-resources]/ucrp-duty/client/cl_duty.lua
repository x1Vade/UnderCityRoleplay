-- Police Duty --

local PDService = false

RegisterNetEvent('ucrp-duty:PoliceMenu')
AddEventHandler('ucrp-duty:PoliceMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDuty"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDuty"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDuty')
AddEventHandler('ucrp-duty:OnDuty', function()
	if PDService == false then
		TriggerServerEvent('ucrp-duty:AttemptDuty')
		TriggerEvent('np_clothing:inService', true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDuty')
AddEventHandler('ucrp-duty:OffDuty', function()
	if PDService == true then
		PDService = false
		TriggerEvent('np_clothing:inService', false)
		exports['ucrp-voice']:removePlayerFromRadio()
		exports["ucrp-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('ucrp-duty:OffDutyComplete')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:PDSuccess')
AddEventHandler('ucrp-duty:PDSuccess', function()
	if PDService == false then
		exports["ucrp-voice"]:setVoiceProperty("radioEnabled", true)
		exports['ucrp-voice']:addPlayerToRadio(1)
		TriggerEvent('radio:SetRadioStatus', true)
		PDService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		--TriggerEvent("armory:ammo")
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- EMS Duty --

local EMSService = false

RegisterNetEvent('ucrp-duty:EMSMenu')
AddEventHandler('ucrp-duty:EMSMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDutyEMS"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDutyEMS"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDutyEMS')
AddEventHandler('ucrp-duty:OnDutyEMS', function()
	if EMSService == false then
		TriggerServerEvent('ucrp-duty:AttemptDutyEMS')
		TriggerEvent('ucrp-clothing:inService', true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDutyEMS')
AddEventHandler('ucrp-duty:OffDutyEMS', function()
	if EMSService == true then
		EMSService = false
		TriggerEvent('ucrp-clothing:inService', false)
		exports['ucrp-voice']:removePlayerFromRadio()
		exports["ucrp-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('ucrp-duty:OffDutyCompleteEMS')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:EMSSuccess')
AddEventHandler('ucrp-duty:EMSSuccess', function()
	if EMSService == false then
		exports["ucrp-voice"]:setVoiceProperty("radioEnabled", true)
		exports['ucrp-voice']:addPlayerToRadio(2)
		TriggerEvent('radio:SetRadioStatus', true)
		EMSService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Suits Duty ----------------------------------------------------------------

local SuitsService = false

RegisterNetEvent('ucrp-duty:SuitsMenu')
AddEventHandler('ucrp-duty:SuitsMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDutySuits"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDutySuits"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDutySuits')
AddEventHandler('ucrp-duty:OnDutySuits', function()
	if SuitsService == false then
		TriggerServerEvent('ucrp-duty:AttemptDutySuits')
		TriggerEvent('ucrp-clothing:inService', true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDutySuits')
AddEventHandler('ucrp-duty:OffDutySuits', function()
	if SuitsService == true then
		SuitsService = false
		TriggerEvent('ucrp-clothing:inService', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('ucrp-duty:OffDutyCompleteSuits')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:SuitsSuccess')
AddEventHandler('ucrp-duty:SuitsSuccess', function()
	if SuitsService == false then
		SuitsService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Judge Duty ------------------------------------------------------------

local JudgeService = false

RegisterNetEvent('ucrp-duty:JudgeMenu')
AddEventHandler('ucrp-duty:JudgeMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDutyJudge"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDutyJudge"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDutyJudge')
AddEventHandler('ucrp-duty:OnDutyJudge', function()
	if JudgeService == false then
		TriggerServerEvent('ucrp-duty:AttemptDutyJudge')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDutyJudge')
AddEventHandler('ucrp-duty:OffDutyJudge', function()
	if JudgeService == true then
		JudgeService = false
		TriggerServerEvent('ucrp-duty:OffDutyCompleteEMS')
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:JudgeSuccess')
AddEventHandler('ucrp-duty:JudgeSuccess', function()
	if JudgeService == false then
		JudgeService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- DA Duty --

local DAService = false

RegisterNetEvent('ucrp-duty:DAMenu')
AddEventHandler('ucrp-duty:DAMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDutyDA"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDutyDA"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDutyDA')
AddEventHandler('ucrp-duty:OnDutyDA', function()
	if DAService == false then
		TriggerServerEvent('ucrp-duty:AttemptDutyDA')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDutyDA')
AddEventHandler('ucrp-duty:OffDutyDA', function()
	if DAService == true then
		DAService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:DASuccess')
AddEventHandler('ucrp-duty:DASuccess', function()
	if DAService == false then
		DAService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Public Duty --

local PublicService = false

RegisterNetEvent('ucrp-duty:PublicMenu')
AddEventHandler('ucrp-duty:PublicMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDutyPublic"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDutyPublic"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDutyPublic')
AddEventHandler('ucrp-duty:OnDutyPublic', function()
	if PublicService == false then
		TriggerServerEvent('ucrp-duty:AttemptDutyPublic')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDutyPublic')
AddEventHandler('ucrp-duty:OffDutyPublic', function()
	if PublicService == true then
		PublicService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:PublicSuccess')
AddEventHandler('ucrp-duty:PublicSuccess', function()
	if PublicService == false then
		PublicService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- ADA Duty --

local ADAService = false

RegisterNetEvent('ucrp-duty:ADAMenu')
AddEventHandler('ucrp-duty:ADAMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDutyADA"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDutyADA"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDutyADA')
AddEventHandler('ucrp-duty:OnDutyADA', function()
	if PublicService == false then
		TriggerServerEvent('ucrp-duty:AttemptDutyADA')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDutyADA')
AddEventHandler('ucrp-duty:OffDutyADA', function()
	if ADAService == true then
		ADAService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:ADASuccess')
AddEventHandler('ucrp-duty:ADASuccess', function()
	if ADAService == false then
		ADAService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- PDM Duty --

local PDMService = false

RegisterNetEvent('ucrp-duty:PDMMenu')
AddEventHandler('ucrp-duty:PDMMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDutyPDM"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDutyPDM"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDutyPDM')
AddEventHandler('ucrp-duty:OnDutyPDM', function()
	if PDMService == false then
		TriggerServerEvent('ucrp-duty:AttemptDutyPDM')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDutyPDM')
AddEventHandler('ucrp-duty:OffDutyPDM', function()
	if PDMService == true then
		PDMService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:PDMSuccess')
AddEventHandler('ucrp-duty:PDMSuccess', function()
	if PDMService == false then
		PDMService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Sanders Duty --

local SandersService = false

RegisterNetEvent('ucrp-duty:SandersMenu')
AddEventHandler('ucrp-duty:SandersMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDutySanders"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDutySanders"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDutySanders')
AddEventHandler('ucrp-duty:OnDutySanders', function()
	if SandersService == false then
		TriggerServerEvent('ucrp-duty:AttemptDutySanders')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDutySanders')
AddEventHandler('ucrp-duty:OffDutySanders', function()
	if SandersService == true then
		SandersService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:SandersSuccess')
AddEventHandler('ucrp-duty:SandersSuccess', function()
	if SandersService == false then
		SandersService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Sanders Duty --

local TowService = false

RegisterNetEvent('ucrp-duty:TowMenu')
AddEventHandler('ucrp-duty:TowMenu', function()
	TriggerEvent('ucrp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "ucrp-duty:OnDutyTow"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "ucrp-duty:OffDutyTow"
            }
        },
    })
end)

RegisterNetEvent('ucrp-duty:OnDutyTow')
AddEventHandler('ucrp-duty:OnDutyTow', function()
	if TowService == false then
		TriggerServerEvent('ucrp-duty:AttemptDutyTow')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:OffDutyTow')
AddEventHandler('ucrp-duty:OffDutyTow', function()
	if TowService == true then
		TowService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('ucrp-duty:TowSuccess')
AddEventHandler('ucrp-duty:TowSuccess', function()
	if TowService == false then
		TowService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterCommand('pdduty', function()
	TriggerEvent('ucrp-duty:OnDuty')
end)
RegisterCommand('pdduty2', function()
	TriggerEvent('ucrp-duty:OffDuty')
end)