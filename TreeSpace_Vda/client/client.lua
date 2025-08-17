local dragStatus = {}
local IsHandcuffed = false
dragStatus.isDragged = false
local PlayerData, GUI, CurrentActionData, JobBlips = {}, {}, {}, {}
local publicBlip = false
local ox_inventory              = exports.ox_inventory
local ox_target                 = exports.ox_target


ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        ESX = exports["es_extended"]:getSharedObject()
        Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)


-------garage

garagebrrr = false

RMenu.Add('garage', 'main', RageUI.CreateMenu("Garage", " "))
RMenu:Get('garage', 'main').Closed = function()
    garagebrrr = false
end

function garageenos()
    if not garagebrrr then
        garagebrrr = true
        RageUI.Visible(RMenu:Get('garage', 'main'), true)
    while garagebrrr do
        RageUI.IsVisible(RMenu:Get('garage', 'main'), true, true, true, function() 
            RageUI.ButtonWithStyle("Ranger la voiture", "Pour ranger une voiture.", {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if dist4 < 4 then
                TriggerServerEvent('ddx_vehiclelock:deletekeyjobs', 'no')
                DeleteEntity(veh)
                end 
            end
        end) 
        RageUI.ButtonWithStyle("Baller", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Wait(1)  
            spawnCar('baller6')
            end
        end)
        RageUI.ButtonWithStyle("Manchez", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Wait(1)  
            spawnCar('manchez')
            end
        end)
        RageUI.ButtonWithStyle("Contender Max 4X4", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Wait(1)  
            spawnCar('contender')
            end
        end)
        RageUI.ButtonWithStyle("Cognoscenti", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Wait(1)  
            spawnCar("cognoscenti")
            end
        end)
        end, function()
        end)
        Wait(0)
        end
    else
    garagebrrr = false
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.garage.position.x, Config.pos.garage.position.y, Config.pos.garage.position.z)
                if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dzmafia' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'dzmafia' then 
                if dist3 <= 15.0 then
                DrawMarker(6,  Config.pos.garage.position.x, Config.pos.garage.position.y, Config.pos.garage.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 155)
                end
                if dist3 <= 3.0 then  
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                if IsControlJustPressed(1,51) then           
                    garageenos()
                end   
            end
        end 
    end
end)

function spawnCar(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.spawn.spawnvoiture.position.x, Config.spawn.spawnvoiture.position.y, Config.spawn.spawnvoiture.position.z, Config.spawn.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleMaxMods(vehicle)
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1) 
    TriggerServerEvent('ddx_vehiclelock:givekey', 'no', GetVehicleNumberPlateText(vehicle))
end

function SetVehicleMaxMods(vehicle)
    local props = {
      modEngine       = 2,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    }
    ESX.Game.SetVehicleProperties(vehicle, props)
    SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
    SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
  end

--coffre

function odfpsdfsdf()
	TriggerServerEvent('ox:loadStashes')
	ox_inventory:openInventory('stash', {id="dzmafia", groups="dzmafia"})
end
  
exports("odfpsdfsdf",odfpsdfsdf)

Citizen.CreateThread(function()
        while true do
            Wait(0)
                local plycrdjob = GetEntityCoords(PlayerPedId(), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.coffre.position.x, Config.pos.coffre.position.y, Config.pos.coffre.position.z)
                if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dzmafia' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'dzmafia' then 
                    if jobdist <= 15.0 then
                        DrawMarker(6,  Config.pos.coffre.position.x, Config.pos.coffre.position.y, Config.pos.coffre.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 155)
                    end
            if jobdist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au coffre")
                    if IsControlJustPressed(1,51) then
                        odfpsdfsdf()
                    end   
                end
            end 
        end
end)

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Wait(1)
		end
		RemoveAnimDict(dictname)
	end
