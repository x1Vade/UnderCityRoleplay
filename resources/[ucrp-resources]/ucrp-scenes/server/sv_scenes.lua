local Scenes = {}
local LogLocation = "logs/scenes-"..os.date("%Y%m%d%H%M%S")..".txt"
local id = 0
local distToErase = 1

SendScenes = function(ply)
    TriggerClientEvent("ucrp-scenes:updateScenes", ply, Scenes)
end

RPC.register("ucrp-scenes:getScenes", function(pSource)
    SendScenes(-1)
    return Scenes
end)

RPC.register("ucrp-scenes:addScene", function(pSource, pData)
    id = id + 1
    print(json.encode(pData))
    table.insert(Scenes, {
        id = id,
        text = pData.text,
        colour = pData.colour,
        distance = pData.distance,
        pos = pData.pos,
        peek = pData.peekOnly,
        font = pData.font,
        processed = false
    })

    SendScenes(-1)

    exports["ucrp-log"]:AddLog("Scenes", 
        pSource, "Add Scene", { message = tostring(message), data = json.encode(pData) })
    return true
end)

RPC.register("ucrp-scenes:deleteScene", function(pSource, pPos)
    for id, scene in pairs(Scenes) do
        if (#(pPos - scene.pos) < distToErase) then
            table.remove(Scenes, id)

            TriggerClientEvent("ucrp-scenes:deleteScene", -1, scene.id)

            exports["ucrp-log"]:AddLog("Scenes", 
                pSource, "Remove Scene", { pos = json.encode(pPos) })
        end
    end
    SendScenes(-1)

    return true 
end)