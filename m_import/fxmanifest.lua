fx_version 'cerulean'
game 'gta5'
author 'SrDiablo'
description 'Vehiculos de importación basado en NoPixel'
version '0.0.1'
lua54 'yes'


server_scripts {'server/*.lua'}

client_scripts {
    'client/*.lua', 
    'config.lua'
}

shared_script {
    'shared/functions.lua',
}

dependency 'es_extended'