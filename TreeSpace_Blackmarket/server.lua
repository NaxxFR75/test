ESX = exports["es_extended"].getSharedObject();

RegisterNetEvent("blackMarketgn:giveTools")
AddEventHandler("blackMarketgn:giveTools", function (type, toolname, toolprice)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if type == "weapons" then

    if xPlayer then 
        if xPlayer.getAccount(Config.MoneyType).money > tonumber(toolprice) then
            if Config.WeaponsItem then
                xPlayer.removeAccountMoney(Config.MoneyType, tonumber(toolprice))
                xPlayer.addInventoryItem(toolname, 1)
                TriggerClientEvent("esx:showNotification", source, "Vous avez acheté l'arme "..toolname, '#b19bd9')
            else
                xPlayer.removeAccountMoney(Config.MoneyType, tonumber(toolprice))
                xPlayer.addWeapon(toolname, 0)
                TriggerClientEvent("esx:showNotification", source, "Vous avez acheté l'arme "..toolname, '#b19bd9')
            end
        else
            TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez d'argent", '#b19bd9')
        end
    end
    else
        if xPlayer then 
            if xPlayer.getAccount(Config.MoneyType).money > tonumber(toolprice) then
                    xPlayer.removeAccountMoney(Config.MoneyType, tonumber(toolprice))
                    xPlayer.addInventoryItem(toolname, 1)
                    TriggerClientEvent("esx:showNotification", source, "Vous avez acheté l'item "..toolname, '#b19bd9')
            else
                TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez d'argent", '#b19bd9')
            end
        end
    end
end)

ESX.RegisterServerCallback("blackMarketgn:getBlackMoney", function(source, cb)
    local source = source

    local xPlayer = ESX.GetPlayerFromId(source)

    local blackMoneyPlayer = xPlayer.getAccount(Config.MoneyType).money

    cb(blackMoneyPlayer)
end)    