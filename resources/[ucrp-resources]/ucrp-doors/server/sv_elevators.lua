RPC.register("ucrp-doors:elevators:fetch",function()
    return ELEVATOR_CONFIG
end)

RegisterServerEvent("ucrp-doors:change-elevator-state")
AddEventHandler("ucrp-doors:change-elevator-state",function(elevatorId, floorId, locked)
    if ELEVATOR_CONFIG[elevatorId] then
        doors[pDoorId].locked = locked
        TriggerClientEvent("ucrp-doors:elevators:updateState", -1, elevatorId,floorId,locked,doors[pDoorId].forceUnlocked)
    end
end)