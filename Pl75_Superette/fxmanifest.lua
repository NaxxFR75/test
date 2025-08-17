fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'LeDjo_Developpement'
description 'LeDjo_Developpement'
version '1.10.1'

client_scripts {
    'bridge/client.lua',
    'client/*.lua'
}

server_scripts {
    'bridge/server.lua',
    'server/*.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}