end
local colorVar = "~o~"
local PlyID = PlayerPedId()
local Items = {}      -- Item que le joueur possède (se remplit lors d'une fouille)
local Armes = {}    -- Armes que le joueur possède (se remplit lors d'une fouille)
local ArgentSale = {}  -- Argent sale que le joueur possède (se remplit lors d'une fouille)
local IsHandcuffed, DragStatus = false, {}
DragStatus.IsDragged          = false
local PlayerData = {}
local function MarquerJoueur()
	local ped = GetPlayerPed(ESX.Game.GetClosestPlayer())
	local pos = GetEntityCoords(ped)
	local target, distance = ESX.Game.GetClosestPlayer()
	if distance <= 4.0 then
	DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 0, 1, 2, 1, nil, nil, 0)
end
end
local function getPlayerInv(player)
Items = {}
Armes = {}
ArgentSale = {}

ESX.TriggerServerCallback('dzmafia:getOtherPlayerData', function(data)
	for i=1, #data.accounts, 1 do
		if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
			table.insert(ArgentSale, {
				label    = ESX.Math.Round(data.accounts[i].money),
				value    = 'black_money',
				itemType = 'item_account',
				amount   = data.accounts[i].money
			})

			break
		end
	end

	for i=1, #data.weapons, 1 do
		table.insert(Armes, {
			label    = ESX.GetWeaponLabel(data.weapons[i].name),
			value    = data.weapons[i].name,
			right    = data.weapons[i].ammo,
			itemType = 'item_weapon',
			amount   = data.weapons[i].ammo
		})
	end

	for i=1, #data.inventory, 1 do
		if data.inventory[i].count > 0 then
			table.insert(Items, {
				label    = data.inventory[i].label,
				right    = data.inventory[i].count,
				value    = data.inventory[i].name,
				itemType = 'item_standard',
				amount   = data.inventory[i].count
			})
		end
	end
end, GetPlayerServerId(player))
end

menuf7tahbg = false
RMenu.Add('vendeurf6', 'main', RageUI.CreateMenu("Mafia", "Intéraction"))
RMenu.Add('vendeurf6', 'fouiller', RageUI.CreateMenu("Mafia", "Intéraction"))
RMenu:Get('vendeurf6', 'main').Closed = function()
    menuf7tahbg = false
end

function menuf7()
    if not menuf7tahbg then
        menuf7tahbg = true
        RageUI.Visible(RMenu:Get('vendeurf6', 'main'), true)
    while menuf7tahbg do
        RageUI.IsVisible(RMenu:Get('vendeurf6', 'main'), true, true, true, function()
        	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			RageUI.ButtonWithStyle('Fouiller la personne', nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, function(_, a, s)
				if a then
					MarquerJoueur()
					if s then
					getPlayerInv(closestPlayer)
					ExecuteCommand("me fouille l'individu")
				end
			end
			end, RMenu:Get('vendeurf6', 'fouiller'))  
            RageUI.ButtonWithStyle("Menotter/démenotter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(PlayerPedId())
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(PlayerPedId())
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then 
                    TriggerServerEvent('enos:handcuff', GetPlayerServerId(closestPlayer))
                else
                    RageUI.Popup({message = "Personne autour"})
                end
                end
            end)
            RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(PlayerPedId())
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(PlayerPedId())
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('enos:drag', GetPlayerServerId(closestPlayer))
            else
                RageUI.Popup({message = "Personne autour"})
            end
            end
        end)
            RageUI.ButtonWithStyle("Mettre dans un véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(PlayerPedId())
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(PlayerPedId())
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('enos:putInVehicle', GetPlayerServerId(closestPlayer))
            else
                RageUI.Popup({message = "Personne autour"})
            end
                end
            end)
            RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
					playerheading = GetEntityHeading(PlayerPedId())
					playerlocation = GetEntityForwardVector(PlayerPedId())
					playerCoords = GetEntityCoords(PlayerPedId())
					local target_id = GetPlayerServerId(target)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent('enos:OutVehicle', GetPlayerServerId(closestPlayer))
            else
                RageUI.Popup({message = "Personne autour"})
            end
            end
        end)
        RageUI.ButtonWithStyle("Crocheter le véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			if Selected then
				local playerPed = PlayerPedId()
				local vehicle = ESX.Game.GetVehicleInDirection()
				local coords = GetEntityCoords(playerPed)
				if IsPedSittingInAnyVehicle(playerPed) then
                    RageUI.Popup({message = "Vous ne pouvez pas faire ça à l'interieur du véhicule"})
					return
				end
				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
					Citizen.CreateThread(function()
						Wait(10000)
						SetVehicleDoorsLocked(vehicle, 1)
						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
						ClearPedTasksImmediately(playerPed)
                        RageUI.Popup({message = "~g~Véhicule Unlocked"})
						isBusy = false
					end)
				else
                    RageUI.Popup({message = "Aucun véhicule proche"})
				end
			end
		end)
        end, function()
        end)
        RageUI.IsVisible(RMenu:Get("vendeurf6",'fouiller'),true,true,true,function() -- Le menu de fouille (inspiré du pz_core / Modifié)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            RageUI.Separator("↓ ~g~Argent Sale ~s~↓")
            for k,v  in pairs(ArgentSale) do
                RageUI.ButtonWithStyle("Argent sale :", nil, {RightLabel = "~g~"..v.label.."$"}, true, function(_, _, s)
                    if s then
                        local combien = KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "Quantité invalide"})
                        else
                            TriggerServerEvent('enos:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end
            RageUI.Separator("↓ ~g~Objets ~s~↓")
            for k,v  in pairs(Items) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~x"..v.right}, true, function(_, _, s)
                    if s then
                        local combien = KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "Quantité invalide"})
                        else
                            TriggerServerEvent('enos:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end
                RageUI.Separator("↓ ~g~Armes ~s~↓")
                for k,v  in pairs(Armes) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "avec ~g~"..v.right.. " ~s~balle(s)"}, true, function(_, _, s)
                        if s then
                            local combien = KeyboardInput("Combien ?", '' , '', 8)
                            if tonumber(combien) > v.amount then
                                RageUI.Popup({message = "Quantité invalide"})
                            else
                                TriggerServerEvent('enos:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                            end
                            RageUI.GoBack()
                        end
                    end)
                end
            end, function() 
            end)
            Wait(0)
        end
    else
        menuf7tahbg = false
    end
