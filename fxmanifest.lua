fx_version "cerulean"
game "gta5"

author "Cocodrulo"
version "1.0.0"
description "A megaphone resource for QBCore"

client_scripts {
    'client/custom/framework/*.lua',
    'client/custom/voice/*.lua',
    'client/main.lua'
}

server_scripts {
    'server/custom/framework/*.lua',
    'server/main.lua'
}

shared_scripts {
    'Config.lua',
    'locales/*.lua'
}
