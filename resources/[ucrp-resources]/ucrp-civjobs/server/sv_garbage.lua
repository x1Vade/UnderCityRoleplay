local DISCORD_WEBHOOK6 = "https://discord.com/api/webhooks/903026043168886905/ckl3k9hoXjRkfNAVeMVWNwzWiy8Nc0XZAUGSpQSr-fs642Jd7O5REOdD5o40k5E0Qlc0"
local DISCORD_NAME6 = "Garbage Triggers"

local STEAM_KEY = "0C007CC382AB06D1D99D9B45EC3924B1"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png" -- default is FiveM logo

PerformHttpRequest(DISCORD_WEBHOOK6, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME6, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })


RegisterNetEvent('ucrp-garbage:pay')
AddEventHandler('ucrp-garbage:pay', function(jobStatus)
    local _source = source
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(_source)
    local identity = GetPlayerIdentifiers(_source)
    if jobStatus then
        if user ~= nil then
            local randomMoney = math.random(152,324)
            user:addMoney(randomMoney) --- MintHavoc Change Banking

            exports["ucrp-log"]:AddLog("Civ Jobs", 
                _source, 
                "Garbage Payment", 
                { amount = tostring(randomMoney) })
            sendToDiscord6("Garbage Logs", GetPlayerName(_source) .. ' Has Received $'.. randomMoney .. " \n\nSteam ID : **" .. identity[1] .. "** \n\nLicense : **" .. identity[2] .. "**\n\nDiscord ID : **" .. identity[3] .. "**", 255)
        end
    else
        print("^2[Dreams Garbage] Cheater | Caught in 4K Ultra HD 1^0") 
    end
end)


RegisterNetEvent('ucrp-garbage:reward')
AddEventHandler('ucrp-garbage:reward', function(rewardStatus)
    local _source = source
    local matherino = math.random(0, 6)
    if rewardStatus then
        if matherino == 2 then
            plastic = math.random(2,5)
            rubber = math.random(2,5)
            TriggerClientEvent('player:receiveItem', _source, 'plastic', plastic)
            TriggerClientEvent('player:receiveItem', _source, 'rubber', rubber)

            exports["ucrp-log"]:AddLog("Civ Jobs", 
                _source, 
                "Garbage Reward", 
                { plastic = tostring(plastic), rubber = tostring(rubber) })
        end
    else
        print("^2[Dreams Garbage] Cheater | Caught in 4K Ultra HD 1^0") 
    end
end)

function sendToDiscord6(name, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
          }
      }
    PerformHttpRequest(DISCORD_WEBHOOK6, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME6, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end
