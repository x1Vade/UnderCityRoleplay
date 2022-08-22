RegisterUICallback("ucrp-ui:getLoans", function(data, cb)
    if data.type == "business" then
        local success, message = RPC.execute("GetLoansByBusinessId", data.id)
        cb({ data = message, meta = { ok = success, message = message } })
    elseif data.type == "state" then
        local success, message = RPC.execute("GetLoansByState")
        cb({ data = message, meta = { ok = success, message = message } })
    else
        local success, message = RPC.execute("GetLoansByCharacterId", data.id)
        cb({ data = message, meta = { ok = success, message = message } })
    end
end)

RegisterUICallback("ucrp-ui:loanOffer", function(data, cb)
    RPC.execute("LoanOffer", data)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
end)

RegisterUICallback("ucrp-ui:loanAccept", function(data, cb)
    local success, message = RPC.execute("LoanAccept", data)
    cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:loanPayment", function(data, cb)
    local success, message = RPC.execute("LoanPayment", data)
    cb({ data = message, meta = { ok = success, message = message } })
end)

RegisterUICallback("ucrp-ui:loanPaymentState", function(data, cb)
    local success, message = RPC.execute("LoanStatePayment", data)
    cb({ data = message, meta = { ok = success, message = "done" } })
end)

RegisterUICallback("ucrp-ui:getLoanConfig", function(data, cb)
    local stateInterest, maxRate = RPC.execute("GetStateInterestRate")
    local data = {
        ["state_interest"] = stateInterest,
        ["max_interest_rate"] = maxRate,
    }
    cb({ data = data, meta = { ok = true, message = "done" } })
end)

RegisterNetEvent("loans:loanAcceptPrompt")
AddEventHandler("loans:loanAcceptPrompt", function(data)
  SendUIMessage({
    source = "ucrp-nui",
    app = "phone",
    data = {
      action = "loan-offer",
      data = data,
    },
  })
end)
