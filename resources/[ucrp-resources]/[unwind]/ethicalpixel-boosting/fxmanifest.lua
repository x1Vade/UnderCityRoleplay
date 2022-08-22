fx_version 'cerulean'
games { 'gta5' }

client_scripts {
  '@ucrp-lib/client/cl_rpc.lua',
  'config.lua',
  'client/cl_*.lua',
}

server_scripts {
  --'@mysql-async/lib/MySQL.lua',
  '@ucrp-lib/server/sv_rpc.lua',
  'config.lua',
  'server/sv_*.lua',
}

ui_page 'ui/auth.html'

files {
  'ui/*'
}

lua54 'yes'
