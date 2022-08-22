








fx_version 'cerulean'
games { 'gta5' }

client_scripts {
  'shared/config.lua',
  'client/cl_*.lua',
  '@ucrp-errorlog/client/cl_errorlog.lua',
  '@ucrp-sync/client/lib.lua',
  '@ucrp-lib/client/cl_rpc.lua',
  '@ucrp-lib/client/cl_ui.lua',
  '@ucrp-lib/client/cl_animTask.lua',
}

server_scripts {
  '@ucrp-lib/server/sv_rpc.lua',
  '@ucrp-lib/server/sv_sql.lua',
  '@ucrp-lib/server/sv_sql.js',
  '@ucrp-lib/server/sv_asyncExports.js',
  '@ucrp-lib/server/sv_asyncExports.lua',
  'shared/config.lua',
  'server/sv_*.lua',
}
