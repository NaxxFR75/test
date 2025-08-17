ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


--- MENU ---

local open = false 
local accueilsevrans = RageUI.CreateMenu('', 'Sevran') 
local sousacceil = RageUI.CreateSubMenu(accueilsevrans, '', Config.pastouche)
accueilsevrans.Display.Header = true 
accueilsevrans.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function accsevran() 
    if open then 
		open = false
		RageUI.Visible(accueilsevrans, false)
		return
	else
		open = true 
		RageUI.Visible(accueilsevrans, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(accueilsevrans, function()

        RageUI.Button("Appellé un sevran", nil, {RightLabel = "→"}, not codesCooldown52 , {
            onSelected = function()
            codesCooldown52 = true 
        TriggerServerEvent('accueil:sevran')
        ESX.ShowNotification('~g~Votre message a bien été envoyé aux membre des sevran.')
        Citizen.SetTimeout(120000, function() codesCooldown52 = false end)
       end 
    })

    RageUI.Button("Informations Recrutement", nil, {RightLabel = "→"}, true , {
        onSelected = function()
          end
    }, sousacceil)  



    end)

    RageUI.IsVisible(sousacceil, function()

        RageUI.Separator('~b~Informations Recrutement sevran')
        RageUI.Separator('↓')
        RageUI.Separator('~b~Recrutement ~g~ON')
        RageUI.Separator('~b~Plus d\'info sur le DarkWeb')
        

    end)
   
         
			
		Wait(0)
	   end
	end)
 end
end


local posacsevran = {
  {x = 1422.9290771484, y = -2578.7116699219, z = 48.03524017334}
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(posacsevran) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posacsevran[k].x, posacsevran[k].y, posacsevran[k].z) 

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour parler à un ~b~sevran", 1) 
                if IsControlJustPressed(1,51) then
                    accsevran()
            end
    end
    Citizen.Wait(wait)
    end
end
end)

-- Peds   
  
local npcsevran = {
	{hash="g_m_y_mexgoon_01", x = 1422.9213867188, y = -2578.7233886719, z = 48.045223236084, a = 353.199951171875},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npcsevran) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		pedsevran = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(pedsevran, true)
		FreezeEntityPosition(pedsevran, true)
		SetEntityInvincible(pedsevran, true)
	end
 end)  