RegisterServerEvent('ucrp-civjobs:errorlog')
AddEventHandler('ucrp-civjobs:errorlog', function(pErrorCode)
    local timeout = os.time()
    if (os.time() - timeout) < 5 then
        print(("[TIMEOUT] %s is spamming the event (%s)"):format(source, "ucrp-civjobs:errorlog"))
        timeout = os.time()
        return
    end
    if pErrorCode == 0x66 then
        exports["ucrp-log"]:AddLog("Civ Jobs", 
            source, 
            "Pressed Alt (KEY-19) while in Inventory trying to open menu", 
            { message = tostring(message) })
    end

    timeout = os.time()
    return
end)
