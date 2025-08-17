ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job = job
end)


--- MENU ---

local open = false 
local accueilgoutteors = RageUI.CreateMenu('~b~goutteor', Config.pastouche) 
local sousacceil = RageUI.CreateSubMenu(accueilgoutteors, '~b~Accueil', Config.pastouche)
accueilgoutteors.Display.Header = true 
accueilgoutteors.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function accgoutteor() 
    if open then 
		open = false
		RageUI.Visible(accueilgoutteors, false)
		return
	else
		open = true 
		RageUI.Visible(accueilgoutteors, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(accueilgoutteors, function()

        RageUI.Button("Appellé un goutteor", nil, {RightLabel = "→"}, not codesCooldown52 , {
            onSelected = function()
            codesCooldown52 = true 
        TriggerServerEvent('accueil:goutteor')
        ESX.ShowNotification('~g~Votre message a bien été envoyé aux membre des goutteor.')
        Citizen.SetTimeout(120000, function() codesCooldown52 = false end)
       end 
    })

    RageUI.Button("Informations Recrutement", nil, {RightLabel = "→"}, true , {
        onSelected = function()
          end
    }, sousacceil)  



    end)

    RageUI.IsVisible(sousacceil, function()

        RageUI.Separator('~b~Informations Recrutement goutteor')
        RageUI.Separator('↓')
        RageUI.Separator('~b~Recrutement ~g~ON')
        RageUI.Separator('~b~Plus d\'info sur le DarkWeb')
        

    end)
   
         
			
		Wait(0)
	   end
	end)
 end
end


local posacgoutteor = {
	{x = 73.812393188477, y = -1905.1564941406, z = 21.555570602417}
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(posacgoutteor) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posacgoutteor[k].x, posacgoutteor[k].y, posacgoutteor[k].z) 

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour parler à un ~b~goutteor", 1) 
                if IsControlJustPressed(1,51) then
                    accgoutteor()
            end
    end
    Citizen.Wait(wait)
    end
end
end)

-- Peds   
  
local npcgoutteor = {
	{hash="g_m_y_mexgoon_01", x = 73.811950683594, y = -1905.1564941406, z = 21.555833816528, a = 82.59762573242188},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npcgoutteor) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		pedgoutteor = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(pedgoutteor, true)
		FreezeEntityPosition(pedgoutteor, true)
		SetEntityInvincible(pedgoutteor, true)
	end
 end)  