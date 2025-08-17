fx_version 'cerulean'

game 'gta5'

author 'TreeSpace - Labo de Drogue'
description 'Labo de Drogue'

version '1.1'

lua54 'yes'

shared_scripts {
  '@ox_lib/init.lua',
  'shared/*.lua',
}

client_scripts {
  'client/*.lua',
}

server_scripts {
  'server/*.lua',
}

files {
  'locales/*.json'
}

escrow_ignore {
  'shared/*.lua',
  'client/*.lua',
  'server/*.lua',
}

dependency '/assetpacks'