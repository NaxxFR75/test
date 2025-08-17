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
local accueilgrandebornes = RageUI.CreateMenu('~b~Gande Borne', Config.pastouche) 
local sousacceil = RageUI.CreateSubMenu(accueilgrandebornes, '~b~Accueil', Config.pastouche)
accueilgrandebornes.Display.Header = true 
accueilgrandebornes.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function accgrandeborne() 
    if open then 
		open = false
		RageUI.Visible(accueilgrandebornes, false)
		return
	else
		open = true 
		RageUI.Visible(accueilgrandebornes, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(accueilgrandebornes, function()

        RageUI.Button("Appeller un Grande Borne", nil, {RightLabel = "→"}, not codesCooldown52 , {
            onSelected = function()
            codesCooldown52 = true 
        TriggerServerEvent('accueil:grandeborne')
        ESX.ShowNotification('~g~Votre message a bien été envoyé aux membres des Grande Borne.')
        Citizen.SetTimeout(120000, function() codesCooldown52 = false end)
       end 
    })

    RageUI.Button("Informations Recrutement", nil, {RightLabel = "→"}, true , {
        onSelected = function()
          end
    }, sousacceil)  



    end)

    RageUI.IsVisible(sousacceil, function()

        RageUI.Separator('~b~Informations Recrutement Grande Borne')
        RageUI.Separator('↓')
        RageUI.Separator('~b~Recrutement ~g~ON')
        RageUI.Separator('~b~Plus d\'info sur le DarkWeb')
        

    end)
   
         
			
		Wait(0)
	   end
	end)
 end
end


local posacgrandeborne = {
  {x = 119.07194519043, y = 6541.6484375, z = 31.544836044312}
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(posacgrandeborne) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posacgrandeborne[k].x, posacgrandeborne[k].y, posacgrandeborne[k].z) 

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour parler à un ~b~Grande Borne", 1) 
                if IsControlJustPressed(1,51) then
                    accgrandeborne()
            end
    end
    Citizen.Wait(wait)
    end
end
end)

-- Peds   
  
local npcgrandeborne = {
	{hash="g_m_y_mexgoon_01", x = 119.07174682617, y = 6541.6484375, z = 31.544836044312, a = 335.0488891601563},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npcgrandeborne) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		pedgrandeborne = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(pedgrandeborne, true)
		FreezeEntityPosition(pedgrandeborne, true)
		SetEntityInvincible(pedgrandeborne, true)
	end
 end)  