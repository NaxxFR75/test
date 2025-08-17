ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    CreateBlipsse()	
	Citizen.Wait(5000)
end)

--- Récolte de la Weed ---

local open = false 
local mainMenu = RageUI.CreateMenu("", "")
mainMenu.Display.Header = true 
mainMenu.Closed = function()
    open = false
end


function OpenMenuRecolte()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
			RageUI.IsVisible(mainMenu,function() 

				RageUI.Separator("Un nouveau ? : ~b~"..GetPlayerName(PlayerId()))
				RageUI.Separator("Récolte de corde")

			RageUI.Button("Commencer la Récolte", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					FreezeEntityPosition(PlayerPedId(), true)
					StartRecolte()
				end
			})

			RageUI.Button("Stopper la Récolte", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					FreezeEntityPosition(PlayerPedId(), false)
					StopRecolte()
				end
			})

			end)
		Wait(0)
		end
	end)
  	end
end

--- FUNCTION RECOLTE ---
function StopRecolte()
    if recoltepossible then
    	recoltepossible = false
    end
end

function StartRecolte()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Citizen.Wait(2000)
        TriggerServerEvent('recolteballe')
    end
    else
        recoltepossible = false
    end
end

----OUVRIR LE MENU------------
local position = {
	{x = 1678.576171875, y = 4881.1215820312, z = 42.043670654297}
}


Citizen.CreateThread(function()
    while true do
        local wait = 1000

        for k in pairs(position) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
           local dst = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

           if dst <= 2.0 then
            wait = 0
			DrawMarker(6, 1678.576171875,4881.1215820312,42.043670654297-0.99, 0.0, 0.0, 0.0, -90,0.0,0.0, 1.0, 1.0, 1.0, 104, 155, 237, 255, false, false, p19, false) 
        end
            if dst <= 3.0 then
                wait = 0
				ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à la farm")
                if IsControlJustPressed(1,51) then
                    OpenMenuRecolte()
                end
            end
        end
        Wait(wait)
    end
end)


--- Récolte de la Jsp ---

local open = false 
local mainMenu = RageUI.CreateMenu("", "")
mainMenu.Display.Header = true 
mainMenu.Closed = function()
    open = false
end


function OpenMenuRecolteqdz()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
			RageUI.IsVisible(mainMenu,function() 

				RageUI.Separator("Un nouveau ? : ~b~"..GetPlayerName(PlayerId()))
				RageUI.Separator("Récolte de métaux")

			RageUI.Button("Commencer la Récolte", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					FreezeEntityPosition(PlayerPedId(), true)
					StartRecolte()
				end
			})

			RageUI.Button("Stopper la Récolte", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					FreezeEntityPosition(PlayerPedId(), false)
					StopRecolte()
				end
			})

			end)
		Wait(0)
		end
	end)
  	end
end

function StartRecolte()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Citizen.Wait(2000)
        TriggerServerEvent('recoltemetaux')
    end
    else
        recoltepossible = false
    end
end

----OUVRIR LE MENU------------
local position = {
	{x = 749.43701171875, y = 4184.6352539062, z = 41.087738037109}
}


Citizen.CreateThread(function()
    while true do
        local wait = 1000

        for k in pairs(position) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
           local dst = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

           if dst <= 2.0 then
            wait = 0
			DrawMarker(6, 749.44122314453,4184.6318359375,41.087841033936-0.99, 0.0, 0.0, 0.0, -90,0.0,0.0, 1.0, 1.0, 1.0, 104, 155, 237, 255, false, false, p19, false) 
        end
            if dst <= 3.0 then
                wait = 0
				ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à la farm")
                if IsControlJustPressed(1,51) then
                    OpenMenuRecolte()
                end
            end
        end
        Wait(wait)
    end
end)

--- Récolte de la meche ---

local open = false 
local mainMenu = RageUI.CreateMenu("", "")
mainMenu.Display.Header = true 
mainMenu.Closed = function()
    open = false
end



