function openInventory(type, id)
  if type == "stash" then
    local success = RPC.execute("ucrp-business:hasStashAccess", id)
    if success then
      TriggerEvent("server-inventory-open", "1", "biz-" .. id)
    else
      TriggerEvent("DoLongHudText", "Not allowed", 2)
    end
  elseif type == "craft" then
    local success = RPC.execute("ucrp-business:hasCraftAccess", id)
    if success then
      TriggerEvent("server-inventory-open", "42", "Craft")
    else
      TriggerEvent("DoLongHudText", "Not allowed", 2)
    end
  else
    TriggerEvent("DoLongHudText", "Nothing found", 2)
  end
end

local listening = false
local function listenForKeypress(type, id)
  listening = true
  Citizen.CreateThread(function()
      while listening do
          if IsControlJustReleased(0, 38) then
              listening = false
              exports["ucrp-ui"]:hideInteraction()
              openInventory(string.lower(type), id)
          end
          Wait(0)
      end
  end)
end

function enterPoly(name, data)
  listenForKeypress(name, data.id)
  exports["ucrp-ui"]:showInteraction("[E] " .. name)
end

function leavePoly(name, data)
  listening = false
  exports["ucrp-ui"]:hideInteraction()
end

AddEventHandler("ucrp-polyzone:enter", function(name, data)
  if name == "business_stash" or name == "business_craft" then
    enterPoly(name == "business_stash" and "Stash" or "Craft", data)
  end
end)

AddEventHandler("ucrp-polyzone:exit", function(name, data)
  if name == "business_stash" or name == "business_craft" then
    leavePoly(name == "business_stash" and "Stash" or "Craft", data)
  end
end)
