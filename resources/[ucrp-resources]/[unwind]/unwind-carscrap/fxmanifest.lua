fx_version "cerulean"

games {"gta5"}



server_scripts {
	'@ucrp-lib/server/sv_rpc.lua',
	"server/*.lua",
}

client_scripts {
	'@ucrp-lib/client/cl_rpc.lua',
	"client/*.lua",
}