end
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'dzmafia' then 
            if IsControlJustPressed(0, 168) then
                menuf7()
            end
        end 
    end
end)
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Wait(500) 
        blockinput = false
        return result 
    else
        Wait(500) 
        blockinput = false 
        return nil 
    end
end
RegisterNetEvent('enos:handcuff')
AddEventHandler('enos:handcuff', function()
  IsHandcuffed    = not IsHandcuffed;
  local playerPed = PlayerPedId()
  Citizen.CreateThread(function()
    if IsHandcuffed then
        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Wait(100)
        end
      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      DisableControlAction(2, 37, true)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 257, true) -- Attack 2
      DisableControlAction(0, 25, true) -- Aim
      DisableControlAction(0, 263, true) -- Melee Attack 1
      DisableControlAction(0, 37, true) -- Select Weapon
      DisableControlAction(0, 47, true)  -- Disable weapon
      DisplayRadar(false)
    else
      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)
      DisplayRadar(true)
    end
  end)
end)
RegisterNetEvent('enos:drag')
AddEventHandler('enos:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = PlayerPedId()
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(PlayerPedId(), true, false)
      end
    end
  end
end)
RegisterNetEvent('enos:putInVehicle')
AddEventHandler('enos:putInVehicle', function()
  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)
  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)
    if DoesEntityExist(vehicle) then
      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil
      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end
      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end
    end
  end
end)
RegisterNetEvent('enos:OutVehicle')
AddEventHandler('enos:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(PlayerPedId(),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2
  SetEntityCoords(PlayerPedId(), xnew, ynew, plyPos.z)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

RegisterNetEvent('esx_clip:clipcli')
AddEventHandler('esx_clip:clipcli', function()
  ped = PlayerPedId()
  if IsPedArmed(ped, 4) then
    hash=GetSelectedPedWeapon(ped)
    if hash~=nil then
      TriggerServerEvent('esx_clip:remove')
      AddAmmoToPed(PlayerPedId(), hash,25)
      RageUI.Popup({message = "Chargeur utilisé"})
    else
        RageUI.Popup({message = "Tu n'a pas d'arme en main"})
    end
  else
    RageUI.Popup({message = "Ce type de munision ne convient pas"})
  end
end)




function RefreshvendeurMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyvendeurMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyvendeurMoney(money)
    societyvendeurmoney2 = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'dzmafia', function(data, menu)
        menu.close()
    end, {wash = false})
end

local playerPed = PlayerPedId()

dansmenu = false

local recoltebb = false
RMenu.Add('recoltebb', 'main', RageUI.CreateMenu("~b~Récolte", ""))
RMenu:Get('recoltebb', 'main'):SetSubtitle("~b~Mafia")

RMenu:Get('recoltebb', 'main').EnableMouse = false
RMenu:Get('recoltebb', 'main').Closed = function()
	dansmenu = false
	recoltebb = false
	TriggerServerEvent('stop:farm')
	FreezeEntityPosition(playerPed, false)
end

