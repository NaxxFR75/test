RegisterNetEvent('treespacemaison:joinInstance')
AddEventHandler('treespacemaison:joinInstance', function(bucket)
    _source = source
    SetPlayerRoutingBucket(_source, bucket)
end)

RegisterNetEvent('treespacemaison:leaveInstance')
AddEventHandler('treespacemaison:leaveInstance', function()
    _source = source
    SetPlayerRoutingBucket(_source, 0)
end)

RegisterNetEvent('treespacemaison:stoleItems')
AddEventHandler('treespacemaison:stoleItems', function()
    _source = source
    if GetPlayerRoutingBucket(_source) ~= 0 then
        local items = math.random(1, 3) -- Quantités Items Recuperer    
        local chance = math.random(0, 100) -- Chance de looter des Items
        -- En DESSOUS Listes des items lootable dans le braquage
        if chance < 40 and exports.ox_inventory:CanCarryItem(_source, 'cola', items) then
            exports.ox_inventory:AddItem(_source, 'cola', items)
        elseif chance >= 40 and chance < 55 and exports.ox_inventory:CanCarryItem(_source, 'radio', 1) then
            exports.ox_inventory:AddItem(_source, 'radio', 1)
        elseif chance >= 55 and chance < 70 and exports.ox_inventory:CanCarryItem(_source, 'burger', items) then
            exports.ox_inventory:AddItem(_source, 'burger', items)
        elseif chance >= 70 and chance < 85 and exports.ox_inventory:CanCarryItem(_source, 'phone', 1) then
            exports.ox_inventory:AddItem(_source, 'phone', 1)
        elseif chance >= 85 and chance < 95 and exports.ox_inventory:CanCarryItem(_source, 'WEAPON_CROWBAR', 1) then
            exports.ox_inventory:AddItem(_source, 'WEAPON_CROWBAR', 1)
        elseif chance >= 99 and chance <= 100 and exports.ox_inventory:CanCarryItem(_source, 'WEAPON_PISTOL', 1) then
            exports.ox_inventory:AddItem(_source, 'WEAPON_PISTOL', 1)
        end
    else
        DropPlayer("bye cheater")
        TriggerServerEvent('treespace_cheater:Cheater', GetPlayerName(PlayerId()),amount)
		return
    end
end)

RegisterServerEvent('treespace_cheater:Cheater',function(player,distance)
    local license = "Unavailable"
    local discord = "Unavailable"
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discord = v
        end
    end
    local embed = {
        {
            ["color"] = 15548997,
            ["title"] = 'POSSIBLE CHEATER',
            ["description"] = 'Player ** ['..source..'] '..player..'** tried to use the trigger \nLicense: '..license..'\nDiscord: '..discord,
            ["footer"] = {
                ["text"] = "TreeSpace LOGS"
            }
        }
    }
    PerformHttpRequest("webhook", function(err, text, headers) end, "POST",json.encode({username = "treespace",embeds = embed,avatar_url = "https://discord.com/api/webhooks/1244607241110421555/JfMzrquNc5X001PMuMtNVmpPGgxZyM3xKKGyJYuzm0k7N7O0qNvpvaM2TLSEcq8X97eM"}),{["Content-Type"] = "application/json"})
end)

RegisterNetEvent('treespacemaison:removeLockpick')
AddEventHandler('treespacemaison:removeLockpick', function()
    _source = source
    exports.ox_inventory:RemoveItem(_source, 'lockpick', 1)
end)
