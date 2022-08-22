Citizen.CreateThread(function()
    for id, zone in ipairs(HiveZones) do
        exports["ucrp-polyzone"]:AddCircleZone("ucrp-beekeeping:bee_zone", zone[1], zone[2],{
            zoneEvents={"ucrp-beekeeping:trigger_zone"},
            data = {
                id = id,
            },
        })
    end
end)