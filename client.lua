local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


ESX = nil
local PlayerData = {}
local yap = false
local yazi = false


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

local SekretneHaslo = "a" 
local Ticariarac = 'rumpo3'



local Zakupiono = 0
local acildi = 0
local drivingStyle = 786603
local spawnRadius = 160
local timer = 0
local zrespione = 0
local wybieranie = false






--00000000000000000000000000000000000000000000000000000000000000000000-----
-- function satinalMenu()
satinalMenu = function()
    local player = PlayerPedId()
    FreezeEntityPosition(player,true)
    
    local elements = {
        { label = "Satın al", action = "Satis_Buy_Menu" },	}
        
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_Satis_main_menu",
        {
            title    = "Black Karavan",
            align    = "top-left",
            elements = elements
        },
    function(data, menu)
        local action = data.current.action

        if action == "Satis_Buy_Menu" then
            SatinAlmaMenu()
        elseif action == "PawnShop_Sell_Menu" then
            Kapat()
        end	
    end, function(data, menu)
        menu.close()
        insideMarker = false
        FreezeEntityPosition(player,false)
    end, function(data, menu)
    end)
end

function SatinAlmaMenu()
    local player = PlayerPedId()
    FreezeEntityPosition(player,true)
    local elements = {}
            
    for k,v in pairs(Config.Satis) do
        if v.BuyInPawnShop == true then
            table.insert(elements,{label = v.label .. " | "..('<span style="color:green;">%s</span>'):format("$"..v.BuyPrice..""), itemName = v.itemName, BuyInPawnShop = v.BuyInPawnShop, BuyPrice = v.BuyPrice})
        end
    end
        
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "PrisonBuyMenu",
        {
            title    = "Ne almak istiyorsun?",
            align    = "top-left",
            elements = elements
        },
    function(data, menu)
            if data.current.itemName == data.current.itemName then
                OpenBuyDialogMenu(data.current.itemName,data.current.BuyPrice)
            end	
    end, function(data, menu)
        menu.close()
        insideMarker = false
        FreezeEntityPosition(player,false)
    end, function(data, menu)
    end)
end

function OpenBuyDialogMenu(itemName, BuyPrice)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'PrisonDialog', {
		title = "Satın Alacak Miktar?"
	}, function(data, menu)
		menu.close()
		amountToBuy = tonumber(data.value)
		totalBuyPrice = (BuyPrice * amountToBuy)
		TriggerServerEvent("rpv-blackmarket:BuyItem",amountToBuy,totalBuyPrice,itemName)
	end,
	function(data, menu)
		menu.close()	
	end)
end


function Soru()
  ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),'Menu',{title='Dostum parolayı hatırlıyorsun değil mi?'},
    function(a,b)b.close()
      local player = PlayerPedId()


      if a.value=='siktir'or a.value=='annen'or a.value=='amk'then 
        -- ESX.ShowAdvancedNotification('Handlarz','Połączenie','O ty kurwo obrzydliwa pożałujesz tego.','CHAR_BLANK_ENTRY',1)
        TriggerEvent('notification', 'KİŞİ :: Dostum kelimerine dikkat etsen iyi olacak gibi.', 2)
        -- ClearPedTasksImmediately(PlayerPedId())
        ClearPedTasks(PlayerPedId())

        print(PlayerPedId())

      print('chat masse')
        return 
      end
      if a.value==SekretneHaslo then
        -- ESX.ShowAdvancedNotification('Handlarz','Połączenie','Dobra, widze wiesz o co chodzi. Mam już twój GPS nie ruszaj się zaraz tam podjadę.','CHAR_BLANK_ENTRY',1)
        TriggerEvent('notification', 'KİŞİ :: Tamamdır patron! Yoldayım geliyorum konumundan ayrılma!.', 3)
        NPColustur()
        -- ClearPedTasksImmediately(PlayerPedId())
        ClearPedTasks(PlayerPedId())

      else
        -- ESX.ShowAdvancedNotification('Handlarz','Połączenie','Sory nie wiem o czym mówisz, nie dzwoń więcej pod ten numer.','CHAR_BLANK_ENTRY',1)
        TriggerEvent('notification', 'KİŞİ :: Neyden bahsettiğini anlamadım, bir daha arama.', 2)
        Citizen.Wait(500)
      -- ClearPedTasksImmediately(PlayerPedId())
      ClearPedTasks(PlayerPedId())

        end 
      end,
    function(a,b)b.close()
  end)
