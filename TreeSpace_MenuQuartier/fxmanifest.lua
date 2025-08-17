fx_version 'adamant'
game 'gta5'


client_scripts {
    "src2/RMenu.lua",
    "src2/menu/RageUI.lua",
    "src2/menu/Menu.lua",
    "src2/menu/MenuController.lua",
    "src2/components/*.lua",
    "src2/menu/elements/*.lua",
    "src2/menu/items/*.lua",
    "src2/menu/panels/*.lua",
    "src2/menu/panels/*.lua",
    "src2/menu/windows/*.lua"
}

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua"
}

client_scripts {
    'menu/client/*lua',
    'goutteor/client/*.lua',
    'zip/client/*.lua',
    'sevran/client/*.lua',
    'grandeborne/client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'goutteor/server/*.lua', 
    'menu/server/*lua',
    'zip/server/*.lua',     
    'sevran/server/*.lua',  
    'grandeborne/server/*.lua'    
}

shared_scripts {
    'config.lua',
    'configmenu.lua'
}
