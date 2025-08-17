ESX = exports["es_extended"]:getSharedObject()

local ox_inventory              = exports.ox_inventory
local ox_target                 = exports.ox_target

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job = job
end)

function coffrezipfct()
	TriggerServerEvent('ox:loadStashes')
	ox_inventory:openInventory('stash', {id="zip", groups="zip"})
end
  
exports("coffrezipfct",coffrezipfct)

local position = {
    {x = 688.26007080078, y = -315.51519775391, z = 60.037418365479}
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'zip' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'zip' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
            DrawMarker(22, 687.91973876953,-315.52615356445,60.037418365479, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 3, 255, true, true, p19, true)  

        
            if dist <= 2.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour accéder au ~b~Coffre", 1) 
                if IsControlJustPressed(1,51) then
                  coffrezipfct() 
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


if Config.blipzip then
Citizen.CreateThread(function()
        local zipmap = AddBlipForCoord(740.58703613281,-284.99914550781,60.779235839844)
    
        SetBlipSprite(zipmap, 475)
        SetBlipColour(zipmap, 4)
        SetBlipScale(zipmap, 1.7)
        SetBlipAsShortRange(zipmap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Quartier Sensible - La Zip")
        EndTextCommandSetBlipName(zipmap)

end)
end

