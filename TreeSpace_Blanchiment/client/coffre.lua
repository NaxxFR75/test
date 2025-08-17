ESX = exports["es_extended"]:getSharedObject()

local ox_inventory              = exports.ox_inventory
local ox_target                 = exports.ox_target


function odfpsdfsdfd()
	TriggerServerEvent('ox:loadStashes')
	ox_inventory:openInventory('stash', {id="blanchi", groups="blanchi"})
end
  
exports("odfpsdfsdfd",odfpsdfsdfd)


local position = {
    {x = 582.27752685547, y = -3114.9362792969, z = 6.0692591667175}
}


Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'blanchi' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 2.5 then
            wait = 0
            DrawMarker(22, 582.27752685547,-3114.9362792969,6.0692591667175, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 56, 119, 166, 255, true, true, p19, true) 

            if dist <= 2.5 then
               wait = 0
               ESX.ShowHelpNotification("[~b~E~w~] pour accéder au coffre")
                if IsControlJustPressed(1,51) then
					odfpsdfsdfd()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)
