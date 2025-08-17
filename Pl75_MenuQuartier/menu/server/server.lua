ESX = nil
local playersHealing, deadPlayers = {}, {}

ESX = exports["es_extended"]:getSharedObject()


RegisterServerEvent('policejob:mettremenotte')
AddEventHandler('policejob:mettremenotte', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
    TriggerClientEvent('policejob:mettreM', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('policejob:animarrest', _source)
end)

RegisterServerEvent('policejob:enlevermenotte')
AddEventHandler('policejob:enlevermenotte', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
    TriggerClientEvent('policejob:enleverM', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('policejob:animenlevermenottes', _source)
end)

RegisterServerEvent('policejob:drag')
AddEventHandler('policejob:drag', function(target)
	local _source = source
	TriggerClientEvent('policejob:drag1', target, _source)
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job2.name ~= 'unemployed2' then
		TriggerClientEvent('esx_policejob:putInVehicle', target)
	else
        --
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job2.name ~= 'unemployed2' then
		TriggerClientEvent('esx_policejob:OutVehicle', target)
	else
        --
	end
end)

RegisterServerEvent('policejob:mettremenottenofreeze')
AddEventHandler('policejob:mettremenottenofreeze', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
    TriggerClientEvent('policejob:mettreMnofreeze', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('policejob:animarrest', _source)
end)
