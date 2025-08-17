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
local accueilzips = RageUI.CreateMenu('~b~zip', Config.pastouche) 
local sousacceil = RageUI.CreateSubMenu(accueilzips, '~b~Accueil', Config.pastouche)
accueilzips.Display.Header = true 
accueilzips.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function acczip() 
    if open then 
		open = false
		RageUI.Visible(accueilzips, false)
		return
	else
		open = true 
		RageUI.Visible(accueilzips, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(accueilzips, function()

        RageUI.Button("Appellé un zip", nil, {RightLabel = "→"}, not codesCooldown52 , {
            onSelected = function()
            codesCooldown52 = true 
        TriggerServerEvent('accueil:zip')
        ESX.ShowNotification('~g~Votre message a bien été envoyé aux membre des zip.')
        Citizen.SetTimeout(120000, function() codesCooldown52 = false end)
       end 
    })

    RageUI.Button("Informations Recrutement", nil, {RightLabel = "→"}, true , {
        onSelected = function()
          end
    }, sousacceil)  



    end)

    RageUI.IsVisible(sousacceil, function()

        RageUI.Separator('~b~Informations Recrutement zip')
        RageUI.Separator('↓')
        RageUI.Separator('~b~Recrutement ~g~ON')
        RageUI.Separator('~b~Plus d\'info sur le DarkWeb')
        

    end)
   
         
			
		Wait(0)
	   end
	end)
 end
end


local posaczip = {
	{x = 825.07373046875, y = -325.29028320312, z = 56.315811157227}
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(posaczip) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posaczip[k].x, posaczip[k].y, posaczip[k].z) 

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour parler à un ~b~zip", 1) 
                if IsControlJustPressed(1,51) then
                    acczip()
            end
    end
    Citizen.Wait(wait)
    end
end
end)

-- Peds   
  
local npczip = {
	{hash="g_m_y_mexgoon_01", x = 825.07373046875, y = -325.29028320312, z = 56.315811157227, a = 207.39205932617188},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npczip) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		pedzip = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(pedzip, true)
		FreezeEntityPosition(pedzip, true)
		SetEntityInvincible(pedzip, true)
	end
 end)  