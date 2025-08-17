ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job = job
end)

local ox_inventory              = exports.ox_inventory
local ox_target                 = exports.ox_target

function coffregoutteorfct()
	TriggerServerEvent('ox:loadStashes')
	ox_inventory:openInventory('stash', {id="goutteor", groups="goutteor"})
end
  
exports("coffregoutteorfct",coffregoutteorfct)

local position = {
  {x = 7.132550239563, y = -1898.0572509766, z = 56.645629882812}
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'goutteor' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'goutteor' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
            DrawMarker(22, 7.132550239563,-1898.0572509766,56.645629882812, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 3, 255, true, true, p19, true)  

        
            if dist <= 2.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour accéder au ~b~Coffre", 1) 
                if IsControlJustPressed(1,51) then
                  coffregoutteorfct() 
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


if Config.blipgoutteor then
Citizen.CreateThread(function()
        local goutteormap = AddBlipForCoord(89.518753051758,-1982.0300292969,21.927164077759)
    
        SetBlipSprite(goutteormap, 475)
        SetBlipColour(goutteormap, 4)
        SetBlipScale(goutteormap, 1.7)
        SetBlipAsShortRange(goutteormap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Quartier Sensible - Goutte d'Or")
        EndTextCommandSetBlipName(goutteormap)

end)
end