end

RegisterNetEvent('rpv-blackmarket:hedef')
AddEventHandler('rpv-blackmarket:hedef', function()
NPColustur()
end)


-- RegisterCommand('hedef', function()
--   NPColustur()
--   print('Hedef yola çıktı')
--   TriggerEvent('chat:addMessage', -1, {
--     template = '<div class="chat-message durum"><b>BLACKMARKET STATUS :</b> Komut devreye girdi</div>',
--     args = { user, msg }
-- })
-- end)

function NPColustur()
  player=GetPlayerPed(-1)
  playerPos=GetEntityCoords(player)
  local a=GetHashKey('a_m_m_farmer_01')
  RequestModel(a)
  local b=GetHashKey(Ticariarac)
  RequestModel(b)
  while not HasModelLoaded(a)and RequestModel(a)or not HasModelLoaded(b)and RequestModel(b)do RequestModel(a)
    RequestModel(b)
    Citizen.Wait(0)
  end
  Spawncar(playerPos.x,playerPos.y,playerPos.x,b,a)
  Hedef(playerPos.x,playerPos.y,playerPos.z,towTruck,towTruckDriver,b,targetVeh)
end

function Spawncar(a,b,c,d,e)
  local f,g,h=GetClosestVehicleNodeWithHeading(a+math.random(-spawnRadius,spawnRadius),b+math.random(-spawnRadius,spawnRadius),c,0,3,0)
  if f and HasModelLoaded(d)and HasModelLoaded(d)then 
    zrespione=1
    towTruck=CreateVehicle(d,g,h,true,false)ClearAreaOfVehicles(GetEntityCoords(towTruck),5000,false,false,false,false,false)
    SetVehicleOnGroundProperly(towTruck)
    SetVehicleColours(towTruck,111,111)
    towTruckDriver=CreatePedInsideVehicle(towTruck,26,e,-1,true,false)
    towTruckDriver2=CreatePedInsideVehicle(towTruck,25,e,-1,true,false)
    SetEntityInvincible(towTruckDriver,true)
    SetBlockingOfNonTemporaryEvents(towTruckDriver,true)
    towTruckBlip=AddBlipForEntity(towTruck)
    GetVehicleDoorLockStatus(towTruck, 2)
    SetBlipFlashes(towTruckBlip,true)
    SetBlipColour(towTruckBlip,22)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Arac')
    EndTextCommandSetBlipName(towTruckBlip)
  end 
end


function Aracsil(a,b)
  SetEntityAsMissionEntity(a,false,false)
  DeleteEntity(a)
  SetEntityAsMissionEntity(b,false,false)
  DeleteEntity(b)
  RemoveBlip(towTruckBlip)
end

