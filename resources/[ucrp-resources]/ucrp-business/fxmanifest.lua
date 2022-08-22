





fx_version 'cerulean'
games { 'gta5' }

--[[ dependencies {
    "ucrp-lib",
    "ucrp-ui"
} ]]--

client_script "@ucrp-lib/client/cl_ui.lua"

client_scripts {
    '@ucrp-errorlog/client/cl_errorlog.lua',
    '@ucrp-lib/client/cl_rpc.lua',
    'client/cl_*.lua',
    "business/**/cl_*.lua",
    "business/**/config.lua",
}

shared_script {
  '@ucrp-lib/shared/sh_util.lua',
  'shared/sh_*.*',
}

server_scripts {
    'config.lua',
    '@ucrp-lib/server/sv_rpc.lua',
    '@ucrp-lib/server/sv_sql.lua',
    'server/sv_*.lua',
    "business/**/sv_*.lua",
}
