RegisterServerEvent('carwash:checkmoney')
AddEventHandler('carwash:checkmoney', function()
	local src = source
	local player = exports["ucrp-base"]:getModule("Player"):GetUser(src)
	local costs = 70

	if player:getCash() >= costs then --- MintHavoc Change Banking
		TriggerClientEvent("carwash:success", src, costs)
		player:removeMoney(costs)--- MintHavoc Change Banking
	else
		moneyleft = costs - player:getCash()
		TriggerClientEvent('carwash:notenoughmoney', src, moneyleft)
	end
end)