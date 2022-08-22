








fx_version 'cerulean'
games { 'gta5' }

--[[ dependencies {
  "ucrp-polyzone",
  "ucrp-lib",
  "ucrp-ui"
} ]]--

client_script "@ucrp-lib/client/cl_ui.lua"

client_scripts {
  '@ucrp-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
  'client/cl_*.js',
  "@PolyZone/client.lua",
  "@PolyZone/ComboZone.lua",
}

shared_script {
  '@ucrp-lib/shared/sh_util.lua',
  'shared/sh_*.*',
}

--server_script "@ucrp-lib/server/sv_npx.js"
server_scripts {
  '@ucrp-lib/server/sv_asyncExports.lua',
  '@ucrp-lib/server/sv_rpc.lua',
  '@ucrp-lib/server/sv_rpc.js',
  '@ucrp-lib/server/sv_sql.lua',
  '@ucrp-lib/server/sv_sql.js',
  'server/sv_*.lua',
  'server/sv_*.js',
}
