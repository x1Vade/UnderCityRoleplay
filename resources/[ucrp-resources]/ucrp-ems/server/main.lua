RegisterServerEvent('admin:revivePlayer')
AddEventHandler('admin:revivePlayer', function(target)
	if target ~= nil then
		TriggerClientEvent('admin:revivePlayerClient', target)
		TriggerClientEvent('ucrp-hospital:client:RemoveBleed', target) 
        TriggerClientEvent('ucrp-hospital:client:ResetLimbs', target)
	end
end)

RegisterServerEvent('ucrp-ems:heal')
AddEventHandler('ucrp-ems:heal', function(target)
	TriggerClientEvent('ucrp-ems:heal', target) 	
end)

RegisterServerEvent('ucrp-ems:heal2')
AddEventHandler('ucrp-ems:heal2', function(target)
	TriggerClientEvent('ucrp-ems:big', target)
end)