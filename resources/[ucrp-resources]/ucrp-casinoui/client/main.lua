RegisterNetEvent('ucrp-casinouiShowUI')
AddEventHandler('ucrp-casinouiShowUI', function(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end)

RegisterNetEvent('ucrp-casinouiHideUI')
AddEventHandler('ucrp-casinouiHideUI', function()
	SendNUIMessage({
		action = 'hide'
	})
end)

function DrawCasinoUi(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end

function HideCasinoUi()
	SendNUIMessage({
		action = 'hide'
	})
end

RegisterCommand('test', function()
	exports['ucrp-casinoui']:DrawCasinoUi('show', "Diamond Casino Blackjack</p>Balance: $5000Test</br>Bet: 10000Test") 
    Wait(3700)
	exports['ucrp-casinoui']:HideCasinoUi('hide') 
end, false)


