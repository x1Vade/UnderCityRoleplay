





fx_version 'cerulean'
games {'gta5'}

--client_script "@npx/client/lib.js"
--server_script "@npx/server/lib.js"
--shared_script "@npx/shared/lib.lua"

client_script "@ucrp-errorlog/client/cl_errorlog.lua"
client_script "@ucrp-sync/client/lib.lua"

server_script "@ucrp-lib/server/sv_asyncExports.lua"

shared_script "@ucrp-lib/shared/sh_util.lua"

client_scripts {
  '@ucrp-lib/client/cl_rpc.lua',
  'cl_*.lua'
}

server_scripts {
  '@ucrp-lib/server/sv_sql.lua',
  '@ucrp-lib/server/sv_rpc.lua',
  'sv_*.lua'
}
