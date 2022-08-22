





fx_version 'cerulean'
games {"gta5"}

description "actionbar"

client_scripts {
  "@ucrp-errorlog/client/cl_errorlog.lua",
  '@ucrp-lib/client/cl_rpc.lua',
  "client.lua",
}

shared_script {
  '@ucrp-lib/shared/sh_util.lua'
}

server_scripts {
  '@ucrp-lib/server/sv_rpc.lua',
  '@ucrp-lib/server/sv_sql.lua',
}