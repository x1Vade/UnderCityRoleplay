
-- local foodConfig = {
--     burger = {
--         {itemid = "bleederburger", displayName = ("uwucafee-sweet-rice-balls", "Sweet Rice Balls"), description = ("uwucafee-sweet-rice-balls-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
--         {itemid = "heartstopper", displayName = ("uwucafee-rice-ball-pudding", "Rice Ball Pudding"), description = ("uwucafee-rice-ball-pudding-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
--         {itemid = "torpedo", displayName = ("uwucafee-soothing-rice-balls", "Soothing Rice Balls"), description = ("uwucafee-soothing-rice-balls-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
--         {itemid = "moneyshot", displayName = ("uwucafee-energising-rice-balls", "Energising Rice Balls"), description = ("uwucafee-energising-rice-balls-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
--         {itemid = "meatfree", displayName = ("uwucafee-charismatic-rice-balls", "Charismatic Rice Balls"), description = ("uwucafee-charismatic-rice-balls-recipe", "1 Bun, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "lettuce"}},
--         {itemid = "questionablemeatburger", displayName = ("uwucafee-smart-rice-balls", "Smart Rice Balls"), description = ("uwucafee-questionable-smart-rice-balls-recipe", "1 Bun, 1 Questionable Meat, 1 Cheese, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "questionablemeat", "lettuce"}},
--         {itemid = "questionablemeatburger", displayName = ("uwucafee-filling-rice-balls", "Filling Rice Balls"), description = ("uwucafee-questionable-filling-rice-balls-recipe", "1 Bun, 1 Questionable Meat, 1 Cheese, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "questionablemeat", "lettuce"}},
--         {itemid = "questionablemeatburger", displayName = ("uwucafee-strong-rice-balls", "Strong Rice Balls"), description = ("uwucafee-questionable-strong-rice-recipe", "1 Bun, 1 Questionable Meat, 1 Cheese, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "questionablemeat", "lettuce"}},
--         {itemid = "uwuicecream", displayName = ("Uwucafee-Ice-Cream", "Ice Cream"), description = ("uwucafee-ice-cream-recipe",  "1 Milk, 1 Ice Cream"), craftTime = 10, recipe = {"milk", "icecreamingred"}},
--         {itemid = "uwugyro", displayName = ("Uwucafee-gyro", "Gyro"), description = ("uwucafee-gyro-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
--         {itemid = "uwusoup", displayName =  ("uwucafee-bowl-of-soup", "Bowl of Soup"), description = ("uwucafee-soup-recipe", "None"), craftTime = 5, recipe = {}},
--     },
--     drinks = {
--         {itemid = "water", displayName =  ("uwucafee-energising-matcha-coffee", "Energising Matcha Coffee"), description = ("uwucafee-none-recipe", "None"), craftTime = 5, recipe = {}},
--         {itemid = "softdrink", displayName =  ("uwucafee-filling-matcha-coffee", "Filling Matcha Coffee"), description = ("uwucafee-soft-drink-recipe", "1 High-Fructose Syrup"), craftTime = 5, recipe = {"hfcs"}},
--         {itemid = "mshake", displayName =  ("uwucafee-soothing-match-coffee", "Soothign Matcha Coffee"), description =  ("uwucafee-milkshake-recipe", "1 Milk, 1 Ice Cream"), craftTime = 10, recipe = {"milk", "icecreamingred"}},
--         {itemid = "fruitslushy", displayName =  ("uwucafee-strengthening-booba-milk-tea", "Strengthening Booba Milk Tea"), description =  ("uwucafee-fruit-slushy-recipe", "1 Apple, 1 Banana, 1 Cherry, 1 Orange, 1 Peach, 1 Strawberry"), craftTime = 15, recipe = {"apple", "banana", "cherry", "orange", "peach", "strawberry",}},
--         {itemid = "fruitslushy", displayName =  ("uwucafee-charismatic-booba-milk-tea", "Charismatic Booba Milk Tea"), description =  ("uwucafee-fruit-slushy-recipe", "1 Apple, 1 Banana, 1 Cherry, 1 Orange, 1 Peach, 1 Strawberry"), craftTime = 15, recipe = {"apple", "banana", "cherry", "orange", "peach", "strawberry",}},
--         {itemid = "fruitslushy", displayName =  ("uwucafee-smart-booba-milk-tea", "Smart Booba Milk Tea"), description =  ("uwucafee-fruit-slushy-recipe", "1 Apple, 1 Banana, 1 Cherry, 1 Orange, 1 Peach, 1 Strawberry"), craftTime = 15, recipe = {"apple", "banana", "cherry", "orange", "peach", "strawberry",}},

--     },
-- }

-- local isSignedOn = false

-- local burgerContext, drinksContext = {}, {}

-- local activePurchases = {}

-- local serverCode = "wl"

-- Citizen.CreateThread(function()
--     serverCode = "wl"
--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_signon', {{
--         event = "ucrp-uwucafee:signOnPrompt",
--         id = "uwu_chain_sign_on",
--         icon = "clock",
--         label = ("uwucafee-clock-in", "Clock In"),
--         parameters = { location = "main" }
--     }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return not isSignedOn end })

--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_signon', {{
--         event = "ucrp-uwucafee:getActiveEmployees",
--         id = "uwu_chain_active_employees",
--         icon = "list",
--         label = ("uwucafee-view-employee-list", "View Active Employees"),
--     }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return isSignedOn end })

--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_signon', {{
--         event = "ucrp-uwucafee:signOffPrompt",
--         id = "uwu_chain_sign_off",
--         icon = "clock",
--         label = ("uwucafee-clock-out", "Clock Out")
--     }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })


--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_shelfstorage', {{
--         event = "ucrp-uwucafee:shelfPrompt",
--         id = "uwu_chain_shelf_storage",
--         icon = "box-open",
--         label = ("uwucafee-open", "Open")
--     }}, { distance = { radius = 3.5 }  })


--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_fridge', {{
--         event = "ucrp-uwucafee:fridgePrompt",
--         id = "uwu_chain_fridge",
--         icon = "box-open",
--         label = ("uwucafee-open", "Open Fridge")
--     }}, { distance = { radius = 3.5 }  })

--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_station2', {{
--         event = "ucrp-uwucafee:stationPrompt",
--         id = 'uwu_chain_station_2', --Drinks
--         icon = "utensils",
--         label = ("uwucafee-open-station", "Prepare Food"),
--         parameters = { stationId = 2 }
--     }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })
--     print("here")

--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_station3', {{
--         event = "ucrp-uwucafee:stationPrompt",
--         id = 'uwu_chain_station_3', --Drinks
--         icon = "mug-hot",
--         label = ("uwucafee-open-station", "Open Station"),
--         parameters = { stationId = 3 }
--     }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

