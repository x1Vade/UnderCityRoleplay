local DISCORD_WEBHOOK5 = "https://discord.com/api/webhooks/836746872982601738/BYxxOyEvC2ZZmu6CDeO4nHkUTVxYC_azVzF6WBvMvlu3_BMzITwiKun2eytquVOVXODE"
local DISCORD_NAME5 = "Meth Selling Logs"

local STEAM_KEY = "0C007CC382AB06D1D99D9B45EC3924B1"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png" -- default is FiveM logo

PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

local cachedData = {}

RegisterServerEvent('meth:givemoney')
AddEventHandler('meth:givemoney', function(money)
    local source = source
    local player = GetPlayerName(source)
    local user = exports["ucrp-base"]:getModule("Player"):GetUser(source)
    if money ~= nil then
        user:addMoney(money) --- MintHavoc Change Banking
        if money > 300 then
        	sendToDiscord5("Meth Selling Logs", "Player ID: ".. source ..", Steam: ".. player ..",  Just Received $".. money .." From Selling Meth.")
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