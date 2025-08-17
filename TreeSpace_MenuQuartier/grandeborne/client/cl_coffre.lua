ESX = exports["es_extended"]:getSharedObject()

local ox_inventory              = exports.ox_inventory
local ox_target                 = exports.ox_target

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job = job
end)

function coffregrandebornefct()
	TriggerServerEvent('ox:loadStashes')
	ox_inventory:openInventory('stash', {id="grandeborne", groups="grandeborne"})
end
  
exports("coffregrandebornefct",coffregrandebornefct)

local position = {
  {x = 76.245346069336, y = 6500.5556640625, z = 31.544820785522}
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'grandeborne' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'grandeborne' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
            DrawMarker(22, 76.245346069336,6500.5556640625,31.544820785522, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 3, 255, true, true, p19, true)  

        
            if dist <= 2.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour accéder au ~b~Coffre", 1) 
                if IsControlJustPressed(1,51) then
                  coffregrandebornefct() 
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


if Config.blipgrandeborne then
Citizen.CreateThread(function()
        local grandebornemap = AddBlipForCoord(10.43528175354,6569.1752929688,32.079265594482)
    
        SetBlipSprite(grandebornemap, 475)
        SetBlipColour(grandebornemap, 4)
        SetBlipScale(grandebornemap, 1.7)
        SetBlipAsShortRange(grandebornemap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Quartier Sensible - Grande Borne")
        EndTextCommandSetBlipName(grandebornemap)

end)
end

