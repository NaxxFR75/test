local animation = false
robbedHouses = {}
robbedItems = {}
CreateThread(function()
    for k,v in pairs(Config.Interiors) do
        exports.ox_target:addBoxZone({
            coords = v.Door,
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = false,
            options = {
                {
                    name = 'box',
                    event = 'joinInstance',
                    args = {v.Bucket, v.Interior, v.Objects, k},
                    icon = 'fas fa-home',
                    label = 'Braquer La Maison',
                }
            }
        })
        exports.ox_target:addBoxZone({
            coords = v.Interior,
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = false,
            options = {
                {
                    name = 'box',
                    event = 'leaveInstance',
                    args = {v.Door, v.Objects},
                    icon = 'fas fa-home',
                    label = 'Sortir de La Maison'
                }
            }
        })
    end
end)

AddEventHandler('stoleItems', function(data)
    if data == nil then return end
    if robbedItems[data.args] == nil then
        animation = true
        robbedItems[data.args] = data.args
        StartLockpicking()
        lib.progressBar({
            duration = 10000,
            label = 'Tu voles des choses...',
            useWhileDead = false,
            canCancel = false,
            disable = {
                move = true,
                car = true,
                combat = true
            },
        })
        TriggerServerEvent('ledjomaison:stoleItems')
        animation = false
    else
        lib.notify({
            title = 'Combriolage',
            description = 'Vous avez déjà volé cette propriété',
            type = 'error'
        })
    end
end)

AddEventHandler('joinInstance', function(data)
    if data == nil then return end
    if exports.ox_inventory:Search('count', 'lockpick') > 0 and robbedHouses[data.args[4]] == nil then 
        robbedHouses[data.args[4]] = data.args[4]
        TriggerServerEvent('ledjomaison:removeLockpick')
        local playerPed = PlayerPedId()
        animation = true
        local success = exports['lockpick']:startLockpick()
        if success then
            lib.notify({
                title = 'Combriolage',
                description = 'Tu as réussi à crocheter la porte',
                type = 'success'
            })
            lib.progressBar({
                duration = 10000,
                label = 'Vous entrez par effraction...',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    move = true,
                    car = true,
                    combat = true
                },
                anim = {
                    dict = 'missheistfbisetup1',
                    clip = 'hassle_intro_loop_f' 
                },
            })
            local coords = GetEntityCoords(GetPlayerPed(-1))
                local HouseRobbery = {
                    code = "Alerte Combriolage",
                    street = exports['LeDjo_Dispatch']:GetStreetAndZone(),
                    id = exports['LeDjo_Dispatch']:randomId(),
                    priority = 1,
                    title = "Braquage De Maison",
                    duration = 25000,
                    blipname = "# Braquage De Maison",
                    color = 2,
                    sprite = 304,
                    fadeOut = 30,
                    position = {
                        x = coords.x,
                        y = coords.y,
                        z = coords.z
                    },
                    job = {
                        "police",
                        "gendarmerie"
                    }
                   
                }
                TriggerServerEvent("dispatch:svNotify", HouseRobbery)
            alarm = math.random(0,100)
            if alarm < 30 then
                lib.notify({
                    title = 'Combriolage',
                    description = 'Alarm off',
                    type = 'error'
                })
            end
            DoScreenFadeOut(500)
            Wait(500)
            TriggerServerEvent('ledjomaison:joinInstance', data.args[1])
            ESX.Game.Teleport(playerPed, data.args[2])
            Wait(500)
            DoScreenFadeIn(1000)
            for _,l in pairs(data.args[3]) do
                exports.ox_target:addModel(l, {
                    {
                        name = _,
                        icon = "fas fa-credit-card",
                        label = "Voler",
                        event = "stoleItems",
                        args = _,
                        canInteract = function(entity, coords, distance)
                            return true
                        end,
                    },
                })
            end
        else
            lib.progressBar({
                duration = 10000,
                label = 'Vous être entrain de voler',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    move = true,
                    car = true,
                    combat = true
                },
                anim = {
                    dict = 'missheistfbisetup1',
                    clip = 'hassle_intro_loop_f' 
                },
            })
            lib.notify({
                title = 'Combriolage',
                description = 'Tu as cassé la boîte du bijoutier',
                type = 'error'
            })
        end
        animation = false
        SetTimeout(3600000, function()
            robbedHouses[data.args[4]] = nil
        end)
    elseif exports.ox_inventory:Search('count', 'lockpick') < 1 then
        lib.notify({
            title = 'Combriolage',
            description = 'Tu n\'as pas de crochet',
            type = 'error'
        })
    elseif robbedHouses[data.args[4]] == nil then
        lib.notify({
            title = 'Combriolage',
            description = 'Vous avez déjà volé/tenté de cambrioler cette maison',
            type = 'error'
        })
    end
end)

AddEventHandler('leaveInstance', function(data)
    if data == nil then return end
    DoScreenFadeOut(500)
    Wait(500)
    TriggerServerEvent('ledjomaison:leaveInstance')
    ESX.Game.Teleport(PlayerPedId(), data.args[1])
    Wait(500)
    DoScreenFadeIn(1000)
    for _,l in pairs(data.args[2]) do
        exports.ox_target:removeModel(l, _)
        robbedItems[_] = nil
    end
    robbedItems = {}
end)

function StartLockpicking()
    CreateThread(function()
        local lib, anim = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer'
        while animation do
            Wait(0)
            local playerPed = PlayerPedId()
            SetCurrentPedWeapon(playerPed, 'WEAPON_UNARMED')
            if IsEntityPlayingAnim(playerPed, lib, anim, 3) ~= 1 then
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 31, 0, false, false, false)
                end)
            end
        end
        local playerPed = PlayerPedId()
        StopAnimTask(playerPed, lib, anim, 1.0)
    end)
end