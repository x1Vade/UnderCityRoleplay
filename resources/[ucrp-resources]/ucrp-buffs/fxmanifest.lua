fx_version 'cerulean'
game 'gta5'

description "Buffs"
author "Havocx"
version "0.0.1"

lua54 'yes'
use_fxv2_oal 'yes'

shared_scripts {
	'shared/config.lua',
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

dependencies {
	'ucrp-base'
}
