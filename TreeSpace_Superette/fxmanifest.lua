fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'VFRENCH V.2'
description 'VFRENCH V.2 - SUPERETTE ILLEGAL'
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