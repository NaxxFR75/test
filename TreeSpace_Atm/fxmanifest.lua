fx_version 'adamant'
game 'gta5'
lua54 'yes'
version '1.10.1'
author "TreeSpace"
description "ATM - OX"

client_script 'client.lua'
server_script 'server.lua'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua'
}
