








fx_version 'adamant'

game "gta5"

client_script "@ucrp-lib/client/cl_ui.lua"
client_script "@ucrp-lib/client/cl_rpc.lua"

client_scripts {
  '@ucrp-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
}

server_script "@ucrp-lib/server/sv_rpc.lua"
server_script "@ucrp-lib/server/sv_sql.lua"
server_scripts {
  'server/sv_*.lua',
  'server/sv_*.js',
}
