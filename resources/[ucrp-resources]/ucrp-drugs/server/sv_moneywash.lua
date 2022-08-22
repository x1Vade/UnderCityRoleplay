local DISCORD_WEBHOOK5 = "https://discord.com/api/webhooks/985989385000464445/SW1li4UPNxqm01-9yYNNsYXWgb5h6e1jXOhxLt-gtOdTkCytZw6C5jlXTRuZPGvuPkb_"
local DISCORD_NAME5 = "Money Wash Trigger"

local STEAM_KEY = "9A0E59E50BE7C589C51E6A31746CE01A"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png" -- default is FiveM logo


RegisterServerEvent('mission:finished:rolls')
AddEventHandler('mission:finished:rolls', function(money, cid, pDiscord, pSteam)
    local src = source
    local player = GetPlayerName(src)
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    local sname = GetPlayerName(source)
    local identity = GetPlayerIdentifiers(source)
    local pIdentifiers = GetPlayerIdentifiers(source)
    for k, v in pairs(pIdentifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end
    if money ~= nil then
        user:addMoney(money)--- MintHavoc Change Banking
        if money > 0 then
            sendToDiscord5("Money Wash", sname .. ' Has Receieved ' ..money.. " From Rolls of Cash".. "\n\nSteam ID : **" .. pSteam .. "** \n\nLicense : **" .. identity[2] .. "** \n\nCID/STATE ID : **" .. cid .. "**\n\nDiscord ID : **" .. pDiscord .. "**", 255)
        end
    end
end)

RegisterServerEvent('mission:finished:bands')
AddEventHandler('mission:finished:bands', function(money, cid, pDiscord, pSteam)
    local src = source
    local player = GetPlayerName(src)
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    local sname = GetPlayerName(source)
    local identity = GetPlayerIdentifiers(source)
    local pIdentifiers = GetPlayerIdentifiers(source)
    for k, v in pairs(pIdentifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end
    if money ~= nil then
        user:addMoney(money)--- MintHavoc Change Banking
        if money > 0 then
            sendToDiscord5("Money Wash", sname .. ' Has Receieved ' ..money.. " From Bands".. "\n\nSteam ID : **" .. pSteam .. "** \n\nLicense : **" .. identity[2] .. "** \n\nCID/STATE ID : **" .. cid .. "**\n\nDiscord ID : **" .. pDiscord .. "**", 255)
        end
    end
end)

RegisterServerEvent('mission:finished:inkbags')
AddEventHandler('mission:finished:inkbags', function(money, cid, pDiscord, pSteam)
    local src = source
    local player = GetPlayerName(src)
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    local sname = GetPlayerName(source)
    local identity = GetPlayerIdentifiers(source)
    local pIdentifiers = GetPlayerIdentifiers(source)
    for k, v in pairs(pIdentifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end
    if money ~= nil then
        user:addMoney(money)--- MintHavoc Change Banking
        if money > 0 then
            sendToDiscord5("Money Wash", sname .. ' Has Receieved ' ..money.. " From Ink Bags".. "\n\nSteam ID : **" .. pSteam .. "** \n\nLicense : **" .. identity[2] .. "** \n\nCID/STATE ID : **" .. cid .. "**\n\nDiscord ID : **" .. pDiscord .. "**", 255)
        end
    end
end)

RegisterServerEvent('mission:finished:inkset')
AddEventHandler('mission:finished:inkset', function(money, cid, pDiscord, pSteam)
    local src = source
    local player = GetPlayerName(src)
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    local sname = GetPlayerName(source)
    local identity = GetPlayerIdentifiers(source)
    local pIdentifiers = GetPlayerIdentifiers(source)
    for k, v in pairs(pIdentifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end
    if money ~= nil then
        user:addMoney(money)--- MintHavoc Change Banking
        if money > 0 then
            sendToDiscord5("Money Wash", sname .. ' Has Receieved ' ..money.. " From Ink Set".. "\n\nSteam ID : **" .. pSteam .. "** \n\nLicense : **" .. identity[2] .. "** \n\nCID/STATE ID : **" .. cid .. "**\n\nDiscord ID : **" .. pDiscord .. "**", 255)
        end
    end
end)


function sendToDiscord5(name, message, color)
    local connect = {
      {
        ["color"] = color,
        ["title"] = "**".. name .."**",
        ["description"] = message,
      }
    }
    PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end