function recoltem()
	if not recoltebb then
		recoltebb = true
		RageUI.Visible(RMenu:Get('recoltebb', 'main'), true)
	Citizen.CreateThread(function()
		while recoltebb do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('recoltebb', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Récolter des métaux", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Récolter des métaux", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farm1')
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.farm.metaux.position.x, Config.farm.metaux.position.y, Config.farm.metaux.position.z)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dzmafia' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'dzmafia' then 
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.farm.metaux.position.x, Config.farm.metaux.position.y, Config.farm.metaux.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 120)
            end
            if dist3 <= 1.0 then   
                RageUI.Text({ message = "Appuyez sur ~b~E~s~ pour interagir", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                recoltem()
                end   
            end
        end 
    end
end)

local recolteaa = false
RMenu.Add('recolteaa', 'main', RageUI.CreateMenu("~b~Récolte", ""))
RMenu:Get('recolteaa', 'main'):SetSubtitle("~b~Mafia")

RMenu:Get('recolteaa', 'main').EnableMouse = false
RMenu:Get('recolteaa', 'main').Closed = function()
	dansmenu = false
	recolteaa = false
	TriggerServerEvent('stop:farm')
	FreezeEntityPosition(playerPed, false)
end

function recoltemeche()
	if not recolteaa then
		recolteaa = true
		RageUI.Visible(RMenu:Get('recolteaa', 'main'), true)
	Citizen.CreateThread(function()
		while recolteaa do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('recolteaa', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Récolter des mèches", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Récolter des mèches", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farm2')
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.farm.meche.position.x, Config.farm.meche.position.y, Config.farm.meche.position.z)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dzmafia' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'dzmafia' then 
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.farm.meche.position.x, Config.farm.meche.position.y, Config.farm.meche.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 120)
            end
            if dist3 <= 1.0 then   
                RageUI.Text({ message = "Appuyez sur ~b~E~s~ pour interagir", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                recoltemeche()
                end   
            end
        end 
    end
end)

local recoltecc = false
RMenu.Add('recoltecc', 'main', RageUI.CreateMenu("~b~Récolte", ""))
RMenu:Get('recoltecc', 'main'):SetSubtitle("~b~Mafia")

RMenu:Get('recoltecc', 'main').EnableMouse = false
RMenu:Get('recoltecc', 'main').Closed = function()
	dansmenu = false
	recoltecc = false
	TriggerServerEvent('stop:farm')
	FreezeEntityPosition(playerPed, false)
end

function recoltecanon()
	if not recoltecc then
		recoltecc = true
		RageUI.Visible(RMenu:Get('recoltecc', 'main'), true)
	Citizen.CreateThread(function()
		while recoltecc do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('recoltecc', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Récolter des canons", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Récolter des canons", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farmC')
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.farm.canon.position.x, Config.farm.canon.position.y, Config.farm.canon.position.z)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dzmafia' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'dzmafia' then 
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.farm.canon.position.x, Config.farm.canon.position.y, Config.farm.canon.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 120)
            end
            if dist3 <= 1.0 then   
                RageUI.Text({ message = "Appuyez sur ~b~E~s~ pour interagir", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                recoltecanon()
                end   
            end
        end 
    end
end)

local recoltedefou = false
RMenu.Add('recoltedefou', 'main', RageUI.CreateMenu("~b~Récolte", ""))
RMenu:Get('recoltedefou', 'main'):SetSubtitle("~b~Mafia")

RMenu:Get('recoltedefou', 'main').EnableMouse = false
RMenu:Get('recoltedefou', 'main').Closed = function()
	dansmenu = false
	recoltedefou = false
	TriggerServerEvent('stop:farm')
	FreezeEntityPosition(playerPed, false)
end

function recoltelevier()
	if not recoltedefou then
		recoltedefou = true
		RageUI.Visible(RMenu:Get('recoltedefou', 'main'), true)
	Citizen.CreateThread(function()
		while recoltedefou do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('recoltedefou', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Récolter des levier", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Récolter des levier", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true
							TriggerServerEvent('start:farm4')
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.farm.levier.position.x, Config.farm.levier.position.y, Config.farm.levier.position.z)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'dzmafia' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'dzmafia' then 
            if dist3 <= 15.0 then
                DrawMarker(6,  Config.farm.levier.position.x, Config.farm.levier.position.y, Config.farm.levier.position.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 120)
            end
            if dist3 <= 1.0 then   
                RageUI.Text({ message = "Appuyez sur ~b~E~s~ pour interagir", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                recoltelevier()
                end   
            end
        end 
    end
end)
