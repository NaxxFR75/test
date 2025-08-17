ESX = exports["es_extended"]:getSharedObject()

local ox_inventory              = exports.ox_inventory
local ox_target                 = exports.ox_target

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job = job
end)

function coffresevranfct()
	TriggerServerEvent('ox:loadStashes')
	ox_inventory:openInventory('stash', {id="sevran", groups="sevran"})
end
  
exports("coffresevranfct",coffresevranfct)

local position = {
  {x = 1497.3802490234, y = -2606.6743164062, z = 51.051029205322}
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sevran' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'sevran' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
            DrawMarker(22, 1497.380859375,-2606.6721191406,51.051025390625, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 3, 255, true, true, p19, true)  

        
            if dist <= 2.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour accéder au ~b~Coffre", 1) 
                if IsControlJustPressed(1,51) then
                  coffresevranfct() 
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


if Config.blipsevran then
Citizen.CreateThread(function()
        local sevranmap = AddBlipForCoord(1497.380859375,-2606.6721191406,51.051025390625)
    
        SetBlipSprite(sevranmap, 475)
        SetBlipColour(sevranmap, 4)
        SetBlipScale(sevranmap, 1.7)
        SetBlipAsShortRange(sevranmap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Quartier Sensible - Sevran")
        EndTextCommandSetBlipName(sevranmap)

end)
end