function OpenMenuRecoltemeche()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
			RageUI.IsVisible(mainMenu,function() 

				RageUI.Separator("Un nouveau ? : ~b~"..GetPlayerName(PlayerId()))
				RageUI.Separator("Récolte de mèche")

			RageUI.Button("Commencer la Récolte", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					FreezeEntityPosition(PlayerPedId(), true)
					StartRecolte()
				end
			})

			RageUI.Button("Stopper la Récolte", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					FreezeEntityPosition(PlayerPedId(), false)
					StopRecolte()
				end
			})

			end)
		Wait(0)
		end
	end)
  	end
end

function StartRecolte()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Citizen.Wait(2000)
        TriggerServerEvent('recoltemeche')
    end
    else
        recoltepossible = false
    end
end

----OUVRIR LE MENU------------
local position = {
	{x = -69.576789855957, y = 6262.2055664062, z = 31.090126037598}
}

Citizen.CreateThread(function()
    while true do
        local wait = 1000

        for k in pairs(position) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
           local dst = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

           if dst <= 2.0 then
            wait = 0
			DrawMarker(6, -69.576789855957,6262.2055664062,31.090126037598-0.99, 0.0, 0.0, 0.0, -90,0.0,0.0, 1.0, 1.0, 1.0, 104, 155, 237, 255, false, false, p19, false) 
        end
            if dst <= 3.0 then
                wait = 0
				ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à la farm")
                if IsControlJustPressed(1,51) then
                    OpenMenuRecolte()
                end
            end
        end
        Wait(wait)
    end
end)

--- Récolte de la meche ---

local open = false 
local mainMenu = RageUI.CreateMenu("", "")
mainMenu.Display.Header = true 
mainMenu.Closed = function()
    open = false
end



function OpenMenuAccueilmarie()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
			RageUI.IsVisible(mainMenu,function() 

				RageUI.Separator("Un nouveau ? : ~b~"..GetPlayerName(PlayerId()))
				RageUI.Separator("Récolte de pain chaud (KFC)")

				RageUI.Button("~b~Acheter~s~ x1 Pain Chaud", nil, {RightLabel = "6€"}, not codesCooldown5 , {
					onSelected = function()
					TriggerServerEvent('laxixpo:pain')	
				Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
			   end 
			})

			RageUI.Separator("Récolte de glaçon (PARADISE)")

			RageUI.Button("~b~Acheter~s~ x2 Glaçon", nil, {RightLabel = "4€"}, not codesCooldown5 , {
				onSelected = function()
				TriggerServerEvent('laxipara:glaces')	
			Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
		   end 
		})

			end)
		Wait(0)
		end
	end)
  	end
end

function StartRecolte()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Citizen.Wait(2000)
        TriggerServerEvent('recoltepain')
    end
    else
        recoltepossible = false
    end
end

----OUVRIR LE MENU------------
local position = {
	{x = 180.11758422852, y = 2793.3896484375, z = 45.65518951416}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'xpo' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 2.0 then
            wait = 0
			DrawMarker(6, 180.11758422852,2793.3896484375,45.65518951416-0.99, 0.0, 0.0, 0.0, -90,0.0,0.0, 1.0, 1.0, 1.0, 104, 155, 237, 255, false, false, p19, false) 

        
            if dist <= 1.0 then
               wait = 0
               ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au achat")
                if IsControlJustPressed(1,51) then
                    OpenMenuAccueilmarie()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

function CreateBlipsse()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'xpo' then

		if BlipCloakRoom == nil then
			BlipCloakRoom = AddBlipForCoord(180.50555419922,2793.2958984375,45.65523147583)
			SetBlipSprite(BlipCloakRoom, 478)
			SetBlipColour(BlipCloakRoom, 21)
			SetBlipAsShortRange(BlipCloakRoom, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Récolte - Pain chaud (KFC) / (PARADISE)')
			EndTextCommandSetBlipName(BlipCloakRoom)
	  end	
	else

        if BlipCloakRoom ~= nil then
            RemoveBlip(BlipCloakRoom)
            BlipCloakRoom = nil
        end
	end
 end