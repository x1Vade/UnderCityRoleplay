RegisterServerEvent('CarryPeople:sync')
AddEventHandler('CarryPeople:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('CarryPeople:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('CarryPeople:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)

    -- exports["ucrp-log"]:AddLog("Civ Jobs", 
    --     source, 
    --     "Carry Player", 
    --     { targetPlayer = GetPlayerName(target) })
end)

RegisterServerEvent('CarryPeople:stop')
AddEventHandler('CarryPeople:stop', function(targetSrc)
	TriggerClientEvent('CarryPeople:cl_stop', targetSrc)

    -- exports["ucrp-log"]:AddLog("Civ Jobs", 
    --     source, 
    --     "Stop Carry Player", 
    --     { targetPlayer = GetPlayerName(targetSrc) })
    -- Why would you log the carry?
    -- Wanna kill the SQL? its slow enough.
end)
