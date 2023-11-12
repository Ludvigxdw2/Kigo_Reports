fx_version "cerulean"
game "gta5"
lua54 'yes'


name 'Kigo_Reports'
author 'Gamer12351'
description 'Reports System'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    "@ox_lib/init.lua",
    'shared/*.lua',
}

client_scripts {
    "client/*.lua"
}
server_scripts {
    "server/*.lua"
}

dependency "ox_lib"