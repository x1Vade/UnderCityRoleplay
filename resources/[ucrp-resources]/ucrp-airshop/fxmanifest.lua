fx_version "cerulean"
games { "gta5" }

--[[ dependencies {
  "ucrp-polyzone",
  "ucrp-lib",
  "ucrp-ui"
} ]]--

client_script "@ucrp-lib/client/cl_ui.lua"

client_scripts {
  "@ucrp-lib/client/cl_rpc.lua",
  "@ucrp-locales/client/lib.lua",
  "client/cl_*.lua",
}

server_scripts {
  "@ucrp-lib/server/sv_asyncExports.lua",
  "@ucrp-lib/server/sv_rpc.lua",
  "server/sv_*.lua",
}
