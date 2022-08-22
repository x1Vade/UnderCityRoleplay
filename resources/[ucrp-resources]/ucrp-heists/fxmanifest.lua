








fx_version 'bodacious'
games { 'rdr3', 'gta5' }


client_scripts {
  '@ucrp-errorlog/client/cl_errorlog.lua',
  '@ucrp-sync/client/lib.lua',
  '@ucrp-lib/client/cl_rpc.lua',
  '@ucrp-lib/client/cl_ui.lua',
  '@ucrp-lib/client/cl_animTask.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/ComboZone.lua',
  '@sanyo-lasers/client/client.lua',
  '@sanyo-grapple/client.lua',
  'client/cl_*.lua',
  "config.lua", 
}

shared_script {
  '@ucrp-lib/shared/sh_util.lua',
  'shared/sh_*.*',
}

server_scripts {
  'config.lua',
  '@ucrp-lib/server/sv_rpc.lua',
  '@ucrp-lib/server/sv_sql.lua',
  '@ucrp-lib/server/sv_sql.js',
  '@ucrp-lib/server/sv_asyncExports.js',
  '@ucrp-lib/server/sv_asyncExports.lua',
  'server/sv_*.lua',
  "config.lua", 
}
