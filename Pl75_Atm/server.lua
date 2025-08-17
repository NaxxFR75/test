ESX = exports['es_extended']:getSharedObject()
RSE = RegisterServerEvent
AEH = AddEventHandler
RSC = ESX.RegisterServerCallback

local lastrob = 0

RSC('ledjo-atmheist:PoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' or player['job']['name'] == 'gendarmerie' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config.RequiredCops then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('esx:showNotification', source, 'Manque d’agents en service!')
    end
end)

RSC('ledjo-atmheist:CheckTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastrob) < Config.Cooldown and lastrob ~= 0 then
        local seconds = Config.Cooldown - (os.time() - lastrob)
        TriggerClientEvent('esx:showNotification', source, 'Un braquage a deja était fait ressèment !')
        cb(false)
    else
        lastrob = os.time()
      --  exports['ledjo-logs']:SendLog(source, 'Il a commencé à voler un guichet automatique!', 'crime')
        cb(true)
    end
end)

RSE('ledjo-atmheist:Reward')
AEH('ledjo-atmheist:Reward', function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local random = math.random(Config.MinReward, Config.MaxReward)
    if type == 'full' then
    xPlayer.addInventoryItem('black_money', random)
    elseif type == 'half' then
        xPlayer.addInventoryItem('black_money', random / 2)
    end
end)