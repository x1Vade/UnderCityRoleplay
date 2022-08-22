local isOpen = false
local callSign = ""
local searchQuery = ""
local selectedQuery = ""
local mdtData = {}

function EnableGUI(enable)
    if enable then
        TriggerServerEvent('ucrp-mdt:opendashboard')
    end

    SetNuiFocus(enable, enable)
    SendNUIMessage({
        type = "show",
        enable = enable,
        job = mdtData["job"],
        department = mdtData["department"] or ""
    })

    isOpen = enable
    TriggerEvent('ucrp-mdt:animation')
end

function RefreshGUI()
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "show",
        enable = false,
        job = mdtData["job"],
        department = mdtData["department"]
    })

    isOpen = false
end

RegisterCommand("restartmdt", function(source, args, rawCommand)
    RefreshGUI()
end, false)

RegisterCommand("restartmdt2", function(source, args, rawCommand)
    local dist = (#(GetEntityCoords(PlayerPedId()) - GetBlipCoords(GetFirstBlipInfoId(8))) / 1000) * 0.715 -- quick conversion maff
    SendNUIMessage({
        type = "logsjs",
        data = dist
    })

end, false)

local tablet = 0
local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local tabletAnim = "base"
local tabletProp = `prop_cs_tablet`
local tabletBone = 60309
local tabletOffset = vector3(0.03, 0.002, -0.0)
local tabletRot = vector3(10.0, 160.0, 0.0)

RegisterNetEvent('ucrp-mdt:openMDTMenu')
AddEventHandler('ucrp-mdt:openMDTMenu', function()
    TriggerServerEvent("ucrp-mdt:openMDTMenu")
end)

AddEventHandler('ucrp-mdt:animation', function()
    if not isOpen then
        return
    end
    -- Animation
    RequestAnimDict(tabletDict)
    while not HasAnimDictLoaded(tabletDict) do
        Citizen.Wait(100)
    end

    -- Model
    RequestModel(tabletProp)
    while not HasModelLoaded(tabletProp) do
        Citizen.Wait(100)
    end

    local plyPed = PlayerPedId()
    local tabletObj = CreateObject(tabletProp, 0.0, 0.0, 0.0, true, true, false)
    local tabletBoneIndex = GetPedBoneIndex(plyPed, tabletBone)

    TriggerEvent('actionbar:setEmptyHanded')
    AttachEntityToEntity(tabletObj, plyPed, tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z,
        tabletRot.x, tabletRot.y, tabletRot.z, true, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(tabletProp)

    CreateThread(function()
        while isOpen do
            Wait(0)
            if not IsEntityPlayingAnim(plyPed, tabletDict, tabletAnim, 3) then
                TaskPlayAnim(plyPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
        ClearPedSecondaryTask(plyPed)
        Citizen.Wait(250)
        DetachEntity(tabletObj, true, false)
        DeleteEntity(tabletObj)
        return
    end)
end)

local function CurrentDuty(duty)
    if duty == 1 then
        return "10-41"
    end
    return "10-42"
end

RegisterNetEvent('ucrp-mdt:dashboardbulletin')
AddEventHandler('ucrp-mdt:dashboardbulletin', function(sentData)
    SendNUIMessage({
        type = "bulletin",
        data = sentData
    })
end)

RegisterNetEvent('ucrp-mdt:dashboardWarrants')
AddEventHandler('ucrp-mdt:dashboardWarrants', function(sentData)
    SendNUIMessage({
        type = "warrants",
        data = sentData
    })
end)

RegisterNetEvent('ucrp-mdt:dashboardReports')
AddEventHandler('ucrp-mdt:dashboardReports', function(sentData)
    SendNUIMessage({
        type = "reports",
        data = sentData
    })
end)

RegisterNetEvent('ucrp-mdt:dashboardCalls')
AddEventHandler('ucrp-mdt:dashboardCalls', function(sentData)
    SendNUIMessage({
        type = "calls",
        data = sentData
    })
end)

RegisterNUICallback("deleteBulletin", function(data, cb)
    local id = data.id
    TriggerServerEvent('ucrp-mdt:deleteBulletin', id)
    cb(true)
end)

RegisterNUICallback("newBulletin", function(data, cb)
    local title = data.title
    local info = data.info
    local time = data.time
    TriggerServerEvent('ucrp-mdt:newBulletin', title, info, time, data.id)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:newBulletin')
AddEventHandler('ucrp-mdt:newBulletin', function(ignoreId, sentData, job)
    if ignoreId == GetPlayerServerId(PlayerId()) then
        return
    end
    if job == 'police' then
        SendNUIMessage({
            type = "newBulletin",
            data = sentData
        })
        -- elseif job == exports["rs_manager"]:isChar("myjob") then
        --     SendNUIMessage({ type = "newBulletin", data = sentData })
    end
end)

RegisterNetEvent('ucrp-mdt:deleteBulletin')
AddEventHandler('ucrp-mdt:deleteBulletin', function(ignoreId, sentData, job)
    if ignoreId == GetPlayerServerId(PlayerId()) then
        return
    end
    if job == 'police' then
        SendNUIMessage({
            type = "deleteBulletin",
            data = sentData
        })
        -- elseif job == exports["rs_manager"]:isChar("myjob") then
        --     SendNUIMessage({ type = "deleteBulletin", data = sentData })
    end
end)

RegisterNetEvent('ucrp-mdt:open')
AddEventHandler('ucrp-mdt:open', function(jobLabel, lastname, firstname, nickname, deptartment, job, rankNo)
    open = true
    mdtData["jobLabel"] = jobLabel
    mdtData["lastname"] = lastname
    mdtData["firstname"] = firstname
    mdtData["nickname"] = nickname
    mdtData["department"] = deptartment
    mdtData["job"] = job

    Citizen.Wait(100)
    EnableGUI(open)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    local zone = tostring(GetNameOfZone(x, y, z))
    local area = GetLabelText(zone)
    local playerStreetsLocation = area

    if not zone then
        zone = "UNKNOWN"
    end

    if intersectStreetName ~= nil and intersectStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. ", " .. intersectStreetName .. ", " .. area
    elseif currentStreetName ~= nil and currentStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. ", " .. area
    else
        playerStreetsLocation = area
    end

    if nickname ~= "" then
        nickname = " \"" .. nickname .. "\""
    end

    SendNUIMessage({
        type = "data",
        name = jobLabel .. ' ' .. firstname .. nickname .. ' ' .. lastname,
        location = playerStreetsLocation,
        fullname = firstname .. ' ' .. lastname,
        dept = deptartment,
        rankNo = rankNo
    })
end)

RegisterNUICallback('escape', function(data, cb)
    open = false
    EnableGUI(open)
    cb(true)
end)

RegisterNUICallback("searchProfiles", function(data, cb)
    local name = data.name
    TriggerServerEvent('ucrp-mdt:searchProfile', name)
    searchQuery = name
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:exitMDT')
AddEventHandler('ucrp-mdt:exitMDT', function()
    open = false
    EnableGUI(open)
end)

-- (Start) Requesting profile information

RegisterNetEvent('ucrp-mdt:searchProfile')
AddEventHandler('ucrp-mdt:searchProfile', function(sentData, isLimited)
    SendNUIMessage({
        type = "profiles",
        data = sentData,
        isLimited = isLimited
    })
end)

RegisterNUICallback("saveProfile", function(data, cb)
    local profilepic = data.pfp
    local information = data.description
    local cid = data.id
    local fName = data.fName
    local sName = data.sName
    TriggerServerEvent("ucrp-mdt:saveProfile", profilepic, information, cid, fName, sName)
    cb(true)
end)

RegisterNUICallback("getProfileData", function(data, cb)
    local id = data.id
    TriggerServerEvent('ucrp-mdt:getProfileData', id)
    selectedQuery = id
    cb(true)
end)

RegisterNUICallback("newTag", function(data, cb)
    if data.id ~= "" and data.tag ~= "" then
        TriggerServerEvent('ucrp-mdt:newTag', data.id, data.tag)
    end
    cb(true)
end)

RegisterNUICallback("removeProfileTag", function(data, cb)
    local cid = data.cid
    local tagtext = data.text
    TriggerServerEvent('ucrp-mdt:removeProfileTag', cid, tagtext)
    cb(removeProfileTag)
end)

RegisterNetEvent('ucrp-mdt:refreshProfileData')
AddEventHandler('ucrp-mdt:refreshProfileData', function ()
    TriggerServerEvent('ucrp-mdt:searchProfile', searchQuery)
    TriggerServerEvent('ucrp-mdt:getProfileData', selectedQuery)
end)

RegisterNetEvent('ucrp-mdt:getProfileData')
AddEventHandler('ucrp-mdt:getProfileData', function(sentData, isLimited)

    if not isLimited then
        local vehicles = sentData['vehicles']
        for i = 1, #vehicles do
            sentData['vehicles'][i]['plate'] = string.upper(sentData['vehicles'][i]['license_plate'])
            sentData['vehicles'][i]['model'] = sentData['vehicles'][i]['name']
        end
    end

    SendNUIMessage({
        type = "profileData",
        data = sentData,
        isLimited = isLimited
    })
end)

RegisterNUICallback("updateLicence", function(data, cb)
    local type = data.type
    local status = data.status
    local cid = data.cid
    TriggerServerEvent('ucrp-mdt:updateLicense', cid, type, status)
    cb(true)
end)

RegisterNUICallback("addGalleryImg", function(data, cb)
    local cid = data.cid
    local url = data.URL
    TriggerServerEvent('ucrp-mdt:addGalleryImg', cid, url)
    cb(true)
end)

RegisterNUICallback("removeGalleryImg", function(data, cb)
    local cid = data.cid
    local url = data.URL
    TriggerServerEvent('ucrp-mdt:removeGalleryImg', cid, url)
    cb(true)
end)

RegisterNUICallback("searchIncidents", function(data, cb)
    local incident = data.incident
    TriggerServerEvent('ucrp-mdt:searchIncidents', incident)
    cb(true)
end)

RegisterNUICallback("sendToJail", function(data, cb)
    local value = data.value
    local time = data.time
    TriggerServerEvent('ucrp-mdt:sendToJail', time, src, value)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getIncidents')
AddEventHandler('ucrp-mdt:getIncidents', function(sentData)
    SendNUIMessage({
        type = "incidents",
        data = sentData
    })
end)

RegisterNUICallback("getIncidentData", function(data, cb)
    local id = data.id
    TriggerServerEvent('ucrp-mdt:getIncidentData', id)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getIncidentData')
AddEventHandler('ucrp-mdt:getIncidentData', function(sentData, sentConvictions)
    SendNUIMessage({
        type = "incidentData",
        data = sentData,
        convictions = sentConvictions
    })
end)

RegisterNUICallback("incidentSearchPerson", function(data, cb)
    local name = data.name
    TriggerServerEvent('ucrp-mdt:incidentSearchPerson', name)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:incidentSearchPerson')
AddEventHandler('ucrp-mdt:incidentSearchPerson', function(sentData)
    SendNUIMessage({
        type = "incidentSearchPerson",
        data = sentData
    })
end)

-- BOlO

RegisterNUICallback("searchBolos", function(data, cb)
    local searchVal = data.searchVal
    TriggerServerEvent('ucrp-mdt:searchBolos', searchVal)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getBolos')
AddEventHandler('ucrp-mdt:getBolos', function(sentData)
    SendNUIMessage({
        type = "bolos",
        data = sentData
    })
end)

RegisterNUICallback("getAllBolos", function(data, cb)
    TriggerServerEvent('ucrp-mdt:getAllBolos')
    cb(true)
end)

RegisterNUICallback("getAllIncidents", function(data, cb)
    sentData = RPC.execute("MDT:GetAllIncidents")
    SendNUIMessage({
        type = "incidents",
        data = sentData
    })
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getAllBolos')
AddEventHandler('ucrp-mdt:getAllBolos', function(sentData)
    SendNUIMessage({
        type = "bolos",
        data = sentData
    })
end)

RegisterNUICallback("getBoloData", function(data, cb)
    local id = data.id
    TriggerServerEvent('ucrp-mdt:getBoloData', id)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getBoloData')
AddEventHandler('ucrp-mdt:getBoloData', function(sentData)
    SendNUIMessage({
        type = "boloData",
        data = sentData
    })
end)

RegisterNUICallback("newBolo", function(data, cb)
    local existing = data.existing
    local id = data.id
    local title = data.title
    local plate = data.plate
    local owner = data.owner
    local individual = data.individual
    local detail = data.detail
    local tags = data.tags
    local gallery = data.gallery
    local officers = data.officers
    local time = data.time
    TriggerServerEvent('ucrp-mdt:newBolo', data)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:boloComplete')
AddEventHandler('ucrp-mdt:boloComplete', function(sentData)
    SendNUIMessage({
        type = "boloComplete",
        data = sentData
    })
end)

RegisterNUICallback("deleteBolo", function(data, cb)
    local id = data.id
    TriggerServerEvent('ucrp-mdt:deleteBolo', id)
    cb(true)
end)

RegisterNUICallback("deleteICU", function(data, cb)
    local id = data.id
    TriggerServerEvent('ucrp-mdt:deleteICU', id)
    cb(true)
end)

-- Reports

RegisterNUICallback("getAllReports", function(data, cb)
    TriggerServerEvent('ucrp-mdt:getAllReports')
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getAllReports')
AddEventHandler('ucrp-mdt:getAllReports', function(sentData)
    SendNUIMessage({
        type = "reports",
        data = sentData
    })
end)

RegisterNUICallback("getReportData", function(data, cb)
    local id = data.id
    TriggerServerEvent('ucrp-mdt:getReportData', id)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getReportData')
AddEventHandler('ucrp-mdt:getReportData', function(sentData)
    SendNUIMessage({
        type = "reportData",
        data = sentData
    })
end)

RegisterNUICallback("searchReports", function(data, cb)
    local name = data.name
    TriggerServerEvent('ucrp-mdt:searchReports', name)
    cb(true)
end)

RegisterNUICallback("newReport", function(data, cb)
    TriggerServerEvent('ucrp-mdt:newReport', data)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:reportComplete')
AddEventHandler('ucrp-mdt:reportComplete', function(sentData)
    SendNUIMessage({
        type = "reportComplete",
        data = sentData
    })
end)

-- DMV Page
RegisterNUICallback("searchVehicles", function(data, cb)
    local name = data.name
    TriggerServerEvent('ucrp-mdt:searchVehicles', name)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:searchVehicles')
AddEventHandler('ucrp-mdt:searchVehicles', function(sentData)
    for i = 1, #sentData do
        sentData[i]["dbid"] = sentData[i]['id']
        sentData[i]['plate'] = string.upper(sentData[i]['license_plate'])
        sentData[i]['color'] = ColorInformation[sentData[i]['primarycolor']]
        sentData[i]['colorName'] = ColorNames[sentData[i]['secondarycolor']]
        sentData[i]['model'] = sentData[i]['name']
    end

    SendNUIMessage({
        type = "searchedVehicles",
        data = sentData
    })
end)

RegisterNUICallback("getVehicleData", function(data, cb)
    local plate = data.plate
    TriggerServerEvent('ucrp-mdt:getVehicleData', plate)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getVehicleData')
AddEventHandler('ucrp-mdt:getVehicleData', function(sentData)
    if sentData and sentData[1] then
        local vehicle = sentData[1]
        vehicle["dbid"] = vehicle["id"]
        vehicle['color'] = ColorInformation[vehicle['primarycolor']]
        vehicle['colorName'] = ColorNames[vehicle['secondarycolor']]
        vehicle['model'] = vehicle['name']
        vehicle['class'] = classlist[GetVehicleClassFromName(vehicle['model'])]
        vehicle['vehicle'] = nil
        SendNUIMessage({
            type = "getVehicleData",
            data = vehicle
        })
    end
end)

RegisterNUICallback("saveVehicleInfo", function(data, cb)
    local dbid = data.dbid
    local plate = data.plate
    local imageurl = data.imageurl
    local notes = data.notes
    TriggerServerEvent('ucrp-mdt:saveVehicleInfo', dbid, plate, imageurl, notes)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:updateVehicleDbId')
AddEventHandler('ucrp-mdt:updateVehicleDbId', function(sentData)
    SendNUIMessage({
        type = "updateVehicleDbId",
        data = tonumber(sentData)
    })
end)

RegisterNUICallback("knownInformation", function(data, cb)
    local dbid = data.dbid
    local type = data.type
    local status = data.status
    local plate = data.plate
    TriggerServerEvent('ucrp-mdt:knownInformation', dbid, type, status, plate)
    cb(true)
end)

RegisterNUICallback("getAllLogs", function(data, cb)
    sentData = RPC.execute("MDT:GetAllLogs")
    SendNUIMessage({
        type = "getAllLogs",
        data = sentData
    })
    cb(true)
end)

RegisterNUICallback("getAllStaff", function(data, cb)
    staffTable = RPC.execute("MDT:GetAllStaff", mdtData["job"])
    SendNUIMessage({
        type = "getAllStaff",
        data = staffTable,
        ranks = Ranks
    })
    cb(true)
end)

RegisterNUICallback("getStaffData", function(data, cb)
    staffTable = RPC.execute("MDT:GetStaffInfo", data["id"])

    SendNUIMessage({
        type = "getStaffInfo",
        data = staffTable
    })

    cb(true)
end)

RegisterNUICallback("saveStaffInfo", function(data, cb)
    RPC.execute("MDT:UpdateStaffInfo", data)
    cb(true)
end)

RegisterNUICallback("hirecid", function(data, cb)
    RPC.execute("MDT:HireStaffMember", data.cid, mdtData["job"])
    cb(true)
end)

RegisterNUICallback("dismissStaff", function(data, cb)
    RPC.execute("MDT:DismissStaffMember", data["cid"])
    cb(true)
end)

RegisterNUICallback("getPenalCode", function(data, cb)
    TriggerServerEvent('ucrp-mdt:getPenalCode')
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getPenalCode')
AddEventHandler('ucrp-mdt:getPenalCode', function(titles, penalcode)
    SendNUIMessage({
        type = "getPenalCode",
        titles = titles,
        penalcode = penalcode
    })
end)

RegisterNetEvent('ucrp-mdt:getActiveUnits')
AddEventHandler('ucrp-mdt:getActiveUnits', function(lspd, bcso, sahp, sasp, doc, sapr, pa, ems, judge)
    SendNUIMessage({
        type = "getActiveUnits",
        lspd = lspd,
        bcso = bcso,
        sahp = sahp,
        doc = doc,
        sasp = sasp,
        sapr = sapr,
        pa = pa,
        ems = ems,
        judge = judge
    })
end)

RegisterNUICallback("toggleDuty", function(data, cb)
    TriggerServerEvent('ucrp-mdt:toggleDuty', data.cid, data.status)
    cb(true)
end)

RegisterNUICallback("setCallsign", function(data, cb)
    TriggerServerEvent('ucrp-mdt:setCallsign', data.cid, data.newcallsign)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:updateCallsign')
AddEventHandler('ucrp-mdt:updateCallsign', function(callsign)
    callSign = tostring(callsign)
end)

RegisterNUICallback("saveIncident", function(data, cb)
    TriggerServerEvent('ucrp-mdt:saveIncident', data)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:updateIncidentDbId')
AddEventHandler('ucrp-mdt:updateIncidentDbId', function(sentData)
    SendNUIMessage({
        type = "updateIncidentDbId",
        data = tonumber(sentData)
    })
end)

RegisterNUICallback("removeIncidentCriminal", function(data, cb)
    TriggerServerEvent('ucrp-mdt:removeIncidentCriminal', data.cid, data.incidentId)
    cb(true)
end)

-- Dispatch

RegisterNUICallback('setWaypoint', function(data, cb)
    TriggerEvent('DoLongHudText', "GPS marked!", 1)
    SetNewWaypoint(tonumber(data.x), tonumber(data.y))
end)

RegisterNUICallback("callDetach", function(data, cb)
    TriggerServerEvent('ucrp-mdt:callDetach', data.callid)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:callDetach')
AddEventHandler('ucrp-mdt:callDetach', function(callid, sentData)
    -- local job = exports["rs_manager"]:isChar("myjob")
    if job == "police" or job == 'ems' then
        SendNUIMessage({
            type = "callDetach",
            callid = callid,
            data = tonumber(sentData)
        })
    end
end)

RegisterNUICallback("callAttach", function(data, cb)
    TriggerServerEvent('ucrp-mdt:callAttach', data.callid)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:callAttach')
AddEventHandler('ucrp-mdt:callAttach', function(callid, sentData)
    -- local job = exports["rs_manager"]:isChar("myjob")
    -- if job == "police" or job == 'ems' then
    SendNUIMessage({
        type = "callAttach",
        callid = callid,
        data = tonumber(sentData)
    })
    -- end
end)

RegisterNetEvent('dispatch:clNotify')
AddEventHandler('dispatch:clNotify', function(sNotificationData, sNotificationId)
    SendNUIMessage({
        type = "call",
        data = sNotificationData
    })
end)

RegisterNUICallback("attachedUnits", function(data, cb)
    TriggerServerEvent('ucrp-mdt:attachedUnits', data.callid)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:attachedUnits')
AddEventHandler('ucrp-mdt:attachedUnits', function(sentData, callid)
    SendNUIMessage({
        type = "attachedUnits",
        data = sentData,
        callid = callid
    })
end)

RegisterNUICallback("callDispatchDetach", function(data, cb)
    TriggerServerEvent('ucrp-mdt:callDispatchDetach', data.callid, data.cid)
    cb(true)
end)

RegisterNUICallback("setDispatchWaypoint", function(data, cb)
    TriggerServerEvent('ucrp-mdt:setDispatchWaypoint', data.callid, data.cid)
    cb(true)
end)

RegisterNUICallback("callDragAttach", function(data, cb)
    TriggerServerEvent('ucrp-mdt:callDragAttach', data.callid, data.cid)
    cb(true)
end)

RegisterNUICallback("setWaypointU", function(data, cb)
    TriggerServerEvent('ucrp-mdt:setWaypoint:unit', data.cid)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:setWaypoint:unit')
AddEventHandler('ucrp-mdt:setWaypoint:unit', function(sentData)
    SetNewWaypoint(sentData.x, sentData.y)
end)

-- Dispatch

RegisterNUICallback("dispatchMessage", function(data, cb)
    TriggerServerEvent('ucrp-mdt:sendMessage', data.message, data.time)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:dashboardMessage')
AddEventHandler('ucrp-mdt:dashboardMessage', function(sentData)
    -- local job = exports["rs_manager"]:isChar("myjob")
    -- if job == "police" or job.name == 'ems' then
    SendNUIMessage({
        type = "dispatchmessage",
        data = sentData
    })
    -- end
end)

RegisterNetEvent('ucrp-mdt:dashboardMessages')
AddEventHandler('ucrp-mdt:dashboardMessages', function(sentData)
    SendNUIMessage({
        type = "dispatchmessages",
        data = sentData
    })
end)

RegisterNUICallback("refreshDispatchMsgs", function(data, cb)
    TriggerServerEvent('ucrp-mdt:refreshDispatchMsgs')
    cb(true)
end)

RegisterNUICallback("dispatchNotif", function(data, cb)
    local info = data['data']
    local mentioned = false
    if callSign ~= "" then
        if string.find(info['message'], callSign) then
            mentioned = true
        end
    end
    if mentioned then
        TriggerEvent('ucrp-phone:sendNotification', {
            img = info['profilepic'],
            title = "Dispatch (Mention)",
            content = info['message'],
            time = 7500,
            customPic = true
        })
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    else
        TriggerEvent('ucrp-phone:sendNotification', {
            img = info['profilepic'],
            title = "Dispatch (" .. info['name'] .. ")",
            content = info['message'],
            time = 5000,
            customPic = true
        })
    end
    cb(true)
end)

RegisterNUICallback("getCallResponses", function(data, cb)
    TriggerServerEvent('ucrp-mdt:getCallResponses', data.callid)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:getCallResponses')
AddEventHandler('ucrp-mdt:getCallResponses', function(sentData, sentCallId)
    SendNUIMessage({
        type = "getCallResponses",
        data = sentData,
        callid = sentCallId
    })
end)

RegisterNUICallback("sendCallResponse", function(data, cb)
    TriggerServerEvent('ucrp-mdt:sendCallResponse', data.message, data.time, data.callid)
    cb(true)
end)

RegisterNetEvent('ucrp-mdt:sendCallResponse')
AddEventHandler('ucrp-mdt:sendCallResponse', function(message, time, callid, name)
    SendNUIMessage({
        type = "sendCallResponse",
        message = message,
        time = time,
        callid = callid,
        name = name
    })
end)

function tprint(t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) .. '"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"' .. tostring(v) .. '"'
        if type(v) == 'table' then
            tprint(v, (s or '') .. kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t) .. (s or '') .. kfmt .. ' = ' .. vfmt)
        end
    end
end