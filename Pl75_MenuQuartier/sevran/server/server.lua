--ESX = nil
local playersHealing, deadPlayers = {}, {}

ESX = exports["es_extended"]:getSharedObject()

local stash = {
    id = "sevran",
    label = "sevran",
    slots = 25,
    weight = 75000,
    groups = "sevran"
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName ==
        GetCurrentResourceName() then
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots,
                                           stash.weight, stash.groups)
    end
end)

-- Coffre

ESX.RegisterServerCallback('yamssevran:playerinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	
	for k,v in pairs(items) do
		if v.count > 0 then
			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
		end
	end
	

	cb(all_items)

	
end)

ESX.RegisterServerCallback('yamssevran:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sevran', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

RegisterServerEvent('yamssevran:putStockItems')
AddEventHandler('yamssevran:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sevran', function(inventory)
		if item_in_inventory >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'en avez pas assez sur vous")
		end
	end)
end)

RegisterServerEvent('yamssevran:takeStockItems')
AddEventHandler('yamssevran:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sevran', function(inventory)
			xPlayer.addInventoryItem(itemName, count)
			inventory.removeItem(itemName, count)
	end)
end)


---

-- Peds sevran

RegisterServerEvent('accueil:sevran')
AddEventHandler('accueil:sevran', function()
    
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'sevran' or thePlayer.job2.name == 'sevran' then		
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'sevran', '~b~Appel', 'Un sevran est appelé au Quartier.', 'CHAR_BLANK_ENTRY', 8)
        end
    end
end)



RegisterNetEvent('yamsoo:achatsevran')
AddEventHandler('yamsoo:achatsevran', function(item, price)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addWeapon(item, 50)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)


RegisterNetEvent('recolteballe')
AddEventHandler('recolteballe', function()
    local item = "rope"
    local limiteitem = 400
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Vous avez pas assez de place dans votre inventaire!")
        recoltepossible = false
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
		return
    end
end)

RegisterNetEvent('recoltemetaux')
AddEventHandler('recoltemetaux', function()
    local item = "metaux"
    local limiteitem = 400
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Vous avez pas assez de place dans votre inventaire!")
        recoltepossible = false
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
		return
    end
end)

RegisterNetEvent('recoltemeche')
AddEventHandler('recoltemeche', function()
    local item = "meche"
    local limiteitem = 400
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Vous avez pas assez de place dans votre inventaire!")
        recoltepossible = false
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
		return
    end
end)

RegisterNetEvent('laxixpo:pain')
AddEventHandler('laxixpo:pain', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 6
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('pain_chaud', 1)
        TriggerClientEvent('esx:showNotification', source, "[~g~Achats~w~] effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('laxipara:glaces')
AddEventHandler('laxipara:glaces', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 4
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('glaces', 2)
        TriggerClientEvent('esx:showNotification', source, "[~g~Achats~w~] effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)