function Hedef(a,b,c,d,e,f,g)
  TaskVehicleDriveToCoord(e,d,a,b,c,10.0,0,f,drivingStyle,1,true)
  enroute=true 
  while enroute==true do 
    Citizen.Wait(500)
    dist=GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),GetEntityCoords(d).x,GetEntityCoords(d).y,GetEntityCoords(d).z,false)
    if dist<15 then 
      StartVehicleHorn(d,5000,GetHashKey("HELDDDOWN"),false)
      TaskVehicleTempAction(e,d,27,-1)
      -- SetVehicleDoorOpen(d,2,false,false)
      -- SetVehicleDoorOpen(d,3,false,false)
      SetVehicleDoorOpen(d,5,false,false)
      GetVehicleDoorsLockedForPlayer(towTruck)

      RemoveBlip(towTruckBlip)
      timer=20
      enroute=false
      -- ESX.ShowAdvancedNotification('Handlarz','Mówi','Masz '..math.floor(timer)..' sekund, po tym czasie zawijam biznes.','CHAR_BLANK_ENTRY',1)
      TriggerEvent('notification', 'KİŞİ :: ' ..math.floor(timer).. ' saniye sonra buradan ayrılacağım.', 2)
      Last()
      Citizen.Wait(math.floor(timer))
      SetVehicleDoorShut(d,5,false,false)
    elseif dist<20 then
       Citizen.Wait(2000)
      end 
    end 
  end

  function Last()
    local a,b,c=table.unpack(GetOffsetFromEntityInWorldCoords(towTruck,0.0,-3.3,-1.0))
    wybieranie=true
    while wybieranie do 
      Citizen.Wait(2)
      local a,b,c=table.unpack(GetOffsetFromEntityInWorldCoords(towTruck,0.0,-3.3,-1.0))
      DrawMarker(20,a,b,c,0,0,0,0,0,0,1.0,2.3,1.0,0,205,50,100,9,0,0,0)
      -- DrawMarker(20, a, b, Olay.z-0.90, 0, 0, 0, 0, 0, 0, 1.301, 1.3001, 1.3001, 0, 205, 250, 200, 0, 0, 0, 0) 
      local d=GetEntityCoords(GetPlayerPed(-1),false)
      local e=Vdist(d.x,d.y,d.z,a,b,c)
      if e<=1 then 
        -- DrawText3D(a,b,c+1,'~y~[E]~w~  Erişmek için')
        if IsControlJustPressed(0,Keys['E'])then 
        satinalMenu()
      end 
    end 
  end 
  end


Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(500)
    if acildi==1 then 
      if IsPedStill(GetPlayerPed(-1))then
       else
         ESX.UI.Menu.CloseAll()
         acildi=0 
        end 
      end
      if timer>=1 then
        if zrespione==1 then
           timer=timer-0.5
           if timer<=1 then
             wybieranie=false
             zrespione=0
             TaskVehicleDriveWander(towTruckDriver,towTruck,50.0,drivingStyle)
             SetVehicleDoorShut(towTruck,2,false)
             SetVehicleDoorShut(towTruck,3,false)
             GetVehicleDoorsLockedForPlayer(towTruck)

             timer=0
            --  ESX.ShowAdvancedNotification('Handlarz','Mówi','Dobra czas na mnie, zawijam stąd zanim pojawi się policja.','CHAR_BLANK_ENTRY',1)
             TriggerEvent('notification', 'KİŞİ :: Başka zaman görüşürüz, zamanım doldu. CYAA!!', 2)
             Citizen.Wait(60000)
             Aracsil(towTruck,towTruckDriver)
            end 
          end 
        end 
      end 
    end)


function loadAnimDict(a)
  while not HasAnimDictLoaded(a)do 
    RequestAnimDict(a)
    Citizen.Wait(0)
  end 
end





























-- RegisterNetEvent('rpv-blackmarket:Weaponksmı')
-- AddEventHandler('rpv-blackmarket:Weaponkısmı',function(a)
--   GiveWeaponToPed(GetPlayerPed(-1),GetHashKey(a),100,false,true)
--   Citizen.Wait(500)
-- end)


RegisterNetEvent('rpv-blackmarket:Erisim')
AddEventHandler('rpv-blackmarket:Erisim',function()
  if zrespione==0 then
  else
    -- ESX.ShowAdvancedNotification('Handlarz','Połączenie','Co dzwonisz przecie już jade!','CHAR_BLANK_ENTRY',1)
    TriggerEvent('notification', 'KİŞİ :: Başka zaman görüşürüz, zamanım doldu. CYAA!!', 2)
    return
  end
  -- ESX.ShowAdvancedNotification('Handlarz','Połączenie','Skąd masz ten numer? Powiedz mi czego oczekujesz?','CHAR_BLANK_ENTRY',1)
  TriggerEvent('notification', 'KİŞİ :: Bu numarayı nereden aldın? Benden ne istiyorsun,  söyle?', 2)

  Citizen.Wait(500)
  Soru()
end)

function DrawText3D(a,b,c,d)
  local e,f,g=World3dToScreen2d(a,b,c)
  local h,i,j=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35,0.35)
  SetTextFont(4)
  SetTextProportional(3)
  SetTextColour(255,255,255,215)
  SetTextEntry("STRING")
  SetTextCentre(2)
  AddTextComponentString(d)
  DrawText(f,g)
  local k=string.len(d)/370
  DrawRect(f,g+0.0125,0.015+k,0.03,41,11,41,90)