--     exports["ucrp-interact"]:AddPeekEntryByPolyTarget("ucrp-uwucafee:cafeejob_shelfstorage", {{
--         event = "ucrp-uwucafee:silentAlarm",
--         id = "foodchain_silent_alarm",
--         icon = "bell",
--         label = ("uwucafee-alert-police", "Alert Police")
--     }}, { distance = { radius = 3.0 }, isEnabled = isChargeActive })

--     exports["ucrp-interact"]:AddPeekEntryByPolyTarget("ucrp-uwucafee:cafeejob_shelfstorage2", {{
--         event = "ucrp-uwucafee:silentAlarm",
--         id = "foodchain_silent_alarm",
--         icon = "bell",
--         label = "Alert Police"
--     }}, { distance = { radius = 3.0 }, isEnabled = isChargeActive })

--     Cash Registers
--     local purchasePeekData = {{
--         event = "ucrp-uwucafee:registerPurchasePrompt",
--         icon = "cash-register",
--         label = ("uwucafee-make-payment", "Make Payment"),
--         parameters = {}
--     }}

--     local purchasePeekOptions = { distance = { radius = 3.5 } }

--     This should 100% not work, but it does because exports serialize/copy the object
--     If exports were to send references in the future then it would break for sure!

--     purchasePeekData[1].id = 'uwu_chain_register_customer_1'
--     purchasePeekData[1].parameters = {registerId = 1}
--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_register1', purchasePeekData, purchasePeekOptions)

--     purchasePeekData[1].id = 'uwu_chain_register_customer_2'
--     purchasePeekData[1].parameters = {registerId = 2}
--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_register2', purchasePeekData, purchasePeekOptions)
    


--     local registerPeekData = {{
--         event = "ucrp-uwucafee:registerChargePrompt",
--         icon = "credit-card",
--         label = ("uwucafee-charge-customer", "Charge Customer"),
--         parameters = {}
--     }}

--     local registerPeekOptions = { distance = { radius = 3.5 }, isEnabled = isChargeActive }

--     registerPeekData[1].id = 'uwu_chain_register_worker_1'
--     registerPeekData[1].parameters = { registerId = 1 }
--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_register1', registerPeekData, registerPeekOptions)
    
