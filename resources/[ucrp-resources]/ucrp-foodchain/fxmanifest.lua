








fx_version 'cerulean'
games { 'gta5' }

--[[ dependencies {
  "ucrp-lib",
  "PolyZone",
  "ucrp-ui"
} ]]--

client_script "@ucrp-sync/client/lib.lua"
client_script "@ucrp-lib/client/cl_ui.lua"
client_script "@ucrp-lib/client/cl_polyhooks.lua"
client_script "@ucrp-locales/client/lib.lua"

client_scripts {
  '@ucrp-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
  "@PolyZone/client.lua",
  '@sanyo-lasers/client/client.lua',
}

shared_script {
  '@ucrp-lib/shared/sh_util.lua',
  'shared/sh_*.*',
}

server_scripts {
  '@ucrp-lib/server/sv_rpc.lua',
  '@ucrp-lib/server/sv_sql.lua',
  '@ucrp-lib/server/sv_asyncExports.lua',
  'server/sv_*.lua',
  'server/sv_*.js',
}