end



--===============================================================================

--          npc

--===============================================================================
-- local saticicoords = {x = -755.91, y = -619.8, z = 30.28, h = 2.13} 
-- local rnd = 0

local saticicoords = {
  [1] =  { ['x'] = -755.91,['y'] = -619.8,['z'] = 30.28,['h'] = 2.13},
  [2] =  { ['x'] = -758.4,['y'] = -617.99,['z'] = 30.28,['h'] = 2.13},
  [3] =  { ['x'] = -72.75,['y'] = 1900.5,['z'] = 196.6,['h'] = 279.67},
  [4]  = { ['x'] = 1206.7,['y'] = 1857.45,['z'] = 78.92,['h'] = 50.28},
  [5]  = { ['x'] = 1588.27,['y'] = -1833.63,['z'] = 94.74,['h'] = 146.45},
  [6]  = { ['x'] = 773.93,['y'] = 2707.33,['z'] = 39.98,['h'] = 181.86},
  -- [5] =  { ['x'] = -758.4,['y'] = -617.99,['z'] = 30.28,['h'] = 2.13},

}




local keypressed = false
local rnd = 0

Citizen.CreateThread(function()
  while true do
    local player = PlayerPedId()
    local tasking = true
    local yazi = true


      Citizen.Wait(0)
      rnd = math.random(1,#saticicoords)
          local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
          local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z ,saticicoords[rnd]["x"],saticicoords[rnd]["y"],saticicoords[rnd]["z"])
        -- print(#saticicoords)
    if dist <= 25000.0  then
      if not DoesEntityExist(dealer) then
      RequestModel("mp_m_execpa_01") 
      while not HasModelLoaded("mp_m_execpa_01") do
        Wait(10)
      end

        dealer = CreatePed(26, "mp_m_execpa_01", saticicoords[rnd]["x"],saticicoords[rnd]["y"],saticicoords[rnd]["z"], saticicoords[rnd]["h"], 0, 0)
        ClearPedTasks(dealer)
        ClearPedSecondaryTask(dealer)
        TaskSetBlockingOfNonTemporaryEvents(dealer, true)
        SetPedFleeAttributes(dealer, 0, 0)
        SetPedCombatAttributes(dealer, 17, 1)
        TaskTurnPedToFaceEntity(dealer, PlayerPedId(), 1.0)
        TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false)
        print(' ilk konum ; Ped ısınlandı')
        print(saticicoords[rnd]["x"],saticicoords[rnd]["y"],saticicoords[rnd]["z"])
      end
    end
    
          if dist < 0.6 then
              local crds = GetEntityCoords(dealer)
              if yazi == true then
              DrawText3D(crds["x"],crds["y"],crds["z"], "[E]")

              if IsControlJustPressed(0, Keys['E']) then
                yazi = false
              -- end
             
                -- DrawText3D(crds["x"],crds["y"],crds["z"], "[E]")
                keypressed = true
                
                PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
                Citizen.Wait(150)
                TriggerEvent('notification', 'KİŞİ :: Al bu telefon numarası, ara adamı.', 3)
                Citizen.Wait(500)


                Soru()
              Wait(150000)
              SetEntityCoords(dealer, saticicoords[rnd]["x"],saticicoords[rnd]["y"],saticicoords[rnd]["z"], xAxis, yAxis, zAxis, clearArea)  
              print(' Sornaki konum  ; Ped ısınlandı')
              print(saticicoords[rnd]["x"],saticicoords[rnd]["y"],saticicoords[rnd]["z"])

                Wait(100)
              end
           end
        end
    end
end)




function DeleteCreatedPed()
	-- print("Ped siliniyor mu?")
	if DoesEntityExist(dealer) then 
		SetPedKeepTask(dealer, false)
		TaskSetBlockingOfNonTemporaryEvents(dealer, false)
		ClearPedTasks(dealer)
		TaskWanderStandard(dealer, 10.0, 10)
		SetPedAsNoLongerNeeded(dealer)

		Citizen.Wait(20000)
		DeletePed(dealer)
	end
end










