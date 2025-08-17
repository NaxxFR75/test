ESX = exports['es_extended']:getSharedObject()
RNE = RegisterNetEvent
AEH = AddEventHandler
TSE = TriggerServerEvent

exports.qtarget:AddTargetModel({'prop_atm_03', 'prop_fleeca_atm', 'prop_atm_01', 'prop_atm_02'}, {
	options = {
        {
            action = function()
                if crowbar() then
                    TriggerEvent('treespace-atmheist:StartDestroy')
                end
            end,
			icon = "fas fa-hammer",
			label = "Braquer L\'Atm",
            item = 'WEAPON_CROWBAR'
		},
	},
	distance = 2
})

RNE('treespace-atmheist:StartHack')
AEH('treespace-atmheist:StartHack', function()
    ESX.TriggerServerCallback('treespace-atmheist:PoliceCount', function(status)
        if status then
            ESX.TriggerServerCallback('treespace-atmheist:CheckTime', function(time)
                if time then
                    local coords = GetEntityCoords(GetPlayerPed(-1))
                    local ATMRobbery = {
                        code = "Alerte ATM",
                        street = exports['LeDjo_Dispatch']:GetStreetAndZone(),
                        id = exports['LeDjo_Dispatch']:randomId(),
                        priority = 1,
                        title = "Vol Guichet automatique",
                        duration = 5500,
                        blipname = "# Vol Guichet automatique",
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
                        },
                    } 
                    TriggerServerEvent("dispatch:svNotify", ATMRobbery)
                    exports['ledjo_lib']:Thermite(function(success)
                        if success then
                            if lib.progressBar({
                                duration = 17000,
                                label = 'Collecte de fonds...',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    car = true,
                                    move = true,
                                    combat = true,
                                },
                                anim = {
                                    dict = 'oddjobs@shop_robbery@rob_till',
                                    clip = 'loop', 
                                }
                            }) then
                                TSE('treespace-atmheist:Reward', 'full')
                            else
                                TSE('treespace-atmheist:Reward', 'half')
                                ESX.ShowNotification('Vous n’avez pas réussi à collecter tout l’argent!')
                            end
                        else
                            ESX.ShowNotification('Vous n’avez pas réussi!')
                        end
                    end, 10, 5, 3)
                end
            end)
        end
    end)
end)

RNE('treespace-atmheist:StartDestroy')
AEH('treespace-atmheist:StartDestroy', function()
    ESX.TriggerServerCallback('treespace-atmheist:PoliceCount', function(status)
        if status then
            ESX.TriggerServerCallback('treespace-atmheist:CheckTime', function(time)
                if time then
                    local coords = GetEntityCoords(GetPlayerPed(-1))
                    local ATMRobbery = {
                        code = "Alerte ATM",
                        street = exports['LeDjo_Dispatch']:GetStreetAndZone(),
                        id = exports['LeDjo_Dispatch']:randomId(),
                        priority = 1,
                        title = "Vol Guichet automatique",
                        duration = 5500,
                        blipname = "# Vol Guichet automatique",
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
                        },
                    }
                    TriggerServerEvent("dispatch:svNotify", ATMRobbery)
                    if lib.progressBar({
                        duration = 12000,
                        label = 'Briser un guichet automatique...',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                            move = true,
                            combat = true,
                        },
                        anim = {
                            dict = "melee@large_wpn@streamed_core",
                            clip = "ground_attack_on_spot",
                            flags = 49,
                        }
                    }) then
                        if lib.progressBar({
                            duration = 13000,
                            label = 'Collecte de fonds...',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                                combat = true,
                            },
                            anim = {
                                dict = 'oddjobs@shop_robbery@rob_till',
                                clip = 'loop', 
                            }
                        }) then
                            TSE('treespace-atmheist:Reward', 'full')
                        end
                    end
                end
            end)
        end
    end)
end)

function crowbar()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.Weapon) do
        if pedWeapon == k then
            return true
        end
    end

    ESX.ShowNotification('Vous devez tenir un pied-de-biche dans votre main!')
end
