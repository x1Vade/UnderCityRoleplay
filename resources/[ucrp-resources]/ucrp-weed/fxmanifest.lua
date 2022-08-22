








fx_version "cerulean"
games { "gta5" }

dependencies {
  "ucrp-lib",
  "PolyZone"
}

client_scripts {
  "@ucrp-sync/client/lib.lua",
  "@ucrp-lib/client/cl_ui.lua",
  "@ucrp-lib/client/cl_polyhooks.lua",
  "@ucrp-locales/client/lib.lua",
  "@ucrp-lib/client/cl_rpc.lua",
  "client/cl_*.lua",
  "@PolyZone/client.lua",
}

shared_script {
  "@ucrp-lib/shared/sh_util.lua",
  "shared/sh_*.*",
}

server_scripts {
  "@ucrp-lib/server/sv_rpc.lua",
  "@ucrp-lib/server/sv_sql.lua",
  "@ucrp-lib/server/sv_asyncExports.lua",
  "server/sv_*.lua",
  "server/sv_*.js",
}

ui_page "./ui/index.html"

files{
    "./ui/index.html",
    "./ui/main.css",
    "./ui/main.js",
}