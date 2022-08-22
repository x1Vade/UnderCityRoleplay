Citizen.CreateThread(function()
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-625.78, -238.71, 38.06), 2.2, 1, {
    heading=305,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.46,
    data = {
      id = "1",
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-626.55, -234.64, 38.06), 2.2, 0.6, {
    heading=306,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.46,
    data = {
      id = "2",
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-627.18, -233.87, 38.06), 2.2, 0.6, {
    heading=306,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.46,
    data = {
      id = 3,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-619.33, -234.53, 38.06), 2.2, 0.6, {
    heading=306,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.46,
    data = {
      id = 4,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-617.42, -229.71, 38.06), 2.2, 0.6, {
    heading=216,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.46,
    data = {
      id = 5,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-619.54, -226.82, 38.06), 2.2, 0.6, {
    heading=216,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.46,
    data = {
      id = 6,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-624.72, -227.0, 38.06), 2.2, 0.6, {
    heading=126,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.46,
    data = {
      id = 7,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-620.47, -232.97, 38.06), 1.4, 0.6, {
    heading=126,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.66,
    data = {
      id = 8,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-620.11, -230.74, 38.06), 1.4, 0.6, {
    heading=36,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.66,
    data = {
      id = 9,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-621.47, -229.05, 38.06), 1.4, 0.6, {
    heading=36,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.66,
    data = {
      id = 10,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-623.62, -228.63, 38.06), 1.4, 0.6, {
    heading=306,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.66,
    data = {
      id = 11,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-624.04, -230.82, 38.06), 1.4, 0.6, {
    heading=216,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.66,
    data = {
      id = 12,
    },
  })
  exports["ucrp-polytarget"]:AddBoxZone("jewelry_rob_spot", vector3(-622.53, -232.86, 38.06), 1.4, 0.6, {
    heading=216,
    -- debugPoly=true,
    minZ=37.66,
    maxZ=38.66,
    data = {
      id = 13,
    },
  })
  exports['ucrp-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot", {{
    event = "dark-jewelry:jewelry:SmashFunctions",
    id = "jewelry:SmashFunctions",
    icon = "circle",
    label = "Smash!",
    parameters = {"1"},
  }}, { distance = { radius = 2.0 } })
end)