local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/988818673672265779/vAFet0LmJ6A_44hrfmf6yxcVVdq0Yik5bFsMSo_g6ySilFTblBQayAuwMc-4SqMe34aE"

RegisterServerEvent('send')
AddEventHandler('send', function(data)
    local pName = GetPlayerName(source)
    local connect = {
        {
            ["color"] = "255",
            ["title"] = "Bug Report - ".. pName,
            ["description"] = "Title: \n\n `"..data.title.."` \n\n━━━━━━━━━━━━━━━━━━\n\n Description: \n\n `"..data.description.."` \n\n━━━━━━━━━━━━━━━━━━\n\n VOD / Clip / Screenshot URLs: \n\n `"..data.url.."` \n\n━━━━━━━━━━━━━━━━━━\n\n",
	        ["footer"] = {
            },
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = "Bug Reports",  avatar_url = "https://cdn1.iconfinder.com/data/icons/ios-11-glyphs/30/error-512.png",embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

