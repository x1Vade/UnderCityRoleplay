





fx_version 'cerulean'

games {
    'gta5',
    'rdr3'
}

client_scripts {
  '@ucrp-lib/client/cl_rpc.lua',
  '@ucrp-lib/client/cl_ui.lua',
  '@ucrp-lib/client/cl_polyhooks.lua',
	'client/cl_*.lua'
}

shared_scripts {
  '@ucrp-lib/shared/sh_util.lua',
	"shared/*.lua"
}

server_scripts {
  '@ucrp-lib/server/sv_rpc.lua',
  '@ucrp-lib/server/sv_sql.lua',
	'server/*.lua'
}