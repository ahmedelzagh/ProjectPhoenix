fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'International Systems'
description 'Weapon Smokes'
version '1.0.3'

shared_script 'config.lua'

client_scripts {
    'client/smoke_logic.lua',
    'client/client.lua'
}

server_scripts {
    'server/server.lua',
    'server/version/version_check.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/particles.js',
    'weapons.json',
    'html/img/*.png',
    'html/*.ogg'
}


escrow_ignore {
    'config.lua'
}
dependency '/assetpacks'