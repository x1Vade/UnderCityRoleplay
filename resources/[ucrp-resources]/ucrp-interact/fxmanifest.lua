





fx_version "cerulean"

games {"gta5"}

description "Sanyo Peek Interactions"

shared_scripts{
    "@ucrp-lib/shared/sh_util.lua",
    "shared/sh_*.lua",
}

server_scripts {
	"@ucrp-lib/server/sv_rpc.lua",
	"server/sv_*.lua",
}


client_script "@ucrp-locales/client/lib.lua"
client_script "@ucrp-lib/client/cl_ui.lua"


client_scripts{
	"@ucrp-lib/client/cl_rpc.lua",
    "@PolyZone/client.lua",
    "@PolyZone/BoxZone.lua",
    "@PolyZone/EntityZone.lua",
    "@PolyZone/CircleZone.lua",
    "@PolyZone/ComboZone.lua",
    "client/cl_*.lua",
    "client/entries/cl_*.lua",
}

ui_page "ui/index.html"
files{
    "ui/index.html",
    "ui/style.css",
    "ui/script.js",
    "ui/*.png"
}