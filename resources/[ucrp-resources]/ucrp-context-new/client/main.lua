
local headerShown = false
local sendData = nil

-- Functions
local function openMenu(data)
    SetNuiFocus(true, true)
    headerShown = false
    sendData = data
    SendNUIMessage({
        action = 'OPEN_MENU',
        data = table.clone(data)
    })
end

local function closeMenu()
    sendData = nil
    headerShown = false
    SetNuiFocus(false)
    SendNUIMessage({
        action = 'CLOSE_MENU'
    })
end

local function showHeader(data)
    if not data or not next(data) then return end
    headerShown = true
    sendData = data
    SendNUIMessage({
        action = 'SHOW_HEADER',
        data = table.clone(data)
    })
end

-- Events

RegisterNetEvent('ucrp-menu:client:openMenu', function(data)
    openMenu(data)
end)

RegisterNetEvent('ucrp-menu:client:closeMenu', function()
    closeMenu()
end)

-- NUI Callbacks

RegisterNUICallback('clickedButton', function(option, cb)
    if headerShown then headerShown = false end
    SetNuiFocus(false)
    if sendData then
        local data = sendData[tonumber(option)]
        sendData = nil
        if data then
            if data.params.event then
                if data.params.isServer then
                    TriggerServerEvent(data.params.event, data.params.args)
                elseif data.params.isCommand then
                    ExecuteCommand(data.params.event)
                elseif data.params.isucrpCommand then
                    TriggerServerEvent('ucrp:CallCommand', data.params.event, data.params.args)
                elseif data.params.isAction then
                    data.params.event(data.params.args)
                else
                    TriggerEvent(data.params.event, data.params.args)
                end
            end
        end
    end
    cb('ok')
end)

RegisterNUICallback('closeMenu', function(_, cb)
    headerShown = false
    sendData = nil
    SetNuiFocus(false)
    cb('ok')
end)

-- Command and Keymapping

-- RegisterCommand('playerfocus', function()
--     if headerShown then
--         SetNuiFocus(true, true)
--     end
-- end)

-- RegisterKeyMapping('playerFocus', 'Give Menu Focus', 'keyboard', 'LMENU')

-- Exports

exports('openMenu', openMenu)
exports('closeMenu', closeMenu)
exports('showHeader', showHeader)

-- RegisterCommand('blend', function()
--     showblender()
-- end)

-- function showblender()
-- --[[     local state = ''
--     if data.metadata.state == false then
--          state = 'Inactive'
--     else
--          state = 'Active'
--     end ]]

--     local header = "Blender unit (Inactive)"
--     -- header
-- --[[     local heavy_naphtha = data.metadata.heavy_naphtha
--     local light_naphtha = data.metadata.light_naphtha
--     local other_gases = data.metadata.other_gases
--  ]]
--     local openMenu = {
--          {
--               header = header,
--               isMenuHeader = true,
--               icon = 'fa-solid fa-blender'
--          }, {
--               header = 'Heavy Naphtha',
--               icon = 'fa-solid fa-circle',
--               txt = " Gallons",
--               disabled = true
--          },
--          {
--               header = 'Light Naphtha',
--               icon = 'fa-solid fa-circle',
--               txt = " Gallons",
--               disabled = true
--          },
--          {
--               header = 'Other Gases',
--               icon = 'fa-solid fa-circle',
--               txt = " Gallons",
--               disabled = true
--          },
--          {
--               header = 'Change Recipe',
--               icon = 'fa-solid fa-scroll',
--               params = {
--                    event = "keep-oilrig:blender_menu:recipe_blender"
--               }
--          },
--          {
--               header = 'Start Blending',
--               icon = 'fa-solid fa-arrows-spin',
--               params = {
--                    event = "keep-oilrig:blender_menu:toggle_blender"
--               }
--          },
--          {
--               header = 'leave',
--               icon = 'fa-solid fa-angle-left',
--               params = {
--                    event = "qb-menu:closeMenu"
--               }
--          }
--     }
--     exports['ucrp-context-new']:openMenu(openMenu)
-- end   

-- RegisterNetEvent("keep-oilrig:blender_menu:recipe_blender", function()
--     print("works")
-- end)
