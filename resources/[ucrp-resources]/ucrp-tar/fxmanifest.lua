





fx_version "cerulean"

games {"gta5"}

description "Sanyo Interactions Target"


shared_scripts {
	"shared/*.lua"
}

server_scripts {
	"server/*.lua"
}
client_script "@ucrp-lib/client/cl_ui.lua"
client_scripts {
	"client/*.lua"
}


client_script "tests/cl_*.lua"
