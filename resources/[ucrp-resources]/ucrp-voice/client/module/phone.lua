---function createPhoneThread
---creates a phone thread to listen for key presses
local function createPhoneThread()
	Citizen.CreateThread(function()
		local changed = false
		while voiceData.call ~= 0 do
			-- check if they're pressing voice keybinds
			if NetworkIsPlayerTalking(PlayerId()) and not changed then
				changed = true
				TriggerServerEvent('ucrp-voice:setTalkingOnCall', true)
			elseif changed and NetworkIsPlayerTalking(PlayerId()) ~= 1 then
				changed = false
				TriggerServerEvent('ucrp-voice:setTalkingOnCall', false)
			end
			Wait(0)
		end
	end)
end

RegisterNetEvent('ucrp-voice:syncCallData')
AddEventHandler('ucrp-voice:syncCallData', function(callTable, channel)
	callData = callTable
	for tgt, enabled in pairs(callTable) do
		if tgt ~= playerServerId then
			toggleVoice(tgt, enabled, 'phone')
		end
	end
	playerTargets(radioData, callData)
end)

RegisterNetEvent('ucrp-voice:setTalkingOnCall')
AddEventHandler('ucrp-voice:setTalkingOnCall', function(tgt, enabled)
	if tgt ~= playerServerId then
		callData[tgt] = enabled
		playerTargets(radioData, callData)
		toggleVoice(tgt, enabled, 'phone')
	end
end)

RegisterNetEvent('ucrp-voice:addPlayerToCall')
AddEventHandler('ucrp-voice:addPlayerToCall', function(plySource)
	callData[plySource] = false
	playerTargets(radioData, callData)
end)

RegisterNetEvent('ucrp-voice:removePlayerFromCall')
AddEventHandler('ucrp-voice:removePlayerFromCall', function(plySource)
	if plySource == playerServerId then
		for tgt, enabled in pairs(callData) do
			if tgt ~= playerServerId then
				toggleVoice(tgt, false, 'phone')
			end
		end
		callData = {}
		playerTargets(radioData, callData)
	else
		callData[plySource] = nil
		toggleVoice(plySource, false, 'phone')
		playerTargets(radioData, callData)
	end
end)

function setCallChannel(channel)
	if GetConvarInt('voice_enablePhones', 1) ~= 1 then return end
	TriggerServerEvent('ucrp-voice:setPlayerCall', channel)
	voiceData.call = channel
	if GetConvarInt('voice_enableUi', 1) == 1 then
		SendNUIMessage({
			callInfo = channel
		})
	end
	createPhoneThread()
end

exports('setCallChannel', setCallChannel)
exports('addPlayerToCall', function(call)
	local call = tonumber(call)
	if call then
		setCallChannel(call)
	end
end)
exports('removePlayerFromCall', function()
	setCallChannel(0)
end)

RegisterNetEvent('ucrp-voice:clSetPlayerCall')
AddEventHandler('ucrp-voice:clSetPlayerCall', function(callChannel)
	if GetConvarInt('voice_enablePhones', 1) ~= 1 then return end
	voiceData.call = callChannel
	createPhoneThread()
end)