--     registerPeekData[1].id = 'uwu_chain_register_worker_2'
--     registerPeekData[1].parameters = { registerId = 2 }
--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_register2', registerPeekData, registerPeekOptions)

--     registerPeekData[1].id = 'uwu_chain_register_worker_3'
--     registerPeekData[1].parameters = { registerId = 3 }
--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_register3', registerPeekData, registerPeekOptions)

--     registerPeekData[1].id = 'uwu_chain_register_worker_4'
--     registerPeekData[1].parameters = { registerId = 4 }
--     exports['ucrp-interact']:AddPeekEntryByPolyTarget('ucrp-uwucafee:cafeejob_register4', registerPeekData, registerPeekOptions)

-- end)

-- function isChargeActive(pEntity, pContext)
--     return isSignedOn
-- end

-- RegisterUICallback('ucrp-uwucafee:orderFood', function (data, cb)
--     cb({ data = {}, meta = { ok = true, message = '' } })
--     local startPos = GetEntityCoords(PlayerPedId())

--     local tempContext, tempAction, tempAnimDict, tempAnim, animLoop = {}, "", "", "", false
--     if data.key.context == "burger" then
--         tempContext = burgerContext
--         tempAction = ("uwucafee-preparing", "Preparing") .. " "
--         tempAnimDict = "anim@amb@business@coc@coc_unpack_cut@"
--         tempAnim = "fullcut_cycle_v6_cokecutter"
--         animLoop = true
--     elseif data.key.context == "drinks" then
--         tempContext = drinksContext
--         tempAction = ("uwucafee-dispensing", "Dispensing") .. " "
--         tempAnimDict = "mp_ped_interaction"
--         tempAnim = "handshake_guy_a"
--         animLoop = false
--     end

--     Ingredient check
--     for _,itemid in pairs(data.key.recipe) do
--         local hasItem = exports['ucrp-inventory']:hasEnoughOfItem(itemid, 1, false, true)
--         print(hasItem)
--         if not hasItem then
--             TriggerEvent("DoLongHudText", ("uwucafee-youre-missing", "You're missing") .. " " .. tostring(itemid))
--             return
--         end
--     end

--     if IsPedArmed(PlayerPedId(), 7) then
--         SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
--     end

--     RequestAnimDict(tempAnimDict)

--     while not HasAnimDictLoaded(tempAnimDict) do
--         Citizen.Wait(0)
--     end

--     if IsEntityPlayingAnim(PlayerPedId(), tempAnimDict, tempAnim, 3) then
--         ClearPedSecondaryTask(PlayerPedId())
--     else
--         local animLength = animLoop and -1 or GetAnimDuration(tempAnimDict, tempAnim)
--         TaskPlayAnim(PlayerPedId(), tempAnimDict, tempAnim, 1.0, 4.0, animLength, 18, 0, 0, 0, 0)
--     end

--     local finished = exports["ucrp-taskbar"]:taskBar(data.key.craftTime * 1000, tempAction .. data.key.displayName)
--     if finished == 100 then
--         pos = GetEntityCoords(PlayerPedId(), false)
--         if(#(startPos - pos) < 2.0) then
--             for _,itemid in pairs(data.key.recipe) do
--                 TriggerEvent("inventory:removeItem", itemid, 1)
--             end
--             TriggerEvent("player:receiveItem", data.key.itemid, 1, false, {})
--             exports['ucrp-ui']:showContextMenu(tempContext)
--         end
--     end

--     StopAnimTask(PlayerPedId(), tempAnimDict, tempAnim, 3.0)
-- end)

-- AddEventHandler('ucrp-uwucafee:signOnPrompt', function(pParameters, pEntity, pContext)
--     isSignedOn, langString, message = RPC.execute("ucrp-uwucafee:tryJoinJob", pParameters.location)
--     if isSignedOn then
--         Build Context Menus
--         local cid = exports["isPed"]:isPed("cid")
--         for foodContext, data in pairs(foodConfig) do
--             local temp = {}
--             for k, item in pairs(data) do
--                 if not item.cid or item.cid == cid then
--                   temp[#temp+1] = {
--                       title = item.displayName,
--                       description = item.description .. " | " .. item.craftTime .. "s",
--                       action = "ucrp-uwucafee:orderFood",
--                       key = {itemid = item.itemid, displayName = item.displayName, craftTime = item.craftTime, recipe = item.recipe, context = foodContext},
--                       disabled = false
--                   }
--                 end
--             end

--             if foodContext == "burger" then
--                 burgerContext = temp
--             elseif foodContext == "drinks" then
--                 drinksContext = temp
--             end
--         end
--     end
--     TriggerEvent("DoLongHudText", (langString, message))
-- end)

-- AddEventHandler('ucrp-uwucafee:signOffPrompt', function(pParameters, pEntity, pContext)
--     TriggerEvent("DoLongHudText", ("uwucafee-clocked-out", "Clocked out."))
--     RPC.execute("ucrp-uwucafee:leaveJob")
--     isSignedOn = false
-- end)

-- AddEventHandler('ucrp-uwucafee:shelfPrompt', function(pParameters, pEntity, pContext)
--     TriggerEvent("server-inventory-open", "1", "cafeejob_shelf-" .. serverCode)
-- end)

-- AddEventHandler('ucrp-uwucafee:fridgePrompt', function(pParameters, pEntity, pContext)
--     TriggerEvent("server-inventory-open", "1", "cafeejob_fridge-" .. serverCode)
-- end)


-- AddEventHandler('ucrp-uwucafee:stationPrompt', function(pParameters, pEntity, pContext)
--     local tempContext, tempBrokeText, tempBrokeAction = {}, "", ""
--     if pParameters.stationId == 0 then
--         tempContext = miscContext
--         tempBrokeText = ("uwucafee-trays-cleaning-need", "The trays need cleaning")
--     elseif pParameters.stationId == 2 then
--         tempContext = burgerContext
--         tempBrokeText =  ("uwucafee-table-cleaning-need", "The table needs cleaning")
--     elseif pParameters.stationId == 3 then
--         tempContext = drinksContext
--         tempBrokeText =  ("uwucafee-dispenser-cleaning-need", "The dispenser needs cleaning")
--     end

--     Check if station is broken (server handles the random break chance)
--     local isActive = RPC.execute("ucrp-uwucafee:isStationActive", pParameters.stationId)

--     if not isActive then
--         Open failed dialog
--         local failedContext = {{
--             title = "Clean",
--             description = tempBrokeText,
--             action = "ucrp-uwucafee:cleanStation",
--             key = {stationId = pParameters.stationId},
--             disabled = false
--         }}
--         tempContext = failedContext
--     end
    
--     exports['ucrp-ui']:showContextMenu(tempContext)
-- end)

-- AddEventHandler('ucrp-uwucafee:registerPurchasePrompt', function(pParameters, pEntity, pContext)
--     local activeRegisterId = pParameters.registerId
--     local activeRegister = activePurchases[activeRegisterId]
--     if not activeRegister or activeRegister == nil then
--         TriggerEvent("DoLongHudText", ("uwucafee-no-active-purchase", "No purchase active."))
--         return
--     end
--     local priceWithTax = RPC.execute("PriceWithTaxString", activeRegister.cost, "Goods")
--     local acceptContext = {{
--         title = ("uwucafee-accept-purchase", "Accept Purchase"),
--         description = "$" .. priceWithTax.text .. " | " .. activeRegister.comment,
--         action = "ucrp-uwucafee:finishPurchasePrompt",
--         key = {cost = activeRegister.cost, comment = activeRegister.comment, registerId = pParameters.registerId, charger = activeRegister.charger},
--         disabled = false
--     }}
--     exports['ucrp-ui']:showContextMenu(acceptContext)
-- end)

-- AddEventHandler('ucrp-uwucafee:registerChargePrompt', function(pParameters, pEntity, pContext)
--     exports['ucrp-ui']:openApplication('textbox', {
--         callbackUrl = 'ucrp-ui:uwuwcaffee:charge',
--         key = pParameters.registerId,
--         items = {
--           {
--             icon = "dollar-sign",
--             label = ("uwucafee-cost", "Cost"),
--             name = "cost",
--           },
--           {
--             icon = "pencil-alt",
--             label = ("uwucafee-comment", "Comment"),
--             name = "comment",
--           },
--         },
--         show = true,
--     })
-- end)


-- RegisterUICallback('ucrp-uwucafee:cleanStation', function(data, cb)
--     local tempAnimDict = "amb@world_human_maid_clean@base"
--     local tempAnim = "base"

--     if IsPedArmed(PlayerPedId(), 7) then
--         SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
--     end

--     RequestAnimDict(tempAnimDict)

--     while not HasAnimDictLoaded(tempAnimDict) do
--         Citizen.Wait(0)
--     end

--     if IsEntityPlayingAnim(PlayerPedId(), tempAnimDict, tempAnim, 3) then
--         ClearPedSecondaryTask(PlayerPedId())
--     else
--         TaskPlayAnim(PlayerPedId(), tempAnimDict, tempAnim, 1.0, 4.0, -1, 19, 0, 0, 0, 0)
--     end

--     Open taskbar skill
--     local failed = false
--     for i=1,4 do
--         if not failed then
--             local finished = exports["ucrp-ui"]:taskBarSkill(3000,  math.random(15, 20))
--             if finished ~= 100 then
--                 failed = true
--             end
--         end
--     end

--     StopAnimTask(PlayerPedId(), tempAnimDict, tempAnim, 3.0)

--     if not failed then
--         RPC.execute("ucrp-uwucafee:setStationActive", data.key.stationId)
--         TriggerEvent("DoLongHudText", ("uwucafee-station-cleaned", "Station cleaned."))
--     end
-- end)

-- RegisterUICallback('ucrp-uwucafee:finishPurchasePrompt', function (data, cb)
--     cb({ data = {}, meta = { ok = true, message = '' } })
--     local success = RPC.execute("ucrp-uwucafee:completePurchase", data.key)
--     if not success then
--         TriggerEvent("DoLongHudText", ("uwucafee-could-not-complete-purchase", "The purchase could not be completed."))
--     end
-- end)

-- RegisterUICallback("ucrp-ui:uwuwcaffee:charge", function(data, cb)
--     cb({ data = {}, meta = { ok = true, message = '' } })
--     exports['ucrp-ui']:closeApplication('textbox')
--     local cost = tonumber(data[1].value)
--     local comment = data[2].value
--     check if cost is actually a number
--     if cost == nil or not cost then return end
--     if comment == nil then comment = "" end

--     if cost < 10 then cost = 10 end --Minimum $10

--     Send event to everyone indicating a purchase is ready at specified register
--     RPC.execute("ucrp-uwucafee:startPurchase", {cost = cost, comment = comment, registerId = data[3].value})
-- end)

-- Add to purchases at registerId pos
-- RegisterNetEvent('ucrp-uwucafee:activePurchase')
-- AddEventHandler("ucrp-uwucafee:activePurchase", function(data)
--     activePurchases[data.registerId] = data
-- end)

-- Remove at registerId pos
-- RegisterNetEvent('ucrp-uwucafee:closePurchase')
-- AddEventHandler("ucrp-uwucafee:closePurchase", function(data)
--     activePurchases[data.registerId] = nil
-- end)

-- Getting fired
-- RegisterNetEvent('ucrp-uwucafee:firedEmployee')
-- AddEventHandler("ucrp-uwucafee:firedEmployee", function(langString, defaultString)
--     isSignedOn = false
--     TriggerEvent("DoLongHudText", (langString, defaultString), 2)
-- end)

-- Firing someone
-- RegisterNetEvent('ucrp-uwucafee:cafeejob_fire')
-- AddEventHandler("ucrp-uwucafee:cafeejob_fire", function(employee)
--     if employee == nil then return end
--     local success = RPC.execute("ucrp-uwucafee:fireEmployee", employee)
--     if success then 
--         TriggerEvent("DoLongHudText", ("uwucafee-fired-employee", "Fired Employee"))
--     end
-- end)

-- active employee list
-- AddEventHandler('ucrp-uwucafee:getActiveEmployees', function ()
--     local employees = RPC.execute('ucrp-uwucafee:server:getActiveEmployees')

--     local mappedEmployees = {}

--     for location, list in pairs(employees) do
--         local fancyLocationName = ("uwucafee-main-restaurant", "Main Cafee")
--         for _, employee in pairs(employees[location]) do
--             table.insert(mappedEmployees, {
--                 title = string.format("%s (%s)", employee.name, employee.cid),
--                 description = string.format(("uwucafee-clocked-in-at", "Clocked in at %s"), fancyLocationName),
--             })
--         end
--     end
--     if #mappedEmployees == 0 then
--         table.insert(mappedEmployees, {
--             title = ("uwucafee-no-active-employees", "Nobody is clocked in currently"),
--         })
--     end

--     exports['ucrp-ui']:showContextMenu(mappedEmployees)
-- end)


-- RegisterNetEvent('ucrp-uwucafee:cash:in')
-- AddEventHandler('ucrp-uwucafee:cash:in', function()
--     local cid = exports["isPed"]:isPed("cid")
--     TriggerServerEvent("ucrp-uwucafee:update:pay", cid)
-- end)

-- function loadAnimDict( dict )
--     while ( not HasAnimDictLoaded( dict ) ) do
--         RequestAnimDict( dict )
--         Citizen.Wait( 5 )
--     end
-- end




 