function Login.playerLoaded() end

function Login.characterLoaded()
  -- Main events leave alone 
  TriggerEvent("ucrp-base:playerSpawned")
  TriggerEvent("playerSpawned")
  TriggerServerEvent('character:loadspawns')
  TriggerEvent("ucrp-base:initialSpawnModelLoaded")
  -- Main events leave alone 

  -- Everything that should trigger on character load 
  TriggerServerEvent('checkTypes')
  TriggerServerEvent('isVip')
  TriggerEvent("fx:clear")
  TriggerEvent('ucrp-bankrobbery:client:CreateTrollysEvent')
  TriggerServerEvent("currentconvictions")
  TriggerServerEvent("Evidence:checkDna")
  TriggerEvent("banking:viewBalance")
  TriggerServerEvent('ucrp-doors:requestlatest')
  TriggerServerEvent("item:UpdateItemWeight")
  TriggerServerEvent("ReturnHouseKeys")
  TriggerServerEvent("requestOffices")
  Wait(500)
  TriggerServerEvent("police:getAnimData")
  TriggerServerEvent("server:currentpasses")
  TriggerServerEvent("police:getEmoteData")
  TriggerServerEvent("police:SetMeta")
  TriggerServerEvent('ucrp-scoreboard:AddPlayer')
  TriggerServerEvent("ucrp-base:PolyZoneUpdate")

  -- TriggerServerEvent("weapon:general:check")
  -- Anything that might need to wait for the client to get information, do it here.
  TriggerServerEvent("login:get:keys")
  TriggerServerEvent("raid_clothes:retrieve_tats")
  TriggerServerEvent("ucrp-weapons:getAmmo")
  Wait(4000)
  TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))	
  TriggerServerEvent("bank:getLogs")
  TriggerEvent('ucrp-hud:EnableHud', true)
end

function Login.characterSpawned()

  isNear = false
  TriggerServerEvent('ucrp-base:sv:player_control')
  TriggerServerEvent('ucrp-base:sv:player_settings')
  TriggerEvent("spawning", false)
  TriggerEvent("attachWeapons")
  TriggerServerEvent("request-dropped-items")
  TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))

  if Spawn.isNew then
      Wait(1000)
      if not exports["ucrp-inventory"]:hasEnoughOfItem("mobilephone", 1, false) then
          TriggerEvent("player:receiveItem", "mobilephone", 1)
      end
      if not exports["ucrp-inventory"]:hasEnoughOfItem("idcard", 1, false) then
          TriggerEvent("player:receiveItem", "idcard", 1)
      end
      if not exports["ucrp-inventory"]:hasEnoughOfItem("lockpick", 2, false) then
        TriggerEvent("player:receiveItem", "lockpick", 2)
      end
      if not exports["ucrp-inventory"]:hasEnoughOfItem("sandwich", 3, false) then
        TriggerEvent("player:receiveItem", "sandwich", 3)
      end
      if not exports["ucrp-inventory"]:hasEnoughOfItem("water", 3, false) then
        TriggerEvent("player:receiveItem", "water", 3)
      end
      if not exports["ucrp-inventory"]:hasEnoughOfItem("repairkit", 1, false) then
        TriggerEvent("player:receiveItem", "repairkit", 1)
      end


      -- commands to make sure player is alive and full food/water/health/no injuries
      local src = GetPlayerServerId(PlayerId())
      TriggerServerEvent("reviveGranted", src)
      TriggerEvent("Hospital:HealInjuries", src, true)
      TriggerServerEvent("ems:healplayer", src)
      TriggerEvent("heal", src)
      TriggerEvent("status:needs:restore", src) 

      TriggerServerEvent("ucrp-spawn:newPlayerFullySpawned")
  end
  SetPedMaxHealth(PlayerPedId(), 200)
  --SetPlayerMaxArmour(PlayerId(), 100) -- This is setting players armor on relog??
  runGameplay() -- moved from ucrp-base 
  Spawn.isNew = false
end
RegisterNetEvent("ucrp-spawn:characterSpawned");
AddEventHandler("ucrp-spawn:characterSpawned", Login.characterSpawned);
