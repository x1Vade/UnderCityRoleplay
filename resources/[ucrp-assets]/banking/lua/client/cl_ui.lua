bMenuOpen = false 

ucrp-base = exports['ucrp-base']:GetCoreObject()
local isLoggedIn = false
local PlayerJob = {}
local PlayerGang = {}

RegisterNetEvent('ucrp-base:Client:OnPlayerLoaded', function()
    SendNUIMessage({type = "refresh_accounts"})
end)

RegisterNetEvent('ucrp-base:Client:OnPlayerUnload', function()
    SendNUIMessage({type = "refresh_accounts"})
end)

RegisterNetEvent('ucrp-base:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = ucrp-base.Functions.GetPlayerData().job
    PlayerGang = ucrp-base.Functions.GetPlayerData().gang
	PlayerJob = JobInfo
    SendNUIMessage({type = "refresh_accounts"})
end)

RegisterNetEvent('ucrp-base:Client:OnGangUpdate', function(GangInfo)
    PlayerJob = ucrp-base.Functions.GetPlayerData().job
    PlayerGang = ucrp-base.Functions.GetPlayerData().gang
    PlayerGang = GangInfo
    SendNUIMessage({type = "refresh_accounts"})
end)

function ToggleUI()
    local charinfo = ucrp-base.Functions.GetPlayerData().charinfo
    bMenuOpen = not bMenuOpen

    if (not bMenuOpen) then
        SetNuiFocus(false, false)
    else
        ucrp-base.Functions.TriggerCallback("banking:server:GetBankData", function(data, transactions)
            local PlayerBanks = json.encode(data)


            SetNuiFocus(true, true)
            SendNUIMessage({type = 'OpenUI', accounts = PlayerBanks, transactions = json.encode(transactions), name = charinfo.firstname.. " ".. charinfo.lastname})
        end)
    end
end

RegisterNUICallback("CloseATM", function()
    ToggleUI()
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

RegisterNUICallback("DepositCash", function(data, cb)
    if (not data or not data.account or not data.amount) then
        return
    end

    if (tonumber(data.amount) <= 0) then
        return
    end

    TriggerServerEvent("banking:server:Deposit", data.account, data.amount, (data.note ~= nil and data.note or ""))
end)

RegisterNUICallback("WithdrawCash", function(data, cb)
    if (not data or not data.account or not data.amount) then
        return
    end

    if(tonumber(data.amount) <= 0) then
        return
    end

    TriggerServerEvent("banking:server:Withdraw", data.account, data.amount, (data.note ~= nil and data.note or ""))
end)

RegisterNUICallback("TransferCash", function(data, cb)
    if (not data or not data.account or not data.amount or not data.target) then
        return
    end

    if(tonumber(data.amount) <= 0) then
        return
    end

    if(tonumber(data.target) <= 0) then
        return
    end

    TriggerServerEvent("banking:server:Transfer", data.target, data.account, data.amount, (data.note ~= nil and data.note or ""))
end)



--// Net Events \\--
RegisterNetEvent("banking:client:Notify")
AddEventHandler("banking:client:Notify", function(type, msg)
    if (bMenuOpen) then
        SendNUIMessage({type = 'notification', msg_type = type, message = msg})
    end
end)

RegisterNetEvent("banking:client:UpdateTransactions")
AddEventHandler("banking:client:UpdateTransactions", function(transactions)
    if (bMenuOpen) then

        SendNUIMessage({type = 'update_transactions', transactions = json.encode(transactions)})

        ucrp-base.Functions.TriggerCallback("banking:server:GetBankData", function(data, transactions)
            local PlayerBanks = json.encode(data)
            SendNUIMessage({type = "refresh_balances", accounts = PlayerBanks})
        end)
    end
end)
