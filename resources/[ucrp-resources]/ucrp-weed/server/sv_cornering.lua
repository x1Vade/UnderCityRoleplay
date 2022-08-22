RPC.register("ucrp-weed:startCorner", function(pSource, pCoords)
    print("Coords", pCoords)
    return true, "Corner Active"
end)

RPC.register("ucrp-weed:cornerPed", function(pSource, pCoords, pPed, pVehicle)
    TriggerClientEvent("ucrp-weed:cornerPed", pSource, pPed, pCoords, pVehicle)
    return true
end)

RPC.register("ucrp-weed:cornerSyncHandoff", function(pSource, pCoords, pPed)
    TriggerClientEvent("ucrp-weed:cornerSyncHandoff", pSource, pPed)
    return true
end)

RPC.register("ucrp-weed:cornerSale", function(pSource, pCoords, pNetId, CurrentCornerZone, baggieInfo)
    print("cornerSale", json.encode(pCoords), pNetId, CurrentCornerZone, json.encode(baggieInfo))
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(pSource)

    TriggerClientEvent("inventory:removeItem", -1, "weedbaggie", 1)

    exports["ucrp-log"]:AddLog("Weed", 
        source, "Corner Sale", { type = "weedbaggie", amount = tostring(1)})
    return true
end)

RPC.register("ucrp-weed:prepareBaggies", function(pSource, pInfo)
    TriggerClientEvent("inventory:removeItem", -1, "emptybaggies", CornerConfig.BaggiesPerBrick)
    exports["ucrp-log"]:AddLog("Weed", 
        source, "Corner Sale", { type = "emptybaggies", amount = tostring(1)})
    return true
end)

RPC.register("ucrp-weed:stopCorner", function(pSource)
    return false
end)